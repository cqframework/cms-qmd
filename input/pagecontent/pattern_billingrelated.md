### Billing-related elements

Several data elements in the encounter and condition space are _billing-related elements_ that each have a representation in potentially multiple places in the record, depending on where an encounter is in the billing workflow. For example, whether a given diagnosis is _present on admission_ can be represented:

1. In the clinical record, associated with the encounter diagnosis directly
2. In the provider-submitted claim information, recorded as a specific indicator on a claim diagnosis
3. In the payer-adjudicated explanation of benefit information, recorded as a specific indicator on an EoB diagnosis

The patterns in this guidance allow for elements to be identified in each of these locations independently, allowing measure authors to select the element that best aligns with measure intent.

### Preferring claim information

In the payer-adjudicated claim information (i.e. the ExplanationOfBenefit), these elements are preserved from whatever was submitted by the provider. Although other information is also present in the EoB, a payer will never modify the provider submitted information. In addition, payer-adjudicated claim information is typically not available until well after the encounter took place. The consequence of these considerations is that the most reliable available source for these elements is the claim data, either the provider-submitted, or the payer-adjudicated, whichever is available.

Where a measure is willing to use either the claim or clinical representation, the usual intent is to prefer the billing information when it is present, because it has been coded for reporting, and to fall back on the clinical record when it is not. That is expressed by testing whether the claim information exists at all, rather than whether the claim test succeeded &mdash; an encounter with no claim and an encounter whose claim says *no* are different answers:

```cql
define "<Element> Present":
  [USQualityCore.Encounter] E
    let claimDiagnosis: ("Claim Item Diagnosis" CID where CID.serviced during E.period and CID.claim.isActive() and CID.claim.isClaim())
    where if exists (claimDiagnosis)
      then <claim test>
      else <clinical test>
```

The examples below apply this pattern to each element. Two cautions apply throughout: First, whether the two representations share terminology varies by element, so check before reusing a value set across both branches. And second, because the fallback is per encounter rather than per measure, a population may end up mixing encounters answered from claims with encounters answered from the clinical record; where that matters, test the two sources separately instead.

### Evidence of Diagnosis during an Encounter

Provider-submitted claim information includes information about the diagnoses that are listed as part of the encounter. Measures that have access to clinical as well as provider-submitted claim information can look in the following places for evidence of diagnosis active during an encounter:

* ConditionEncounterDiagnosis - Linked to the encounter explicitly or temporally
* ConditionProblemsHealthConcerns - Active (i.e. prevalent) overlapping the encounter period
* Reason for visit - Stated on the encounter with a code or linked to a condition explicitly
* Claim diagnoses - Listed on the encounter explicitly or with a service date during the encounter period

```cql
define "Encounter With Asthma":
  [USQualityCore.Encounter] E
    where E.reasonCode in "Asthma"
      or exists (
        [FHIR.Condition: "Asthma"] C
          where C.prevalenceInterval() overlaps E.period
            or E.reasonReference.references(C)
            or C.encounter.references(E)
            or C.recordedDate during E.period
            or C.assertedDate() during E.period
      )
      or exists (
        "Claim Item Diagnosis" CID
          where CID.serviced during E.period
            and CID.diagnosis in "Asthma"
      )
```

