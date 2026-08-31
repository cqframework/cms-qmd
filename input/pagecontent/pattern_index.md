{:toc}

{: #Pattern-Index}

This page indexes the data elements and authoring patterns available to CMS dQM developers, across both this guide and the [US CQL](https://hl7.org/fhir/us/cql/en/patterns.html) implementation guide. It is intended as the single starting point for locating guidance on a given data element.

Each pattern is listed once. Where this guide documents a pattern, the link goes here, and that page links on to the underlying US CQL guidance where it exists. Where a pattern is documented only in the US CQL guide, the link goes there directly.

> NOTE: The patterns in this guide are authored against [US Quality Core 0.5.0](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/), while the US CQL patterns are authored against US Core directly. Retrieves therefore differ in the model qualifier &mdash; `[USQualityCore.AllergyIntolerance]` here, `[USCore.AllergyIntolerance]` there &mdash; but the element-level guidance applies to both. See [Authoring against the US Quality Core model](pattern_fhir.html#authoring-against-the-us-quality-core-model).

Each pattern page opens with a link to the modifier elements, search parameters, and cross-version considerations for its resource in the US CQL guide, where those apply. General guidance that applies across all resources &mdash; element cardinality, must support, modifier elements, implicit rules, accessing data, and naming &mdash; is covered in [Overall Patterns](https://hl7.org/fhir/us/cql/en/patterns-overall.html) in the US CQL guide and, for quality measures specifically, in [FHIR Patterns](pattern_fhir.html). Documentation of events that did not occur is covered in [Negation Patterns](pattern_negation.html).

### Patient

| Pattern | Description |
|----|----|
| [Patient age](pattern_patient.html#patient-age) | Age calculated as of a specific date, usually the start of the measurement period, and the precision pitfalls of the DateTime overloads. |
| [Patient race and ethnicity](pattern_patient.html#patient-race-and-ethnicity) | Reading the US Core race and ethnicity extensions through the `race()` and `ethnicity()` fluent functions, and the tuple each returns. |
| [Patient name](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-name) | Accessing a patient's name. |
| [Patient birth date](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-birthdate) | Accessing the birth date directly rather than through an age calculation. |
| [Patient gender](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-gender) | The administrative gender element and its required binding. |
| [Patient sex](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-sex) | `birthSex()`, the deprecated `sex()`, and the forward-compatible `individualSex()`. |
| [Patient deceased](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-deceased) | The deceased choice element, as either a boolean or a date and time. |
{: .grid}

### Allergies and intolerances

| Pattern | Description |
|----|----|
| [Current allergies](pattern_allergies.html#current-allergies) | Retrieving allergies to a substance, and why `isActive()` is unsafe for the retrospective evaluation a measure performs. |
| [No known allergies](pattern_allergies.html#no-known-allergies) | The confirmed and not-asked forms of a no-known-allergy assertion, and which one a measure should use. |
| [Clinical and verification status](pattern_allergies.html#verified-allergies) | The FHIRCommon verification-status functions, in place of re-declaring them locally. |
| [Onset, abatement, and prevalence interval](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#onset-abatement-and-prevalence-interval) | Computing a prevalence interval from onset, abatement, and resolution age &mdash; the reliable way to establish that an allergy was active during a period. |
| [Allergy examples](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#examples) | Worked examples for contrast dye, egg, and nut allergies. |
{: .grid}

### Conditions

| Pattern | Description |
|----|----|
| [Active conditions](pattern_conditions.html#active-conditions) | Retrieving active conditions, the category functions that distinguish problem list items from encounter diagnoses, and the retrospective caveat on `isActive()`. |
| [Verified conditions](pattern_conditions.html#verified-conditions) | Excluding refuted and entered-in-error conditions using the FHIRCommon verification-status functions. |
| [History of a condition](pattern_conditions.html#history-of-a-condition) | Unioning the two condition profiles, since US Quality Core profiles problem list items and encounter diagnoses separately. |
| [Onset, abatement, and prevalence period](pattern_conditions.html#onset-abatement-and-prevalence-period) | `prevalenceInterval()` and `abatementInterval()`, and why they are preferred over `clinicalStatus` for a question about a period. |
| [Diagnosis during an encounter](pattern_conditions.html#encounters-with-a-condition) | Establishing that a diagnosis was active during an encounter across `reasonCode`, `reasonReference`, and claim diagnoses. |
| [Condition category](https://hl7.org/fhir/us/cql/en/patterns-condition.html#category) | Distinguishing problem list items, health concerns, and encounter diagnoses. |
| [Relevant condition](https://hl7.org/fhir/us/cql/en/patterns-condition.html#relevant-condition) | Taking the condition from workflow context rather than searching for it. |
{: .grid}

### Encounters

| Pattern | Description |
|----|----|
| [Office visit encounters](pattern_encounters.html#office-visit-encounters) | Characterizing encounters by `type` with a value set. |
| [Encounters by direct-reference code](pattern_encounters.html#accessing-encounters-with-a-direct-reference-code) | Why a direct-reference code cannot filter the multi-cardinality `type` element in a retrieve, and the two workarounds. |
| [Encounters by class](pattern_encounters.html#encounters-by-class) | Filtering by `class`, which is required in US Core and single-cardinality, and why it is the preferred first filter. |
| [Completed encounters in a period](pattern_encounters.html#completed-encounters-in-a-period) | Filtering on `status` and `period` together. |
| [Encounters of a certain length](pattern_encounters.html#encounters-with-a-certain-length) | `lengthInDays()` and direct duration calculations, and what an absent period end implies. |
| [Hospitalization](pattern_encounters.html#hospitalization) | The fourteen CQMCommon functions spanning an inpatient stay and any immediately prior emergency department or observation encounter. |
{: .grid}

### Observations

| Pattern | Description |
|----|----|
| [Vital signs](pattern_observations.html#vital-signs) | Retrieving each US Core vital sign profile, and reading blood pressure components through `systolic()` and `diastolic()`. |
| [Laboratory results](pattern_observations.html#laboratory-result) | The laboratory result profile, characterized by `code` with `category` fixed to laboratory. |
| [Clinical results](pattern_observations.html#clinical-result) | Non-laboratory clinical test results, including measurements obtained from imaging. |
| [Screening and assessment](pattern_observations.html#surveys-and-assessments) | Survey observations, including panels and multi-select answers. |
| [Simple observations](pattern_observations.html#simple-observations) | Observations not covered by a more specific profile, and why the status test matters more here. |
| [Pregnancy status](pattern_observations.html#pregnancy-status) | Establishing pregnancy across an observation, a laboratory result, an encounter diagnosis, and a problem list item. |
| [Pregnancy intent](pattern_observations.html#pregnancy-intent) | Intent to become pregnant within the next year. |
| [Smoking status](pattern_observations.html#smoking-status) | The US Core smoking status profile. |
| [Non-patient observations](pattern_observations.html#observations-non-patient) | Observations about resource use and availability rather than a patient. |
| [Observations not done](pattern_observations.html#observations-not-done) | Representing an observation that was not performed, as a rejected proposal. |
| [Observation status](https://hl7.org/fhir/us/cql/en/patterns-observation.html#status) | `isResulted()` and the individual status predicates, in place of inline status lists. |
| [Observation category](https://hl7.org/fhir/us/cql/en/patterns-observation.html#category) | The category functions, including `isLaboratory()`, `isVitalSign()`, and `isSurvey()`. |
| [Interpretation](https://hl7.org/fhir/us/cql/en/patterns-observation.html#interpretation) | The `positive()` and `negative()` filters, and why the element cannot be relied on. |
| [Timings](https://hl7.org/fhir/us/cql/en/patterns-observation.html#timings) | Filtering and ordering observations by effective time, including specimen collection time. |
| [Observation elements](https://hl7.org/fhir/us/cql/en/patterns-observation.html#observation-elements) | The elements common across the observation profiles. |
| [Other observations](https://hl7.org/fhir/us/cql/en/patterns-observation.html#other-observations) | Observations outside the profiled categories. |
{: .grid}

### Services and procedures

| Pattern | Description |
|----|----|
| [Procedure performed](pattern_procedures.html#procedure-performed) | Retrieving a completed procedure, and accounting for the unconstrained `status`. |
| [Procedure ordered](pattern_procedures.html#procedure-ordered) | Retrieving a service request, excluding rejected proposals, and choosing ServiceRequest over DeviceRequest. |
| [Procedure not done](pattern_procedures.html#procedure-not-done) | Documenting the reason a procedure was not performed. |
| [Procedure not ordered](pattern_procedures.html#procedure-not-ordered) | Distinguishing a prohibition from the rejection of a proposal. |
| [Imaging procedures](pattern_procedures.html#imaging-procedures) | How far to look for evidence of an imaging procedure across order, procedure, report, and study. |
| [Mammography](https://hl7.org/fhir/us/cql/en/patterns-service.html#mammography) | A worked example spanning the resources that may record a mammogram. |
{: .grid}

### Medications

| Pattern | Description |
|----|----|
| [Medication status and intent](pattern_medications.html#medication-status-and-intent) | The status and intent functions drafted in MedicationCommon, in place of inline code lists. |
| [Medication ordered](pattern_medications.html#medication-ordered) | Retrieving a medication order, including the guard against a rejected proposal. |
| [Medication administered](pattern_medications.html#medication-administered) | Retrieving a completed administration. |
| [Medication dispensed](pattern_medications.html#medication-dispensed) | Retrieving any positive dispensing event. |
| [Medication in use](pattern_medications.html#medication-in-use) | Medications a patient is taking outside the hospital setting. |
| [Self-administered OTCs](pattern_medications.html#self-administered-otcs) | Over-the-counter medications, distinguished by category rather than code. |
| [Medication not ordered](pattern_medications.html#medication-not-ordered) | A documented prohibition, and how it differs from a rejected proposal. |
| [Medication not administered](pattern_medications.html#medication-not-administered) | Documenting the reason an administration did not occur. |
| [Medication not dispensed](pattern_medications.html#medication-not-dispensed) | Documenting the reason a dispense did not occur. |
| [Electronically transmitted prescriptions](https://hl7.org/fhir/us/cql/en/patterns-medication.html#electronically-transmitted-prescriptions) | Identifying the transmission method of a prescription through the PDMP extension. |
{: .grid}

### Devices

| Pattern | Description |
|----|----|
| [Device ordered](pattern_devices.html#device-ordered) | Ordering a patient-use device, and when ServiceRequest is the right profile instead. |
| [Device in use](pattern_devices.html#device-in-use) | Establishing that a device is actually in use rather than ordered. |
| [Device not ordered](pattern_devices.html#device-not-ordered) | A documented prohibition, and the rejected-proposal alternative. |
{: .grid}

### Immunizations

| Pattern | Description |
|----|----|
| [Immunization performed](pattern_immunizations.html#immunization-performed) | Retrieving an administered immunization by `vaccineCode`. |
| [Immunization not performed](pattern_immunizations.html#immunization-not-performed) | Documenting the reason an immunization was not administered. |
{: .grid}

### Communication

| Pattern | Description |
|----|----|
| [Communication](pattern_communication.html#communication) | Information transmitted about or with the patient, and when Procedure is the better choice. |
| [Communication not done](pattern_communication.html#communication-not-done) | Documenting the reason a communication did not occur. |
{: .grid}

### Billing-related elements

| Pattern | Description |
|----|----|
| [Billing-related elements](pattern_billingrelated.html) | Why these elements have several representations, and how to choose between the clinical record, the claim, and the adjudicated response. |
| [Preferring claim information](pattern_billingrelated.html#preferring-claim-information) | The shape for using claim information when it is present and falling back on the clinical record when it is not. |
| [Present on admission](pattern_billingrelated.html#present-on-admission) | Whether a diagnosis was present at admission, on the claim and in the clinical record; both use the same CMS indicator codes. |
| [Principal diagnosis](pattern_billingrelated.html#principal-diagnosis) | The diagnosis chiefly responsible for the admission, identified by claim diagnosis type or by encounter diagnosis rank. |
| [Primary procedure](pattern_billingrelated.html#primary-procedure) | The procedure identified as primary, on the claim and in the clinical record. |
| [Discharge disposition](pattern_billingrelated.html#discharge-disposition) | Where the patient went after the encounter; the two representations use different code systems and the claim side has an open question. |
{: .grid}

### Claims and coverage

| Pattern | Description |
|----|----|
| [Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) | How a claim relates to an encounter, and the CQMCommon functions that navigate the sequence-keyed diagnosis and procedure lists. |
| [Coverage status](pattern_coverage.html#coverage-status) | Restricting to active coverage, the only modifier element on the resource. |
| [Member or subscriber ID](pattern_coverage.html#member-or-subscriber-id) | `memberID()` and `policyNumber()`, and the invariant requiring one of them. |
| [Payer](pattern_coverage.html#payer) | `SDE Payer` for supplemental data reporting, and the status filter it omits. |
| [Claim status, use, and type](https://hl7.org/fhir/us/cql/en/patterns-claim.html#status-use-and-type) | The functions that select active professional or institutional claims and explanations of benefit. |
| [Claim items](https://hl7.org/fhir/us/cql/en/patterns-claim.html#claim-items) | Selecting the items of a claim. |
| [Explanation of Benefit items](https://hl7.org/fhir/us/cql/en/patterns-claim.html#eob-items) | Selecting the items of an adjudicated response. |
| [Mammography claim](https://hl7.org/fhir/us/cql/en/patterns-claim.html#mammography-claim) | A worked example over claim and EoB items. |
{: .grid}
