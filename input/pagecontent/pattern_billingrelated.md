### Billing-related elements

Several data elements in the encounter and condition space are _billing-related elements_ that each have a representation in potentially multiple places in the record, depending on where an encounter is in the billing workflow. For example, whether a given diagnosis is _present on admission_ can be represented:

1. In the clinical record, associated with the encounter diagnosis directly
2. In the provider-submitted claim information, recorded as a specific indicator on a claim diagnosis
3. In the payer-adjudicated explanation of benefit information, recorded as a specific indicator on an EoB diagnosis

The patterns in this guidance allow for elements to be identified in each of these locations independently, allowing measure authors to select the element that best aligns with measure intent.

### Preferring claim information

Where a measure is willing to use either representation, the usual intent is to prefer the billing information when it is present, because it has been coded for reporting, and to fall back on the clinical record when it is not. That is expressed by testing whether the claim information exists at all, rather than whether the claim test succeeded &mdash; an encounter with no claim and an encounter whose claim says *no* are different answers:

```cql
define "<Element> Present":
  [USQualityCore.Encounter] E
    where if exists (E.claimDiagnosis())
      then <claim test>
      else <clinical test>
```

The examples below apply that shape to each element. Two cautions apply throughout. Whether the two representations share terminology varies by element, so check before reusing a value set across both branches. And because the fallback is per encounter rather than per measure, a population may end up mixing encounters answered from claims with encounters answered from the clinical record; where that matters, test the two sources separately instead.

### Present on Admission

The claim representation is `Claim.diagnosis.onAdmission`, reached with `isDiagnosisPresentOnAdmission()`; the clinical representation is the `presentOnAdmission` extension on `Encounter.diagnosis`.

```cql
define "Encounter With Asthma Present On Admission":
  [USQualityCore.Encounter] E
    where if exists (E.claimDiagnosis())
      then E.isDiagnosisPresentOnAdmission("Asthma", "Present On Admission Indicators")
      else exists (
        E.diagnosis D
          where D.condition.getCondition().code in "Asthma"
            and D.presentOnAdmission() in "Present On Admission Indicators"
      )
```

Both representations are bound to the same CMS present-on-admission indicator codes, so a single value set serves both branches.

### Principal Diagnosis

The claim representation identifies the principal diagnosis by `Claim.diagnosis.type`, reached with `hasPrincipalDiagnosisOf()`; the clinical representation uses `Encounter.diagnosis` with a `use` of billing and a `rank` of 1.

```cql
define "Encounter With Principal Diagnosis Of Asthma":
  [USQualityCore.Encounter] E
    where if exists (E.principalDiagnosis())
      then E.hasPrincipalDiagnosisOf("Asthma")
      else exists (
        E.diagnosis D
          where D.condition.getCondition().code in "Asthma"
            and D.use = FHIRCommon."Billing"
            and D.rank = 1
      )
```

Both branches ultimately test a diagnosis code, so the same value set serves both; what differs is how the principal diagnosis is singled out.

### Primary Procedure

The claim representation identifies the primary procedure by `Claim.procedure.type`, reached with `principalProcedure()`; the clinical representation uses `Encounter.diagnosis` with a `use` of billing and a `rank` of 1, where `condition` references a Procedure rather than a Condition.

```cql
define "Encounter With Primary Procedure Of Appendectomy":
  [USQualityCore.Encounter] E
    let PrimaryProcedure: E.principalProcedure()
    where if PrimaryProcedure is not null
      then PrimaryProcedure.procedure in "Appendectomy"
        or PrimaryProcedure.procedure.getProcedure().code in "Appendectomy"
      else exists (
        E.diagnosis D
          where D.condition.getProcedure().code in "Appendectomy"
            and D.use = FHIRCommon."Billing"
            and D.rank = 1
      )
```

As with principal diagnosis, both branches test a procedure code, so one value set serves both. Note that `principalProcedure()` returns the claim procedure element rather than a boolean, so the test is against the element itself and must account for `procedure[x]` being either a code or a reference.

### Discharge Disposition

The clinical representation is `Encounter.hospitalization.dischargeDisposition`:

```cql
define "Encounter With Discharge Disposition To Home":
  [USQualityCore.Encounter] E
    where E.hospitalization.dischargeDisposition in "Home Discharge Disposition Codes"
```

The fallback pattern is not yet available for this element. The claim representation carries discharge status in `Claim.supportingInfo`, which sits at the root of the Claim while encounter linking happens at the item level, so tying a discharge status to a particular encounter is unresolved &mdash; see the open question in [Claim](pattern_claim.html#discharge-disposition).

Note also that the two representations do not share terminology: the clinical element is bound to the [Clinical Discharge Disposition](https://terminology.hl7.org/7.1.0/en/ValueSet-clinical-discharge-disposition.html) value set, drawn from the HL7 discharge disposition code system, while claims carry NUBC patient discharge status codes. A measure using both would need a value set for each, and a mapping between them.
