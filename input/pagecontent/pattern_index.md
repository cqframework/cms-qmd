{:toc}

{: #Pattern-Index}

This page indexes the data elements and authoring patterns available to CMS dQM developers, across both this guide and the [US CQL](https://hl7.org/fhir/us/cql/en/patterns.html) implementation guide. It is intended as the single starting point for locating guidance on a given data element.

Patterns are documented once. Where the US CQL guide already covers a data element, this guide links to it rather than restating it, and adds a note only where measure development calls for something different. Where a pattern is specific to quality measurement &mdash; negation in particular &mdash; it is documented in this guide.

Reading the tables below:

* A link in both columns means the US CQL guide documents the pattern and this guide adds a measure-specific note.
* A link in the **US CQL 2.0.0** column alone means that guide is the complete reference; there is nothing measure-specific to add.
* A link in the **CMS dQM guidance** column alone means the pattern is specific to quality measurement, or covers a resource the US CQL guide does not yet address.

> NOTE: The patterns in this guide are authored against [US Quality Core 0.5.0](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/), while the US CQL patterns are authored against US Core directly. Retrieves therefore differ in the model qualifier &mdash; `[USQualityCore.AllergyIntolerance]` here, `[USCore.AllergyIntolerance]` there &mdash; but the element-level guidance applies to both. See [Authoring against the US Quality Core model](pattern_fhir.html#authoring-against-the-us-quality-core-model).

### Resource-level guidance

Each US CQL resource page opens with three sections that apply to every pattern for that resource, and are not repeated in the tables below.

| Resource | Modifier elements | Search parameters | Cross-version considerations |
|----|----|----|----|
| Patient | [Modifier elements](https://hl7.org/fhir/us/cql/en/patterns-patient.html#modifier-elements) | [Search parameters](https://hl7.org/fhir/us/cql/en/patterns-patient.html#search-parameters) | [Cross-version](https://hl7.org/fhir/us/cql/en/patterns-patient.html#cross-version-considerations) |
| AllergyIntolerance | [Modifier elements](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#modifier-elements) | [Search parameters](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#search-parameters) | [Cross-version](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#cross-version-considerations) |
| Condition | [Modifier elements](https://hl7.org/fhir/us/cql/en/patterns-condition.html#modifier-elements) | [Search parameters](https://hl7.org/fhir/us/cql/en/patterns-condition.html#search-parameters) | [Cross-version](https://hl7.org/fhir/us/cql/en/patterns-condition.html#cross-version-considerations) |
| Observation | [Modifier elements](https://hl7.org/fhir/us/cql/en/patterns-observation.html#modifier-elements) | [Search parameters](https://hl7.org/fhir/us/cql/en/patterns-observation.html#search-parameters) | [Cross-version](https://hl7.org/fhir/us/cql/en/patterns-observation.html#cross-version-considerations) |
| ServiceRequest and Procedure | [Modifier elements](https://hl7.org/fhir/us/cql/en/patterns-service.html#modifier-elements) | [Search parameters](https://hl7.org/fhir/us/cql/en/patterns-service.html#search-parameters) | [Cross-version](https://hl7.org/fhir/us/cql/en/patterns-service.html#cross-version-considerations) |
| Medication | [Modifier elements](https://hl7.org/fhir/us/cql/en/patterns-medication.html#modifier-elements) | [Search parameters](https://hl7.org/fhir/us/cql/en/patterns-medication.html#search-parameters) | [Cross-version](https://hl7.org/fhir/us/cql/en/patterns-medication.html#cross-version-considerations) |
| Claim | [Modifier elements](https://hl7.org/fhir/us/cql/en/patterns-claim.html#modifier-elements) | [Search parameters](https://hl7.org/fhir/us/cql/en/patterns-claim.html#search-parameters) | [Cross-version](https://hl7.org/fhir/us/cql/en/patterns-claim.html#cross-version-considerations) |
| Coverage | [Modifier elements](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#modifier-elements) | [Search parameters](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#search-parameters) | [Cross-version](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#cross-version-considerations) |

General guidance that applies across all resources &mdash; element cardinality, must support, modifier elements, implicit rules, accessing data, and naming &mdash; is covered in [Overall Patterns](https://hl7.org/fhir/us/cql/en/patterns-overall.html) in the US CQL guide and, for quality measures specifically, in [FHIR Patterns](pattern_fhir.html). Documentation of events that did not occur is covered in [Negation Patterns](pattern_negation.html).

### Patient

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Patient name | [Patient name](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-name) | &mdash; |
| Patient birth date | [Patient birthDate](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-birthdate) | &mdash; |
| Patient age | [Patient age](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-age) | [Patient age](pattern_patient.html#patient-age) |
| Patient gender | [Patient gender](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-gender) | &mdash; |
| Patient sex | [Patient sex](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-sex) | &mdash; |
| Patient race and ethnicity | [Patient race and ethnicity](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-race-and-ethnicity) | [Patient race and ethnicity](pattern_patient.html#patient-race-and-ethnicity) |
| Patient deceased | [Patient deceased](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-deceased) | &mdash; |

### Allergies and intolerances

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Current allergies | [Current allergies](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#current-allergies) | [Current Allergies](pattern_allergies.html#current-allergies) |
| No known allergies | [No known allergies](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#no-known-allergies) | [No Known Allergies](pattern_allergies.html#no-known-allergies) |
| Clinical and verification status | [Clinical and verification status](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#clinical-and-verification-status) | [Verified Allergies](pattern_allergies.html#verified-allergies) |
| Onset, abatement, and prevalence interval | [Onset, abatement, and prevalence interval](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#onset-abatement-and-prevalence-interval) | &mdash; |
| Worked examples (contrast dye, egg, nut) | [Examples](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#examples) | &mdash; |

### Conditions

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Active conditions | [Active conditions](https://hl7.org/fhir/us/cql/en/patterns-condition.html#active-conditions) | [Active conditions](pattern_conditions.html#active-conditions) |
| Verified conditions | [Verified conditions](https://hl7.org/fhir/us/cql/en/patterns-condition.html#verified-conditions) | [Verified Conditions](pattern_conditions.html#verified-conditions) |
| Historical conditions | [Historical conditions](https://hl7.org/fhir/us/cql/en/patterns-condition.html#historical-conditions) | [History of a condition](pattern_conditions.html#history-of-a-condition) |
| Onset, abatement, and prevalence period | [Onset, abatement, and prevalence period](https://hl7.org/fhir/us/cql/en/patterns-condition.html#onset-abatement-and-prevalence-period) | [Onset, abatement, and prevalence period](pattern_conditions.html#onset-abatement-and-prevalence-period) |
| Discharge disposition | &mdash; | [Discharge Disposition](pattern_claim.html#discharge-disposition) (claim), [Discharge Disposition](pattern_encounters.html#discharge-disposition) (clinical), [Discharge Disposition](pattern_billingrelated.html#discharge-disposition) (combined) |
| Diagnosis during an encounter | [Evidence of diagnosis during an encounter](https://hl7.org/fhir/us/cql/en/patterns-condition.html#evidence-of-diagnosis-during-an-encounter) | [Encounters with a condition](pattern_conditions.html#encounters-with-a-condition) |
| Condition category | [Category](https://hl7.org/fhir/us/cql/en/patterns-condition.html#category) | &mdash; |
| Relevant condition | [Relevant condition](https://hl7.org/fhir/us/cql/en/patterns-condition.html#relevant-condition) | &mdash; |
| Present on admission | [Present on admission](https://hl7.org/fhir/us/cql/en/patterns-claim.html#present-on-admission) | [Present on Admission](pattern_claim.html#present-on-admission) (claim), [Present on Admission](pattern_encounters.html#present-on-admission) (clinical), [Present on Admission](pattern_billingrelated.html#present-on-admission) (combined) |
| Principal diagnosis | [Principal diagnosis](https://hl7.org/fhir/us/cql/en/patterns-claim.html#principal-diagnosis) | [Principal Diagnosis](pattern_claim.html#principal-diagnosis) (claim), [Principal Diagnosis](pattern_encounters.html#principal-diagnosis) (clinical), [Principal Diagnosis](pattern_billingrelated.html#principal-diagnosis) (combined) |

### Observations

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Vital signs | [Vital signs](https://hl7.org/fhir/us/cql/en/patterns-observation.html#vital-signs) | [Vital Signs](pattern_observations.html#vital-signs) |
| Clinical results | [Clinical results](https://hl7.org/fhir/us/cql/en/patterns-observation.html#clinical-results-1) | [Clinical Result](pattern_observations.html#clinical-result) |
| Laboratory results | [Laboratory results](https://hl7.org/fhir/us/cql/en/patterns-observation.html#laboratory-results) | [Laboratory Result](pattern_observations.html#laboratory-result) |
| Screening and assessment | [Screening assessments](https://hl7.org/fhir/us/cql/en/patterns-observation.html#screening-assessments) | [Surveys and Assessments](pattern_observations.html#surveys-and-assessments) |
| Simple observations | [Simple observations](https://hl7.org/fhir/us/cql/en/patterns-observation.html#simple-observations) | [Simple Observations](pattern_observations.html#simple-observations) |
| Pregnancy status | [Pregnancy status](https://hl7.org/fhir/us/cql/en/patterns-observation.html#pregnancy-status) | [Pregnancy Status](pattern_observations.html#pregnancy-status) |
| Pregnancy intent | [Pregnancy intent](https://hl7.org/fhir/us/cql/en/patterns-observation.html#pregnancy-intent) | [Pregnancy Intent](pattern_observations.html#pregnancy-intent) |
| Observation status | [Status](https://hl7.org/fhir/us/cql/en/patterns-observation.html#status) | &mdash; |
| Observation category | [Category](https://hl7.org/fhir/us/cql/en/patterns-observation.html#category) | &mdash; |
| Interpretation | [Interpretation](https://hl7.org/fhir/us/cql/en/patterns-observation.html#interpretation) | &mdash; |
| Timings and specimen collection time | [Timings](https://hl7.org/fhir/us/cql/en/patterns-observation.html#timings) | &mdash; |
| Observation elements | [Observation elements](https://hl7.org/fhir/us/cql/en/patterns-observation.html#observation-elements) | &mdash; |
| Other observations | [Other observations](https://hl7.org/fhir/us/cql/en/patterns-observation.html#other-observations) | &mdash; |
| Smoking status | &mdash; | [Smoking Status](pattern_observations.html#smoking-status) |
| Non-patient observations | &mdash; | [Observations Non-Patient](pattern_observations.html#observations-non-patient) |
| Observations not done | &mdash; | [Observations Not Done](pattern_observations.html#observations-not-done) |

### Services and procedures

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Requested services | [Requested services](https://hl7.org/fhir/us/cql/en/patterns-service.html#requested-services) | [Procedure ordered](pattern_procedures.html#procedure-ordered) |
| Procedures performed | [Procedures performed](https://hl7.org/fhir/us/cql/en/patterns-service.html#procedures-performed) | [Procedure performed](pattern_procedures.html#procedure-performed) |
| Imaging procedures | [Imaging procedures](https://hl7.org/fhir/us/cql/en/patterns-service.html#imaging-procedures) | [Imaging Procedures](pattern_procedures.html#imaging-procedures) |
| Mammography | [Mammography](https://hl7.org/fhir/us/cql/en/patterns-service.html#mammography) | &mdash; |
| Procedure not done | &mdash; | [Procedure not done](pattern_procedures.html#procedure-not-done) |
| Procedure not ordered | &mdash; | [Procedure not ordered](pattern_procedures.html#procedure-not-ordered) |

### Medications

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Active medications | [Active medications](https://hl7.org/fhir/us/cql/en/patterns-medication.html#active-medications) | [Medication in use](pattern_medications.html#medication-in-use) |
| Electronically transmitted prescriptions | [Electronically transmitted prescriptions](https://hl7.org/fhir/us/cql/en/patterns-medication.html#electronically-transmitted-prescriptions) | &mdash; |
| Medication status and intent | &mdash; | [Medication status and intent](pattern_medications.html#medication-status-and-intent) |
| Medication ordered | &mdash; | [Medication ordered](pattern_medications.html#medication-ordered) |
| Medication administered | &mdash; | [Medication administered](pattern_medications.html#medication-administered) |
| Medication dispensed | &mdash; | [Medication dispensed](pattern_medications.html#medication-dispensed) |
| Self-administered OTCs | &mdash; | [Self-administered OTCs](pattern_medications.html#self-administered-otcs) |
| Medication not ordered | &mdash; | [Medication Not Ordered](pattern_medications.html#medication-not-ordered) |
| Medication not administered | &mdash; | [Medication not administered](pattern_medications.html#medication-not-administered) |
| Medication not dispensed | &mdash; | [Medication not dispensed](pattern_medications.html#medication-not-dispensed) |

### Encounters

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Office visit encounters | &mdash; | [Office visit encounters](pattern_encounters.html#office-visit-encounters) |
| Encounters by direct-reference code | &mdash; | [Accessing Encounters with a Direct-reference code](pattern_encounters.html#accessing-encounters-with-a-direct-reference-code) |
| Encounters by class | &mdash; | [Encounters by class](pattern_encounters.html#encounters-by-class) |
| Completed encounters in a period | &mdash; | [Completed encounters in a period](pattern_encounters.html#completed-encounters-in-a-period) |
| Encounters of a certain length | &mdash; | [Encounters with a certain length](pattern_encounters.html#encounters-with-a-certain-length) |
| Hospitalization | &mdash; | [Hospitalization](pattern_encounters.html#hospitalization) |

### Devices

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Device ordered | &mdash; | [Device ordered](pattern_devices.html#device-ordered) |
| Device in use | &mdash; | [Device in use](pattern_devices.html#device-in-use) |
| Device not ordered | &mdash; | [Device not ordered](pattern_devices.html#device-not-ordered) |

### Immunizations

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Immunization performed | &mdash; | [Immunization performed](pattern_immunizations.html#immunization-performed) |
| Immunization not performed | &mdash; | [Immunization not performed](pattern_immunizations.html#immunization-not-performed) |

### Communication

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Communication | &mdash; | [Communication](pattern_communication.html#communication) |
| Communication not done | &mdash; | [Communication Not Done](pattern_communication.html#communication-not-done) |

### Claims and coverage

| Pattern | US CQL 2.0.0 | CMS dQM guidance |
|----|----|----|
| Billing-related elements | &mdash; | [Billing-related elements](pattern_billingrelated.html) |
| Preferring claim information | &mdash; | [Preferring claim information](pattern_billingrelated.html#preferring-claim-information) |
| Claim elements used by measures | &mdash; | [Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| Claim status, use, and type | [Status, use, and type](https://hl7.org/fhir/us/cql/en/patterns-claim.html#status-use-and-type) | &mdash; |
| Primary procedure | [Primary procedure](https://hl7.org/fhir/us/cql/en/patterns-claim.html#principal-procedure) | [Primary Procedure](pattern_claim.html#primary-procedure) (claim), [Primary Procedure](pattern_encounters.html#primary-procedure) (clinical), [Primary Procedure](pattern_billingrelated.html#primary-procedure) (combined) |
| Claim items | [Claim items](https://hl7.org/fhir/us/cql/en/patterns-claim.html#claim-items) | &mdash; |
| Explanation of Benefit items | [EoB items](https://hl7.org/fhir/us/cql/en/patterns-claim.html#eob-items) | &mdash; |
| Mammography claim | [Mammography claim](https://hl7.org/fhir/us/cql/en/patterns-claim.html#mammography-claim) | &mdash; |
| Member or subscriber ID | [Member or subscriber ID](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#member-or-subscriber-id) | &mdash; |