The [claim representation](pattern_claim.html#evidence-of-diagnosis-during-an-encounter) is `Claim.diagnosis`, accessed through the "Claim Item Diagnosis" element; the [clinical representation](pattern_encounters.html#evidence-of-diagnosis-during-an-encounter) is the ConditionEncounterDiagnosis profile.

#### Examples

##### CMS1218

The following example illustrates the searching for evidence of Neuromuscular Disorder during an encounter using clinical and claims data:

```cql
define "Encounter With Neuromuscular Disorder":
  "Encounter With Surgery" E
    where E.reasonCode in "Neuromuscular Disorder"
      or exists (
        [USQualityCore.ConditionEncounterDiagnosis: "Neuromuscular Disorder"] D
          where D.encounter.references(E)
      )
      or exists (
        "Claim Item Diagnosis" C
          where (
            C.encounter.references(E)
              or C.serviced during E.period
              or C.claim.billablePeriod during E.period
          )
            and C.diagnosis in "Neuromuscular Disorder"
      )
```

### History of a Condition

Provider-submitted claim information can also be used to search for history of a condition. Measures that have access to clinical as well as provider-submitted claim information can look in the following places for history of a condition:

* Conditions - Whether encounter diagnoses or problem list items
* Reason for visit - Stated on any encounter
* Claim diagnoses

```cql
define "History Of Asthma":
  exists (
    [FHIR.Condition: "Asthma"] C
      where C.isVerified() // To ensure we are not looking at refuted
  )
    or exists (
      "Claim Item Diagnosis" D
        where D.diagnosis in "Asthma"
    )

```

The [claim representation](pattern_claim.html#history-of-a-condition) is `Claim.diagnosis`, accessed through the "Claim Item Diagnosis" element; the [clinical representation](pattern_conditions.html#history-of-a-condition) is the base Condition resource.

### Present on Admission

In the provider-submitted claim information, the onAdmission indicator is explicitly captured as part of assessment during the billing process by looking at the encounter and related information to make a post-encounter determination about whether the diagnosis was actually present on admission. In addition, this indicator carries explicit information about whether the diagnosis is considered known to be present or not present, versus whether additional information is needed, or a determination cannot be made.

The [claim representation](pattern_claim.html#present-on-admission) is `Claim.diagnosis.onAdmission`, accessed through the "Claim Item Diagnosis" element; the [clinical representation](pattern_encounters.html#present-on-admission) is the `presentOnAdmission` extension on `Encounter.diagnosis`.

```cql
define "Encounter With Asthma Present On Admission":
  [USQualityCore.Encounter] E
    let claimDiagnosis: ("Claim Item Diagnosis" CID where CID.serviced during E.period)
    where if exists (claimDiagnosis)
      then exists (
        claimDiagnosis CD
          where CD.diagnosis in "Asthma"
            and CD.onAdmission in "Present On Admission Positive Indicators"
      )
      else exists (
        E.diagnosis D
          with [FHIR.Condition: "Asthma"] C
            such that D.condition.references(C)
          where D.presentOnAdmission() in "Present On Admission Positive Indicators"
      )
```

Both representations are bound to the same CMS present-on-admission indicator codes, so a single value set serves both branches.

> Note that the `Encounter.diagnosis` element is _not_ profiled in the US Core Encounter profile in any version. Encounter diagnoses in US Core use the `Encounter.reasonCode` and `Encounter.reasonReference` elements, as well as the  `ConditionEncounterDiagnosis` profile, so this representation is not likely to be available in data sourced from US Core implementations.

### Principal Diagnosis

The [claim representation](pattern_claim.html#principal-diagnosis) identifies the principal diagnosis by `Claim.diagnosis.type`, accessed through the "Claim Item Diagnosis" element; the [clinical representation](pattern_encounters.html#principal-diagnosis) uses `Encounter.diagnosis` with a `use` of billing and a `rank` of 1.

```cql
define "Encounter With Principal Diagnosis Of Asthma":
  [USQualityCore.Encounter] E
    let claimDiagnosis: ("Claim Item Diagnosis" CID where CID.serviced during E.period)
    where if exists (claimDiagnosis)
      then exists (
        claimDiagnosis CD
          where CD.diagnosis in "Asthma"
            and CD.diagnosisType.isPrincipalDiagnosis()
      )
      else exists (
        E.diagnosis D
          with [FHIR.Condition: "Asthma"] C
            such that D.condition.references(C)
          where D.use = FHIRCommon."Billing"
            and D.rank = 1
      )
```

Both branches ultimately test a diagnosis code, so the same value set serves both; what differs is how the principal diagnosis is singled out.

> Note that the `Encounter.diagnosis` element is _not_ profiled in the US Core Encounter profile in any version. Encounter diagnoses in US Core use the `Encounter.reasonCode` and `Encounter.reasonReference` elements, as well as the  `ConditionEncounterDiagnosis` profile, so this representation is not likely to be available in data sourced from US Core implementations.

### Primary Procedure

The [claim representation](pattern_claim.html#primary-procedure) identifies the primary procedure by `Claim.procedure.type`, accessed through the "Claim Item Procedure" element; the [clinical representation](pattern_encounters.html#primary-procedure) uses `Encounter.diagnosis` with a `use` of billing and a `rank` of 1, where `condition` references a Procedure rather than a Condition.

```cql
define "Encounter With Primary Procedure Of Appendectomy":
  [USQualityCore.Encounter] E
    let claimProcedure: ("Claim Item Procedure" CIP where CIP.serviced during E.period)
    where if exists (claimProcedure)
      then exists (
        claimProcedure CP
          where CP.procedure in "Appendectomy"
            and CP.type.isPrimaryProcedure()
      )
      else exists (
        E.diagnosis D
          with [FHIR.Procedure: "Appendectomy"] P
            such that D.condition.references(P)
          where D.use = FHIRCommon."Billing"
            and D.rank = 1
      )
```

As with principal diagnosis, both branches test a procedure code, so one value set serves both.

> Note that the `Encounter.diagnosis` element is _not_ profiled in the US Core Encounter profile in any version. Encounter diagnoses in US Core use the `Encounter.reasonCode` and `Encounter.reasonReference` elements, as well as the  `ConditionEncounterDiagnosis` profile, so this representation is not likely to be available in data sourced from US Core implementations.

### Discharge Disposition

The [clinical representation](pattern_encounters.html#discharge-disposition) is `Encounter.hospitalization.dischargeDisposition`:

```cql
define "Encounter With Discharge Disposition To Home":
  [USQualityCore.Encounter] E
    where E.hospitalization.dischargeDisposition in "Home Discharge Disposition Codes"
```

The [claim representation](pattern_claim.html#discharge-disposition) carries discharge status in `Claim.supportingInfo`, reached with `dischargeStatus()` in ClaimCommon. Because `supportingInfo` sits at the root of the Claim while encounter linking happens at the item level, the claim is related to the encounter by billable period rather than by item, so a claim covering more than one encounter cannot attribute a discharge status to a particular one:

```cql
define "Encounter With Discharge Disposition To Home":
  "Qualifying Encounter" E
    let claim: ([USQualityCore.Claim] C where C.billablePeriod includes E.period)
    where if exists (claim)
      then exists (claim C where C.dischargeStatus() in "NUBC Home Discharge Status Codes")
      else E.hospitalization.dischargeDisposition in "Home Discharge Disposition Codes"
```

Note also that the two representations do not share terminology: the clinical element is bound to the [Clinical Discharge Disposition](https://terminology.hl7.org/7.1.0/en/ValueSet-clinical-discharge-disposition.html) value set, drawn from the HL7 discharge disposition code system, while claims carry NUBC patient discharge status codes. A measure using both would need a value set for each, and a mapping between them.

### Admission Source

The [clinical representation](pattern_encounters.html#admission-source) is `Encounter.hospitalization.admitSource`.

The [claim representation](pattern_claim.html#admission-source) carries admission source in `Claim.supportingInfo`, reached with `pointOfOrigin()` in ClaimCommon. As with discharge disposition, `supportingInfo` sits at the root of the Claim while encounter linking happens at the item level, so the claim is related to the encounter by billable period:

```cql
define "Encounter With Hospice Admission Source":
  "Qualifying Encounter" E
    let claim: ([USQualityCore.Claim] C where C.billablePeriod includes E.period)
    where if exists (claim)
      then exists (claim C where C.pointOfOrigin() in "Hospice Admission Source Codes")
      else E.hospitalization.admitSource in "Hospice Admit Source Codes"
```

As with discharge disposition, the two representations do not share terminology: the clinical element is bound to the FHIR admit source value set, while claims carry NUBC point of origin codes.

