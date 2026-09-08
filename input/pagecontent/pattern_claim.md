FHIR uses the [Claim](https://hl7.org/fhir/R4/claim.html) resource for provider-submitted billing information, and [FHIR.ExplanationOfBenefit](https://hl7.org/fhir/R4/explanationofbenefit.html) for the payer-adjudicated response. Measures reach into these resources for the [billing-related elements](pattern_billingrelated.html) that are not reliably available in the clinical record: whether a diagnosis was present on admission, which diagnosis was principal, and which procedure was primary.

The patterns on this page are built on the ClaimElements library, which unfolds a claim into flat elements keyed to the encounter they relate to. That approach supersedes the item-based patterns in [Claim](https://hl7.org/fhir/us/cql/en/patterns-claim.html) in the US CQL implementation guide &mdash; its [claim items](https://hl7.org/fhir/us/cql/en/patterns-claim.html#claim-items) and [EoB items](https://hl7.org/fhir/us/cql/en/patterns-claim.html#eob-items) definitions, and the [mammography](https://hl7.org/fhir/us/cql/en/patterns-claim.html#mammography-claim) example built on them, leave the caller to navigate the sequence-keyed diagnosis and procedure lists by hand. Use the element definitions below instead. See the [Pattern Index](pattern_index.html) for the full list of patterns.

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

Navigating that structure by hand is verbose, so the ClaimElements library unfolds it. Each definition returns a flat element carrying the claim-level context alongside the diagnosis or procedure, so measure logic filters rather than traverses:

| Definition | Returns |
|----|----|
| `Claim Item` | One element per claim item, carrying the claim it came from in a `claim` element, the claim-level fields projected directly, and the item's service details |
| `Claim Encounter Item` | The same, unfolded per referenced encounter |
| `Claim Diagnosis` | One element per claim diagnosis, with its sequence, type, and present-on-admission indicator |
| `Claim Item Diagnosis` | Each item joined to the diagnoses its `diagnosisSequence` selects |
| `Claim Procedure` | One element per claim procedure, with its sequence, type, and date |
| `Claim Item Procedure` | Each item joined to the procedures its `procedureSequence` selects |
{: .grid}

The ClaimCommon library supplies the predicates that go with them, for the selection tests that would otherwise be written inline:

| Function | Returns |
|----|----|
| `isActive()`, `isCancelled()`, `isDraft()`, `isEnteredInError()` | Whether a Claim or ExplanationOfBenefit has the given status |
| `isClaim()`, `isPreauthorization()`, `isPredetermination()` | Whether the resource has the given use |
| `isInstitutional()`, `isProfessional()`, `isPharmacy()`, `isOral()`, `isVision()` | Whether the resource has the given type |
| `isPrincipalDiagnosis()`, `isAdmittingDiagnosis()` | Whether a claim diagnosis type identifies a principal or admitting diagnosis |
| `isPrimaryProcedure()`, `isSecondaryProcedure()` | Whether a claim procedure type identifies a primary or secondary procedure |
| `dischargeStatus()`, `pointOfOrigin()` | The discharge status and point of origin carried in `supportingInfo` |
{: .grid}

Each status, use, and type predicate has a list-filtering counterpart without the `is` prefix, following the FHIRCommon convention. Claim and ExplanationOfBenefit are both supported; note that they do not share a status code system, though the codes in each are the same.

> NOTE: The status, use, and type predicates are typed to the Claim and ExplanationOfBenefit resources. Each `Claim Item` element carries the claim it came from in a `claim` element, so those predicates apply to the elements as well &mdash; `D.claim.isActive()` &mdash; along with `dischargeStatus()` and `pointOfOrigin()`, which the flattened fields do not carry. The claim-level fields are also projected onto each element directly, so `D.status` remains available where that reads better.

> NOTE: `Claim.diagnosis.diagnosis[x]` and `Claim.procedure.procedure[x]` are choices of a CodeableConcept or a Reference, so logic should handle both if there is an expectation that both will be present in the source data.

### Present on Admission

The ClaimElements library defines a "Claim Item Diagnosis" element that represents all the information associated with a diagnosis as it appears on a provider-submitted claim. Whether a diagnosis was present on admission is recorded on this claim diagnosis as an indicator, using the CMS present-on-admission code system:

```cql
define "Encounter With Asthma Present On Admission":
  [USQualityCore.Encounter] E
    with "Claim Item Diagnosis" D
      such that D.serviced during E.period
        and D.claim.isActive()
        and D.claim.isClaim()
        and D.diagnosis in "Asthma"
        and D.onAdmission in "Present On Admission Positive Indicators"
```

Note that there are multiple reasons that the present on admission indiciator for a given diagnosis may not be present on a given claim, including:

* The diagnosis is one of a set of ICD codes that are exempt from present on admission reporting
* The claim is for an encounter that is not in a setting where present on admission reporting is required by policy/regulation
* The diagnosis is for a congenital condition

For the clinical representation, see [Present on Admission](pattern_encounters.html#present-on-admission). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

#### Examples

##### CMS1028 - Severe Obstetric Complications

Whether a diagnosis is present on admission is a key aspect of measure intent in CMS1028 - Severe Obstetric Complications:

```cql
define "Delivery Encounters With Severe Obstetric Complications Diagnosis Or Procedure Excluding Blood Transfusion":
  "Delivery Encounters At Greater Than Or Equal To 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists (
      "Claim Item Diagnosis" ClaimDiagnosis
        such that ClaimDiagnosis.serviced during TwentyWeeksPlusEncounter.period
          and ClaimDiagnosis.claim.isActive()
          and ClaimDiagnosis.claim.isClaim()
          and ClaimDiagnosis.diagnosis in "Severe Maternal Morbidity Diagnoses"
          and ClaimDiagnosis.onAdmission in "Present on Admission is No or Unable To Determined"
    )
      or exists ( 
        [USQualityCore.Procedure: "Severe Maternal Morbidity Procedures"] SMMProcedures
          where SMMProcedures.status = 'completed'
            and SMMProcedures.performed.toInterval() starts during TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation()
      )
```

Although the information about whether a diagnosis is present on admission may be available in the encounter representation, the fact that the determination is explicitly made as part of billing results in more accurate data for this element, directly impacting the accuracy of the performance rate for the measure.

##### Patient Safety Measures

TODO: MUC 877

TODO: 1017

##### Other Examples

TODO: 1218, 832

### Principal Diagnosis

The ClaimElements library defines a "Claim Item Diagnosis" element that represents all the information associated with a diagnosis as it appears on a provider-submitted claim. A principal diagnosis is the condition chiefly responsible for the patient's admission. On a claim it is identified by `diagnosis.type` carrying the `Principal Diagnosis` code:

```cql
define "Encounter With Principal Diagnosis Of Asthma":
  [USQualityCore.Encounter] E
    with "Claim Item Diagnosis" ClaimDiagnosis
      such that ClaimDiagnosis.serviced during E.period
        and ClaimDiagnosis.claim.isActive()
        and ClaimDiagnosis.claim.isClaim()
        and ClaimDiagnosis.diagnosis in "Asthma"
        and ClaimDiagnosis.diagnosisType.isPrincipalDiagnosis()
```

For the clinical representation, see [Principal Diagnosis](pattern_encounters.html#principal-diagnosis). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

#### Examples

Whether an encounter has a principal diagnosis is a key aspect of measure intent in CMS108 - Venous Thromboembolism Prophylaxis:

```cql
define "Encounter With Principal Diagnosis Of Mental Disorder Or Stroke":
  VTE."Encounter With Age Range And Without VTE Diagnosis Or Obstetrical Conditions" QualifyingEncounter
    with "Claim Item Diagnosis" ClaimDiagnosis
      such that ClaimDiagnosis.serviced during QualifyingEncounter.period
        and ClaimDiagnosis.claim.isActive()
        and ClaimDiagnosis.claim.isClaim()
        and ClaimDiagnosis.diagnosisType.isPrincipalDiagnosis()
        and (
          ClaimDiagnosis.diagnosis in "Mental Health Diagnoses"
            or ClaimDiagnosis.diagnosis in "Hemorrhagic Stroke"
            or ClaimDiagnosis.diagnosis in "Ischemic Stroke"
        )
```

This definition is one of the allowable exclusions for the measure, directly impacting the performance rate of the measure.

### Primary Procedure

The ClaimElements library defines a "Claim Item Procedure" element that represents all the information associated with a procedure as it appears on a provider-submitted claim. The primary procedure is identified on the claim by `procedure.type` carrying the `Primary procedure` code, the display of `primary` in the FHIR procedure type code system:

```cql
define "Encounter With Principal Colonoscopy":
  [USQualityCore.Encounter] E
    with "Claim Item Procedure" ClaimProcedure
      such that ClaimProcedure.serviced during E.period
        and ClaimProcedure.claim.isActive()
        and ClaimProcedure.claim.isClaim()
        and ClaimProcedure.procedure in "Colonoscopy"
        and ClaimProcedure.procedureType.isPrimaryProcedure()
```

> NOTE: This guide uses *primary procedure*, though the term *principal procedure* is often encountered as well. The US CQL guide and the CQMCommon function name both use *principal* for the procedure; the concept is the same.

For the clinical representation, see [Primary Procedure](pattern_encounters.html#primary-procedure). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

#### Examples

Whether an encounter has a principal procedure is a key aspect of measure intent for CMS108 - Venous Thromboembolism Prophylaxis:

```cql
define "Encounter With Principal Procedure Of Selected Surgery":
  VTE."Encounter With Age Range And Without VTE Diagnosis Or Obstetrical Conditions" QualifyingEncounter
    with "Claim Item Procedure" ClaimProcedure
      such that ClaimProcedure.serviced during QualifyingEncounter.period
        and ClaimProcedure.claim.isActive()
        and ClaimProcedure.claim.isClaim()
        and ClaimProcedure.procedureType.isPrimaryProcedure()
        and (
          ClaimProcedure.procedure in "General Surgery"
            or ClaimProcedure.procedure in "Gynecological Surgery"
            or ClaimProcedure.procedure in "Hip Fracture Surgery"
            or ClaimProcedure.procedure in "Hip Replacement Surgery"
            or ClaimProcedure.procedure in "Intracranial Neruosurgery"
            or ClaimProcedure.procedure in "Knee Replacement Surgery"
            or ClaimProcedure.procedure in "Urological Surgery"
        )
```

This definition is one of the allowable exclusions for the measure, directly impacting the performance rate of the measure.

### Discharge Disposition

Within a claim, discharge disposition is represented with the `discharge-status` supporting information. The `dischargeStatus()` fluent function returns the discharge status for a given claim:

```cql
define "Encounter With Allowable Discharge Disposition":
  "Qualifying Encounter" Encounter
    with [FHIR.Claim] Claim
      such that Claim.billablePeriod includes Encounter.period
        and Claim.isActive()
        and Claim.isClaim()
        and (
          Claim.dischargeStatus() in "Discharge To Acute Care Facility"
            or Claim.dischargeStatus() in "Left Against Medical Advice"
            or Claim.dischargeStatus() in "Patient Expired"
            or Claim.dischargeStatus() in "Discharged to Home for Hospice Care"
            or Claim.dischargeStatus() in "Discharged to Health Care Facility for Hospice Care"
        )
```

For the clinical representation, see [Discharge Disposition](pattern_encounters.html#discharge-disposition). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Admission Source

Within a claim, admission source is represented with the `pointoforigin` supporting information. The `pointOfOrigin()` fluent function returns the point of origin for a given claim:

```cql
define "Encounter With Hospice Admission Source":
  "Qualifying Encounter" Encounter
   with [FHIR.Claim] Claim
     such that Claim.billablePeriod includes Encounter.period
       and Claim.isActive()
       and Claim.isClaim()
       and Claim.pointOfOrigin() in "Hospice Admission Source Codes"
```

For the clinical representation, see [Admission Source](pattern_encounters.html#admission-source). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.
