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

The second argument is a value set of present-on-admission indicator codes; CQMCommon declares the individual codes so they can be referenced in logic specifically if needed. The function handles both representations of `Claim.diagnosis.diagnosis[x]`.

Note that there are multiple reasons that the present on admission indiciator for a given diagnosis may not be present on a given claim, including:

* The diagnosis is one of a set of ICD codes that are exempt from present on admission reporting
* The claim is for an encounter that is not in a setting where present on admission reporting is required by policy/regulation
* The diagnosis is for a congenital condition

For the clinical representation, see [Present on Admission](pattern_encounter.html#present-on-admission). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

#### Examples

Whether a diagnosis is present on admission is a key aspect of measure intent in CMS1028 - Severe Obstetric Complications:

```cql
define "Delivery Encounters With Severe Obstetric Complications Diagnosis Or Procedure Excluding Blood Transfusion":
  "Delivery Encounters At Greater Than Or Equal To 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.isDiagnosisPresentOnAdmission ( "Severe Maternal Morbidity Diagnoses", "Present on Admission is No or Unable To Determine" )
      or ( exists ( ["Procedure": "Severe Maternal Morbidity Procedures"] SMMProcedures
            where SMMProcedures.status = 'completed'
              and SMMProcedures.performed.toInterval ( ) starts during TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )
        )
      )
```

Although the information about whether a diagnosis is present on admission may be available in the encounter representation, the fact that the determination is explicitly made as part of billing results in more accurate data for this element, directly impacting the accuracy of the performance rate for the measure.

### Principal Diagnosis

See [Principal diagnosis](https://hl7.org/fhir/us/cql/en/patterns-claim.html#principal-diagnosis).

A principal diagnosis is the condition chiefly responsible for the patient's admission. On a claim it is identified by `diagnosis.type` carrying the `Principal Diagnosis` code:

```cql
define "Encounter With Principal Diagnosis Of Asthma":
  [USQualityCore.Encounter] E
    where E.hasPrincipalDiagnosisOf("Asthma")
```

Where the diagnosis element itself is needed rather than a value set test, `principalDiagnosis()` returns it, and `claimDiagnosis()` returns all claim diagnoses for the encounter.

For the clinical representation, see [Principal Diagnosis](pattern_encounter.html#principal-diagnosis). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

#### Examples

Whether an encounter has a principal diagnosis is a key aspect of measure intent in CMS108 - Venous Thromboembolism Prophylaxis:

```cql
define "Encounter With Principal Diagnosis Of Mental Disorder Or Stroke":
  VTE."Encounter With Age Range And Without VTE Diagnosis Or Obstetrical Conditions" QualifyingEncounter
    where QualifyingEncounter.hasPrincipalDiagnosisOf ( "Mental Health Diagnoses" )
      or QualifyingEncounter.hasPrincipalDiagnosisOf ( "Hemorrhagic Stroke" )
      or QualifyingEncounter.hasPrincipalDiagnosisOf ( "Ischemic Stroke" )
```

This definition is one of the allowable exclusions for the measure, directly impacting the performance rate of the measure.

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

For the clinical representation, see [Primary Procedure](pattern_encounter.html#primary-procedure). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

#### Examples

Whether an encounter has a principal procedure is a key aspect of measure intent for CMS108 - Venous Thromboembolism Prophylaxis:

```cql
define "Encounter With Principal Procedure Of Selected Surgery":
  VTE."Encounter With Age Range And Without VTE Diagnosis Or Obstetrical Conditions" QualifyingEncounter
    where QualifyingEncounter.hasPrincipalProcedureOf ( "General Surgery" )
      or QualifyingEncounter.hasPrincipalProcedureOf ( "Gynecological Surgery" )
      or QualifyingEncounter.hasPrincipalProcedureOf ( "Hip Fracture Surgery" )
      or QualifyingEncounter.hasPrincipalProcedureOf ( "Hip Replacement Surgery" )
      or QualifyingEncounter.hasPrincipalProcedureOf ( "Intracranial Neurosurgery" )
      or QualifyingEncounter.hasPrincipalProcedureOf ( "Knee Replacement Surgery" )
      or QualifyingEncounter.hasPrincipalProcedureOf ( "Urological Surgery" )
```

This definition is one of the allowable exclusions for the measure, directly impacting the performance rate of the measure.

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
    "code": "..." }] }
}]
```

For the clinical representation, see [Discharge Disposition](pattern_encounter.html#discharge-disposition). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Admission Source

The admission source is identified on the claim by `supportingInfo` carrying the `Point of origin` code. `pointOfOrigin()` returns the value of the point of origin.

Example of claim with a point of origin supportingInfo:

```json
"supportingInfo": [{
  "sequence": 1,
  "category": { "coding": [{
    "system": "http://hl7.org/fhir/us/carin-bb/CodeSystem/C4BBSupportingInfoType",
    "code": "point-of-origin" }] },
  "code": { "coding": [{
    "system": "https://www.nubc.org/CodeSystem/PointOfOrigin",
    "code": "..." }] }
}]
```

For the clinical representation, see [Admission Source](pattern_encounter.html#admission-source). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.
