FHIR uses the [Claim](https://hl7.org/fhir/R4/claim.html) resource for provider-submitted billing information, and [ExplanationOfBenefit](https://hl7.org/fhir/R4/explanationofbenefit.html) for the payer-adjudicated response. Measures reach into these resources for the [billing-related elements](pattern_billingrelated.html) that are not reliably available in the clinical record: whether a diagnosis was present on admission, which diagnosis was principal, and which procedure was primary.

[Claim](https://hl7.org/fhir/us/cql/en/patterns-claim.html) in the US CQL implementation guide covers [status, use, and type](https://hl7.org/fhir/us/cql/en/patterns-claim.html#status-use-and-type), [claim items](https://hl7.org/fhir/us/cql/en/patterns-claim.html#claim-items), [EoB items](https://hl7.org/fhir/us/cql/en/patterns-claim.html#eob-items), and a [mammography](https://hl7.org/fhir/us/cql/en/patterns-claim.html#mammography-claim) example. This page carries the patterns specific to quality measurement; see the [Pattern Index](pattern_index.html) for the full list.

For Claim, see also [modifier elements](https://hl7.org/fhir/us/cql/en/patterns-claim.html#modifier-elements), [search parameters](https://hl7.org/fhir/us/cql/en/patterns-claim.html#search-parameters), and [cross-version considerations](https://hl7.org/fhir/us/cql/en/patterns-claim.html#cross-version-considerations) in that guide.

> NOTE: The US Quality Core Claim and ClaimResponse profiles are both marked with an asterisk in the [US Quality Core profile list](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/profiles.html), meaning they are not part of that guide's conformance expectations. US Quality Core does not profile ExplanationOfBenefit at all, so logic reaching for adjudicated information works against the base FHIR resource.

### Claim elements used by measures

A claim relates to an encounter through its items, and carries diagnoses and procedures in parallel lists keyed by sequence:

| Element | Used for |
|----|----|
| `Claim.item.encounter` | Relating the claim to the encounter under consideration |
| `Claim.item.diagnosisSequence` / `Claim.item.procedureSequence` | Selecting the diagnoses and procedures that apply to that item |
| `Claim.diagnosis.diagnosis[x]` | The diagnosis itself, as a code or a reference to a Condition |
| `Claim.diagnosis.sequence` | Matching a diagnosis to an item's `diagnosisSequence` |
| `Claim.diagnosis.type` | Identifying the principal diagnosis |
| `Claim.diagnosis.onAdmission` | Whether the diagnosis was present on admission |
| `Claim.procedure.procedure[x]` | The procedure itself, as a code or a reference to a Procedure |
| `Claim.procedure.sequence` / `Claim.procedure.type` | Matching to an item, and identifying the primary procedure |
{: .grid}

Navigating that structure by hand is verbose, so CQMCommon provides fluent functions over an Encounter that do it:

| Function | Returns |
|----|----|
| `claimDiagnosis()` | The claim diagnosis elements for the given encounter |
| `principalDiagnosis()` | The claim diagnosis identified as principal |
| `hasPrincipalDiagnosisOf(valueSet)` | True if the principal diagnosis has a code in the given value set |
| `isDiagnosisPresentOnAdmission(diagnosisValueSet, poaValueSet)` | True if a diagnosis in the first value set is present on admission per the second |
| `principalProcedure()` | The claim procedure identified as primary |
{: .grid}

CQMCommon also declares the terminology these depend on: `Principal Diagnosis` (`principal` from the FHIR diagnosis type code system), `Primary procedure` (`primary` from the procedure type code system), and the CMS present-on-admission indicators `POA-Y`, `POA-N`, `POA-W`, `POA-1`, and `POA-U`.

> NOTE: `Claim.diagnosis.diagnosis[x]` and `Claim.procedure.procedure[x]` are choices of a CodeableConcept or a Reference, so logic must handle both. The CQMCommon functions do this by testing the code directly and, failing that, resolving the reference with `getCondition()`.

### Present on Admission

See [Present on admission](https://hl7.org/fhir/us/cql/en/patterns-claim.html#present-on-admission).

Whether a diagnosis was present on admission is recorded on the claim diagnosis as an indicator, using the CMS present-on-admission code system:

```cql
define "Encounter With Asthma Present On Admission":
  [USQualityCore.Encounter] E
    where E.isDiagnosisPresentOnAdmission("Asthma", "Present On Admission Indicators")
```

The second argument is a value set of present-on-admission indicator codes; CQMCommon declares the individual codes, from which such a value set can be composed. The function handles both representations of `Claim.diagnosis.diagnosis[x]`.

### Principal Diagnosis

See [Principal diagnosis](https://hl7.org/fhir/us/cql/en/patterns-claim.html#principal-diagnosis).

A principal diagnosis is the condition chiefly responsible for the patient's admission. On a claim it is identified by `diagnosis.type` carrying the `Principal Diagnosis` code:

```cql
define "Encounter With Principal Diagnosis Of Asthma":
  [USQualityCore.Encounter] E
    where E.hasPrincipalDiagnosisOf("Asthma")
```

Where the diagnosis element itself is needed rather than a value set test, `principalDiagnosis()` returns it, and `claimDiagnosis()` returns all claim diagnoses for the encounter.

### Primary Procedure

See [Primary procedure](https://hl7.org/fhir/us/cql/en/patterns-claim.html#principal-procedure).

The primary procedure is identified on the claim by `procedure.type` carrying the `Primary procedure` code, the display of `primary` in the FHIR procedure type code system. `principalProcedure()` returns the claim procedure element for an encounter:

```cql
define "Encounter With Principal Colonoscopy":
  [USQualityCore.Encounter] E
    let PrincipalProcedure: E.principalProcedure()
    where PrincipalProcedure.procedure in "Colonoscopy"
      or PrincipalProcedure.procedure.getProcedure().code in "Colonoscopy"

define fluent function getProcedure(reference FHIR.Reference):
  singleton from (
    [USQualityCore.Procedure] Procedure
      where reference.references(Procedure)
  )
```

Two gaps are worth noting for anyone writing this logic. CQMCommon defines `getCondition()` for resolving a claim diagnosis reference but has no `getProcedure()` counterpart, so the example declares one. And the US CQL guide documents a `hasPrincipalProcedureOf()` function, the procedure equivalent of `hasPrincipalDiagnosisOf()`, which CQMCommon does not define &mdash; so the code-or-reference choice is handled in the expression rather than by a library function.

> NOTE: This guide uses *primary procedure*, matching the `Primary procedure` code that identifies it, in contrast with *principal diagnosis*. The US CQL guide and the CQMCommon function name both use *principal* for the procedure; the concept is the same.

### Discharge Disposition

The discharge disposition is identified on the claim by `supportingInfo` carrying the `Discharge status` code. `dischargeStatus()` returns the value of the discharge disposition.

TODO: The `supportingInfo` element is the proper place for discharge disposition, C4BB has a slice for it, and PDex and PAS both use it, however, it is not clear how this can be tied to an encounter specifically, since supportingInfo is at the root of the Claim, and the encounter linking happens at the item level. So in the best case, you would have a single encounter on a single claim, but in the worst case, the result would need to account for the possibility of multiple claims as well as multiple encounters on the same claim.

Example of claim with a discharge status supportingInfo:

```json
"supportingInfo": [{
  "sequence": 1,
  "category": { "coding": [{
    "system": "http://hl7.org/fhir/us/carin-bb/CodeSystem/C4BBSupportingInfoType",
    "code": "discharge-status" }] },
  "code": { "coding": [{
    "system": "https://www.nubc.org/PatientDischargeStatus",
    "code": "01" }] }
}]
```
