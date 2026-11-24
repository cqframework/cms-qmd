This topic is a reference to the shared libraries used by US Quality Core measures, and to the declarations they define. For the mapping from the QICore-based libraries to their US Quality Core replacements, see the [Refactored Index](refactored_index.html).

### Shared Library Index

The following shared libraries are used by US Quality Core measures. Libraries published in an implementation guide are included using the namespace given in the Source of truth column, and are available through the NPM package for that guide. The remaining libraries are released in MADiE; this guide has convenience copies of them in its source, which the Declaration Index links to.

| Library | Version | Source of truth | Summary |
|----|----|----|----|
| FHIRHelpers | 4.0.1 | [Using CQL with FHIR 2.0.0]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>`hl7.fhir.uv.cql.FHIRHelpers` | Conversions between FHIR types and CQL system types (`ToString()`, `ToCode()`, `ToConcept()`, `ToInterval()`, `ToQuantity()`, and so on). The translator applies them implicitly, so logic rarely calls them directly. |
| FHIRCommon | 2.0.0 | [Using CQL with FHIR 2.0.0]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>`hl7.fhir.uv.cql.FHIRCommon` | Functions and codes for FHIR in general: reference and extension access (`references()`, `ext()`, `modifierExt()`), interval normalization (`toInterval()`, `abatementInterval()`, `prevalenceInterval()`), status and category functions for Condition, AllergyIntolerance, and Observation, and the MedicationRequest category functions. |
| USCoreCommon | 2.0.0 | [US CQL 2.0.0]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html)<br/>`hl7.fhir.us.cql.USCoreCommon` | Functions and codes specific to US Core: patient demographic extensions (race, ethnicity, birth sex, tribal affiliation, sex parameter for clinical use), blood pressure components, condition asserted date and health concern category, and chronological ordering. |
| USCoreElements | 2.0.0 | [US CQL 2.0.0]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html)<br/>`hl7.fhir.us.cql.USCoreElements` | Common US Core data elements as expressions (encounters, conditions, problem list items, allergies, laboratory results, vital signs, smoking status, medication requests), with patient name, age, and identifier functions, and request and coverage accessors. |
| CumulativeMedicationDuration | 2.0.0 | [US CQL 2.0.0]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html)<br/>`hl7.fhir.us.cql.CumulativeMedicationDuration` | Medication periods and cumulative medication duration for MedicationRequest, MedicationDispense, and MedicationAdministration, with the dosing frequency codes they use. |
| USQualityCoreCommon | 0.5.0 | [US Quality Core 0.5.0](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html)<br/>`fhir.onc."us-quality-core".USQualityCoreCommon` | Accessors for the US Quality Core extensions, including the negation profile accessors (`recorded()`, `notDoneReason()`, `medication()`, `code()`, `vaccineCode()`, `toValueSet()`), `doNotPerformReason()`, and `presentOnAdmission()`. Use the published library, not the copy in MADiE. |
| CQMCommon | 5.2.000 | [MADiE](https://madie.cms.gov/cql-libraries/6aaa9b2c520594208bf77b16/edit/details) | Encounter functions for quality measures in a single library: `hospitalization()`, length of stay, arrival, admission, discharge, and departure times, emergency department visits, and intensive care unit locations. Being replaced by CQMConcepts, CQMElements, and CQMInferences. |
| CQMConcepts | 0.5.000 | [MADiE](https://madie.cms.gov/cql-libraries/6ae8ffa1420d45ce089c0e71/edit/details) | The terminology layer of the CQMCommon replacement: value sets and codes, category functions for CarePlan, DiagnosticReport, and ServiceRequest, pulse oximetry and occupation components, organization and practitioner identifiers, and `Period()`, `prevalencePeriod()`, `relevantDate()`, and `relevantPeriod()` for Condition and AllergyIntolerance. |
| CQMElements | 0.5.000 | [MADiE](https://madie.cms.gov/cql-libraries/6ae907ae420d45ce089c0e72/edit/details) | The element layer of the CQMCommon replacement: `"Hospitalization Encounters"`, the emergency department, observation, and outpatient surgery encounters, encounter locations, and the hospitalization functions over them. |
| CQMInferences | 0.5.000 | [MADiE](https://madie.cms.gov/cql-libraries/6ae95ce9420d45ce089c0e73/edit/details) | The inference layer of the CQMCommon replacement: the encounters during the `"Measurement Period"`. |
| ClaimCommon | 0.5.000 | [MADiE](https://madie.cms.gov/cql-libraries/6ae95f00420d45ce089c0e74/edit/details) | Status, use, and type functions for Claim and ExplanationOfBenefit, inpatient and outpatient institutional claims, diagnosis and procedure type functions (principal, admitting, primary, secondary), discharge status, and point of origin. |
| ClaimElements | 0.5.000 | [MADiE](https://madie.cms.gov/cql-libraries/6ae96063420d45ce089c0e75/edit/details) | Claim element expressions that flatten claim items, diagnoses, and procedures into rows, and `isRelatedTo()`, which relates a claim diagnosis to an encounter. |
| MedicationCommon | 0.2.000 | [MADiE](https://madie.cms.gov/cql-libraries/6ad8cd51bf531c0659c86b77/edit/details) | Status, intent, category, and selection functions for MedicationRequest, MedicationAdministration, and MedicationDispense; see [Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category). |
| FHIRBuilders | 0.1.000 | [MADiE](https://madie.cms.gov/cql-libraries/6ad7ddacbf531c0659c86b71/edit/details) | Functions that construct FHIR values from CQL values (`toFHIRString()`, `toFHIRCodeableConcept()`, `toFHIRPeriod()`, and so on), principally for testing. |
| SupplementalDataElements | 6.1.000 | MADiE | The supplemental data element expressions for ethnicity, payer, race, and sex. |
{: .grid}

> NOTE: CQMConcepts, CQMElements, and CQMInferences 0.5.000 are the latest versions in MADiE. Version 0.3.000 is the current best practice, and 0.4.000 adds `prevalencePeriod()`, `relevantDate()`, and `relevantPeriod()`; see the [Refactored Index](refactored_index.html#library-index).

### Declaration Index

This index lists every public declaration in the shared libraries above: functions, expressions, parameters, code systems, value sets, and codes. Each declaration links to its definition, by line for the libraries in MADiE, and to the library page for the libraries published in an implementation guide. Function overloads are listed by signature, except where a library has many overloads of one function. The Discussed in column links to the topics in this guide that use or discuss the declaration.

<!-- BEGIN GENERATED DECLARATION INDEX -->
[A](#declarations-a) | [B](#declarations-b) | [C](#declarations-c) | [D](#declarations-d) | [E](#declarations-e) | [F](#declarations-f) | [G](#declarations-g) | [H](#declarations-h) | [I](#declarations-i) | [L](#declarations-l) | [M](#declarations-m) | [N](#declarations-n) | [O](#declarations-o) | [P](#declarations-p) | [Q](#declarations-q) | [R](#declarations-r) | [S](#declarations-s) | [T](#declarations-t) | [U](#declarations-u) | [V](#declarations-v) | [W](#declarations-w) | [X](#declarations-x)

#### A {#declarations-a}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`abatement(AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`abatement(FamilyMemberHistory)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`abatementInterval(Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`abatementInterval(AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue), [Allergies: Onset, abatement, and prevalence period](pattern_allergies.html#onset-abatement-and-prevalence-period), [Conditions: Onset, abatement, and prevalence period](pattern_conditions.html#onset-abatement-and-prevalence-period), [FHIR Patterns: Further considerations](pattern_fhir.html#further-considerations) |
| [`"AC"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"ACD"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"ACM"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"ActCode"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L76) | Code system | CQMConcepts |  |
| [`"ActCode"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
| [`"ActCode"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code system | USQualityCoreCommon |  |
| [`"Active"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code | USCoreElements |  |
| [`active(List<FHIR.Claim>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L143)<br/>[`active(List<FHIR.ExplanationOfBenefit>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L259) | Fluent function | ClaimCommon |  |
| [`"active"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue) |
| [`active(List<FHIR.Condition>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`active(List<FHIR.AllergyIntolerance>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [FHIR Patterns: Accessing data](pattern_fhir.html#accessing-data) |
| [`active(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L123) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`"Active Confirmed Allergies and Intolerances"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements | [FHIR Patterns: Accessing data](pattern_fhir.html#accessing-data) |
| [`"Active Confirmed Common Allergies and Intolerances"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Active Confirmed Problem List Items"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Active Medication Orders"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"activity"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"ACV"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"AD"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"Admitting Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L105) | Code | ClaimCommon |  |
| [`"AFT"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"AFT.early"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"AFT.late"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`ageInDays(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`ageInDaysAt(FHIR.Patient, System.DateTime)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`ageInMonths(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`ageInMonthsAt(FHIR.Patient, System.DateTime)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`ageInYears(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`ageInYearsAt(FHIR.Patient, System.DateTime)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements | [Patient: Patient age](pattern_patient.html#patient-age), [US Quality Core Update Process: Step 5: Consider Functions](usqc_update_process.html#step-5-consider-functions) |
| [`"All Allergies and Intolerances"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements | [FHIR Patterns: Accessing data](pattern_fhir.html#accessing-data) |
| [`"All Blood Pressure Measurements"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Blood Pressure Measurements All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Body Height Measurements"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Body Height Measurements All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Body Mass Index Measurements"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Body Mass Index Measurements All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Body Temperature Measurements"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Body Temperature Measurements All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Body Weight Measurements"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Body Weight Measurements All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Clinical Trials"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Completed Immunizations"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Conditions"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Diagnostic Report Notes"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Diagnostic Reports for Laboratory Results"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Encounter Diagnoses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Encounter Location Entries"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L152) | Expression | CQMElements | [Encounters: Hospitalization Locations](pattern_encounters.html#hospitalization-locations) |
| [`"All Encounter Locations"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L169) | Expression | CQMElements | [Encounters: Hospitalization Locations](pattern_encounters.html#hospitalization-locations) |
| [`"All Encounters"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Head Circumference Measurements"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Head Circumference Measurements All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Health Concerns"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Heart Rate Measurements"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Heart Rate Measurements All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Immunizations"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Implantable Devices"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Laboratory Results"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Medication Requests"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Medications"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Organizations"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Performed Encounters"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Performed Procedures"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Problem List Items"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Procedures"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Respiratory Rate Measurements"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Respiratory Rate Measurements All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All ServiceRequests"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Vital Signs"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"All Vital Signs All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"allergy-active"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"allergy-confirmed"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"allergy-inactive"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"allergy-refuted"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"allergy-resolved"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"allergy-unconfirmed"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"AllergyIntoleranceClinicalStatusCodes"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"AllergyIntoleranceVerificationStatusCodes"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"ambulatory"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"ambulatory"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`amended(List<FHIR.Observation>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`as(String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`"Asked-Declined"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`assertedDate(FHIR.AllergyIntolerance)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html)<br/>[`assertedDate(FHIR.Condition)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
{: .grid}

#### B {#declarations-b}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`base64Binary(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L30) | Function | FHIRBuilders |  |
| [`"Billing"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L102) | Code | ClaimCommon |  |
| [`"Billing"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon | [Billing-related Elements: Principal Diagnosis](pattern_billingrelated.html#principal-diagnosis), [Billing-related Elements: Primary Procedure](pattern_billingrelated.html#primary-procedure), [Encounters: Principal Diagnosis](pattern_encounters.html#principal-diagnosis), [Encounters: Primary Procedure](pattern_encounters.html#primary-procedure) |
| [`"billing"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`BillingProvider(FHIR.Coverage)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`"Birthdate"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`birthDateTime(Patient)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`birthSex(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`birthTime(Patient)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"BMI"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"Body surface area"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code | USCoreElements |  |
| [`boolean(Boolean)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L42) | Function | FHIRBuilders |  |
{: .grid}

#### C {#declarations-c}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"C"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`CalculateBSA(System.String, System.Quantity, System.Quantity)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`canonical(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L54) | Function | FHIRBuilders |  |
| [`"CC"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`ccn(FHIR.Organization)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L363) | Fluent function | CQMConcepts |  |
| [`"CD"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"CDC Race and Ethnicity Codes"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
| [`checkModifiers(Resource)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`checkModifiers(Resource, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`checkModifiers(Element)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`checkModifiers(Element, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers | [FHIR Patterns: Modifier elements](pattern_fhir.html#modifier-elements) |
| [`chronologically(List<FHIR.Observation>)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`chronologicallyAfter(List<FHIR.Observation>, FHIR.Observation)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`"Claim Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimElements.cql#L104) | Expression | ClaimElements |  |
| [`"Claim Encounter Item"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimElements.cql#L43) | Expression | ClaimElements |  |
| [`"Claim Item"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimElements.cql#L75) | Expression | ClaimElements |  |
| [`"Claim Item Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimElements.cql#L123) | Expression | ClaimElements | [Billing-related Elements: Preferring claim information](pattern_billingrelated.html#preferring-claim-information), [Billing-related Elements: Evidence of Diagnosis during an Encounter](pattern_billingrelated.html#evidence-of-diagnosis-during-an-encounter), [Billing-related Elements: CMS1218](pattern_billingrelated.html#cms1218), [Billing-related Elements: History of a Condition](pattern_billingrelated.html#history-of-a-condition), [Billing-related Elements: Present on Admission](pattern_billingrelated.html#present-on-admission), [Billing-related Elements: Principal Diagnosis](pattern_billingrelated.html#principal-diagnosis), [Claim: Encounter-related Items](pattern_claim.html#encounter-related-items), [Claim: Evidence of Diagnosis on an Encounter](pattern_claim.html#evidence-of-diagnosis-on-an-encounter), [Claim: History of a Condition](pattern_claim.html#history-of-a-condition), [Claim: Present on Admission](pattern_claim.html#present-on-admission), [Claim: CMS1028 - Severe Obstetric Complications](pattern_claim.html#cms1028---severe-obstetric-complications), [Claim: Principal Diagnosis](pattern_claim.html#principal-diagnosis), [Claim: Examples](pattern_claim.html#examples-1), [US Quality Core Update Process: Example: Updated Billing Access](usqc_update_process.html#example-updated-billing-access) |
| [`"Claim Item Procedure"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimElements.cql#L206) | Expression | ClaimElements | [Billing-related Elements: Primary Procedure](pattern_billingrelated.html#primary-procedure), [Claim: Encounter-related Items](pattern_claim.html#encounter-related-items), [Claim: Primary Procedure](pattern_claim.html#primary-procedure), [Claim: Examples](pattern_claim.html#examples-2) |
| [`"Claim Procedure"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimElements.cql#L187) | Expression | ClaimElements |  |
| [`"Claim Status Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L41) | Code system | ClaimCommon |  |
| [`"Claim Type Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L44) | Code system | ClaimCommon |  |
| [`"Claim Use Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L43) | Code system | ClaimCommon |  |
| [`"claim-active"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L60) | Code | ClaimCommon |  |
| [`"claim-cancelled"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L61) | Code | ClaimCommon |  |
| [`"claim-draft"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L62) | Code | ClaimCommon |  |
| [`"claim-entered-in-error"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L63) | Code | ClaimCommon |  |
| [`claims(List<FHIR.Claim>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L182)<br/>[`claims(List<FHIR.ExplanationOfBenefit>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L294) | Fluent function | ClaimCommon |  |
| [`clia(FHIR.Organization)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L328) | Fluent function | CQMConcepts |  |
| [`"Clinical Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L106) | Code | ClaimCommon |  |
| [`"CM"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"CM"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`code(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L66) | Function | FHIRBuilders |  |
| [`code()`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) (5 overloads) | Fluent function | USQualityCoreCommon | [Negation Patterns: Extent of negation](pattern_negation.html#extent-of-negation) |
| [`CodeableConcept(System.Concept)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L282)<br/>[`CodeableConcept(System.Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L300) | Function | FHIRBuilders |  |
| [`codeOptions(CodeableConcept)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [FHIR Patterns: Terminology Functions](pattern_fhir.html#terminology-functions) |
| [`Coding(System.Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L260) | Function | FHIRBuilders |  |
| [`"Common Allergies and Intolerances"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Common allergy substances"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Value set | USCoreElements |  |
| [`"CommunicationCategoryCodeSystem"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
| [`"Community"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`community(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L276)<br/>[`community(List<FHIR.MedicationAdministration>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L408) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`complete(List<FHIR.DiagnosticReport>)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`completed(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L149)<br/>[`completed(List<FHIR.MedicationAdministration>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L325)<br/>[`completed(List<FHIR.MedicationDispense>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L425) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`concentration(FHIR.Observation)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L239) | Fluent function | CQMConcepts |  |
| [`"Condition Clinical"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code system | USCoreElements |  |
| [`"ConditionCategoryCodes"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"ConditionClinicalStatusCodes"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"ConditionVerificationStatusCodes"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"Confirmed"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code | USCoreElements |  |
| [`"confirmed"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`confirmed(List<FHIR.Condition>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`confirmed(List<FHIR.AllergyIntolerance>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [FHIR Patterns: Accessing data](pattern_fhir.html#accessing-data) |
| [`conformsTo(Resource, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`corrected(List<FHIR.Observation>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`CumulativeDuration(List<Interval<Date>>)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`cumulativeDuration(List<Interval<Date>>)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Fluent function | CumulativeMedicationDuration |  |
| [`CumulativeMedicationDuration(List<Choice<MedicationRequest, MedicationDispense>>)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`cumulativeMedicationDuration(List<Choice<MedicationRequest, MedicationDispense>>)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Fluent function | CumulativeMedicationDuration |  |
| [`"CV"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"CVX"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
{: .grid}

#### D {#declarations-d}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"DataAbsentReason"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
| [`date(Date)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L78) | Function | FHIRBuilders |  |
| [`dateTime(DateTime)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L90) | Function | FHIRBuilders |  |
| [`daysInPeriod(Interval<DateTime>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`daysInPeriod(Interval<DateTime>)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`"DD"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"Dead"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`decimal(Decimal)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L102) | Function | FHIRBuilders |  |
| [`"Diagnosis Role"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"Diagnosis Role Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L45) | Code system | ClaimCommon |  |
| [`"Diagnosis Type Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L46) | Code system | ClaimCommon |  |
| [`"diagnosistype-admitting"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L82) | Code | ClaimCommon |  |
| [`"diagnosistype-discharge"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L83) | Code | ClaimCommon |  |
| [`"diagnosistype-principal"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L81) | Code | ClaimCommon |  |
| [`diastolic(FHIR.Observation)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon | [FHIR Patterns: Further considerations](pattern_fhir.html#further-considerations), [Observations: Vital Signs](pattern_observations.html#vital-signs) |
| [`"Diastolic Blood Pressure"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"Diastolic Blood Pressure"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"differential"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`differential(List<FHIR.Condition>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"Differential Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L107) | Code | ClaimCommon |  |
| [`"Discharge"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`discharge(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L289) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`"Discharge Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L108) | Code | ClaimCommon |  |
| [`"discharge-status"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L91) | Code | ClaimCommon |  |
| [`dischargeStatus(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L368) | Fluent function | ClaimCommon | [Billing-related Elements: Discharge Disposition](pattern_billingrelated.html#discharge-disposition), [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures), [Claim: Discharge Disposition](pattern_claim.html#discharge-disposition) |
| [`doNotPerform(DeviceNotRequested)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`doNotPerformReason(DeviceNotRequested)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`during(List<FHIR.Observation>, FHIR.Encounter)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
{: .grid}

#### E {#declarations-e}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`earliest(Choice<FHIR.dateTime, FHIR.Period, FHIR.Age, FHIR.Range>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [FHIR Patterns: Interval Calculations](pattern_fhir.html#interval-calculations), [FHIR Patterns: Further considerations](pattern_fhir.html#further-considerations) |
| [`edVisit(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L51) | Fluent function | CQMCommon |  |
| [`edVisit(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L199) | Fluent function | CQMElements | [Encounters: Emergency Department Visit](pattern_encounters.html#emergency-department-visit), [Encounters: Example: CMS529: Hybrid Hospital-Wide Readmission](pattern_encounters.html#example-cms529-hybrid-hospital-wide-readmission), [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`ein(FHIR.Organization)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L376)<br/>[`ein(FHIR.Practitioner)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L390) | Fluent function | CQMConcepts |  |
| [`"Electronic Prescription"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`elementDefinition(Element)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`"EMER"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L79) | Code | CQMConcepts |  |
| [`"emergency"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"emergency"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`"Emergency Department Encounter"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L29) | Expression | CQMElements | [Encounters: Encounter Definitions](pattern_encounters.html#encounter-definitions), [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters), [Encounters: Example: CMS529: Hybrid Hospital-Wide Readmission](pattern_encounters.html#example-cms529-hybrid-hospital-wide-readmission), [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services), [Encounters: Normalized Encounters](pattern_encounters.html#normalized-encounters) |
| [`"Emergency Department Encounter During Measurement Period"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMInferences.cql#L31) | Expression | CQMInferences |  |
| [`"Emergency Department Locations"(List<USQualityCore.Encounter>, List<USQualityCore.Location>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L188) | Function | CQMElements | [Encounters: Hospitalization Locations](pattern_encounters.html#hospitalization-locations) |
| [`"Emergency Department Visit"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L15) | Value set | CQMCommon |  |
| [`"Emergency Department Visit"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L42) | Value set | CQMConcepts |  |
| [`"Emergency room"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L80) | Code | CQMConcepts |  |
| [`"Emergency trauma unit"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L81) | Code | CQMConcepts |  |
| [`emergencyDepartmentArrivalTime(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L116) | Fluent function | CQMCommon |  |
| [`emergencyDepartmentArrivalTime(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L308) | Fluent function | CQMElements | [Encounters: Arrival and Departure Time](pattern_encounters.html#arrival-and-departure-time), [Encounters: Intensive Care Unit](pattern_encounters.html#intensive-care-unit), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`"Encounter Inpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L16) | Value set | CQMCommon |  |
| [`"Encounter Inpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L43) | Value set | CQMConcepts | [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters), [Encounters: Example: CMS529: Hybrid Hospital-Wide Readmission](pattern_encounters.html#example-cms529-hybrid-hospital-wide-readmission), [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services) |
| [`"Encounter Location Entries"(List<USQualityCore.Encounter>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L155) | Function | CQMElements | [Encounters: Hospitalization Locations](pattern_encounters.html#hospitalization-locations) |
| [`"Encounter Locations"(List<USQualityCore.Encounter>, List<USQualityCore.Location>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L175) | Function | CQMElements | [Encounters: Hospitalization Locations](pattern_encounters.html#hospitalization-locations) |
| [`"encounter-diagnosis"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"entered-in-error"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"eob-active"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L66) | Code | ClaimCommon |  |
| [`"eob-cancelled"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L67) | Code | ClaimCommon |  |
| [`"eob-draft"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L68) | Code | ClaimCommon |  |
| [`"eob-entered-in-error"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L69) | Code | ClaimCommon |  |
| [`"ER"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`ErrorLevel`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Parameter | CumulativeMedicationDuration |  |
| [`"Ethnicity"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L19) | Value set | SupplementalDataElements |  |
| [`ethnicity(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon | [Patient: Patient race and ethnicity](pattern_patient.html#patient-race-and-ethnicity) |
| [`"EVE"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"EVE.early"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"EVE.late"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"EventTiming"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code system | CumulativeMedicationDuration |  |
| [`"Every eight hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every eight to twelve hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every forty eight hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every forty hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every four hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every seventy two hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every six hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every six to eight hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every thirty six hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every three to four hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every three to six hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every twelve hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every twenty four hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Every two to four hours (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"exam"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"Explanation Of Benefit Status Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L42) | Code system | ClaimCommon |  |
| [`ext(DomainResource, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`ext(Element, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`extension(Element, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`extension(DomainResource, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`exts(DomainResource, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`exts(Element, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
{: .grid}

#### F {#declarations-f}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"Federal Administrative Sex"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L20) | Value set | SupplementalDataElements |  |
| [`"Female"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"Female (finding)"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L25) | Code | SupplementalDataElements |  |
| [`"field"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"field"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`final(List<FHIR.Observation>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`firstInpatientIntensiveCareUnit(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L176) | Fluent function | CQMCommon |  |
| [`firstInpatientIntensiveCareUnit(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L325) | Fluent function | CQMElements | [Encounters: Intensive Care Unit](pattern_encounters.html#intensive-care-unit), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`firstMiddleLast(FHIR.HumanName)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`firstName(FHIR.HumanName)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`firstNonOfficialNonUsualName(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html)<br/>[`firstNonOfficialNonUsualName(FHIR.Practitioner)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`flowRate(FHIR.Observation)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L226) | Fluent function | CQMConcepts |  |
| [`"Four times daily (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Fulfill"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon | [Devices: Device ordered](pattern_devices.html#device-ordered), [Devices: Device not ordered](pattern_devices.html#device-not-ordered), [Medications: Medication ordered](pattern_medications.html#medication-ordered), [Medications: Medication Not Ordered](pattern_medications.html#medication-not-ordered), [Negation Patterns: Positive requests and rejected proposals](pattern_negation.html#positive-requests-and-rejected-proposals), [Observations: Observations Not Done](pattern_observations.html#observations-not-done), [Procedures: Procedure ordered](pattern_procedures.html#procedure-ordered), [Procedures: Procedure not ordered](pattern_procedures.html#procedure-not-ordered) |
| [`"Fulfill"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
{: .grid}

#### G {#declarations-g}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`getId(String)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`"GetServiceRequestReasonCondition"(ServiceRequest)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`getSystem(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L233) | Function | FHIRBuilders |  |
| [`getValue(Element)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
{: .grid}

#### H {#declarations-h}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`hasCategory(FHIR.CarePlan, Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L122)<br/>[`hasCategory(FHIR.DiagnosticReport, Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L136)<br/>[`hasCategory(FHIR.ServiceRequest, Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L148) | Fluent function | CQMConcepts |  |
| [`hasCategory(FHIR.Condition, Code)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`hasCategory(FHIR.Observation, Code)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`hasCategory(MedicationRequest, Code)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`hasCategory(FHIR.MedicationRequest, Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L238)<br/>[`hasCategory(FHIR.MedicationAdministration, Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L370) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`hasEnd(Interval<DateTime>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [FHIR Patterns: Interval Calculations](pattern_fhir.html#interval-calculations) |
| [`hasStart(Interval<DateTime>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [FHIR Patterns: Interval Calculations](pattern_fhir.html#interval-calculations) |
| [`hasValue(Element)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`"health-concern"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"History of Occupation Industry"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L69) | Code | CQMConcepts |  |
| [`"home health"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"home health"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`hospitalAdmissionTime(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L86) | Fluent function | CQMCommon |  |
| [`hospitalAdmissionTime(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L267) | Fluent function | CQMElements | [Encounters: Admission and Discharge Time](pattern_encounters.html#admission-and-discharge-time), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`hospitalArrivalTime(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L98) | Fluent function | CQMCommon |  |
| [`hospitalArrivalTime(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L283) | Fluent function | CQMElements | [Encounters: Arrival and Departure Time](pattern_encounters.html#arrival-and-departure-time), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`hospitalDepartureTime(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L107) | Fluent function | CQMCommon |  |
| [`hospitalDepartureTime(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L294) | Fluent function | CQMElements | [Encounters: Arrival and Departure Time](pattern_encounters.html#arrival-and-departure-time), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`hospitalDischargeTime(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L92) | Fluent function | CQMCommon |  |
| [`hospitalDischargeTime(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L275) | Fluent function | CQMElements | [Encounters: Admission and Discharge Time](pattern_encounters.html#admission-and-discharge-time), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`hospitalization(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L62) | Fluent function | CQMCommon | [Claim: CMS1028 - Severe Obstetric Complications](pattern_claim.html#cms1028---severe-obstetric-complications), [FHIR Patterns: Model qualifiers](pattern_fhir.html#model-qualifiers) |
| [`hospitalization(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L238) | Fluent function | CQMElements | [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters), [Encounters: Hospitalization Period and Length Of Stay](pattern_encounters.html#hospitalization-period-and-length-of-stay), [Encounters: Admission and Discharge Time](pattern_encounters.html#admission-and-discharge-time), [Encounters: Normalized Encounters](pattern_encounters.html#normalized-encounters), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon), [FHIR Patterns: Model qualifiers](pattern_fhir.html#model-qualifiers), [FHIR Patterns: Retrieve by profile](pattern_fhir.html#retrieve-by-profile) |
| [`"Hospitalization Encounters"(List<USQualityCore.Encounter>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L48) | Function | CQMElements | [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters), [Encounters: Example: CMS529: Hybrid Hospital-Wide Readmission](pattern_encounters.html#example-cms529-hybrid-hospital-wide-readmission), [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services), [FHIR Patterns: Retrieve by profile](pattern_fhir.html#retrieve-by-profile) |
| [`hospitalizationLengthOfStay(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L80) | Fluent function | CQMCommon |  |
| [`hospitalizationLengthOfStay(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L259) | Fluent function | CQMElements | [Encounters: Hospitalization Period and Length Of Stay](pattern_encounters.html#hospitalization-period-and-length-of-stay), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`hospitalizationLocations(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L71) | Fluent function | CQMCommon |  |
| [`hospitalizationLocations(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L249) | Fluent function | CQMElements | [Encounters: Hospitalization Locations](pattern_encounters.html#hospitalization-locations), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`hospitalizationWithObservation(Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L152) | Fluent function | CQMCommon | [Claim: CMS1028 - Severe Obstetric Complications](pattern_claim.html#cms1028---severe-obstetric-complications), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`hospitalizationWithObservationAndOutpatientSurgeryService("Encounter")`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L129) | Fluent function | CQMCommon | [Claim: CMS1028 - Severe Obstetric Complications](pattern_claim.html#cms1028---severe-obstetric-complications), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`hospitalizationWithObservationLengthofStay("Encounter")`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L170) | Fluent function | CQMCommon | [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`"HS"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"HSLOC"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L75) | Code system | CQMConcepts |  |
| [`htmlChecks(Element)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
{: .grid}

#### I {#declarations-i}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"ICD10CM"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"ICU"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`id(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L114) | Function | FHIRBuilders |  |
| [`Identifier(String, String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L313) | Function | FHIRBuilders |  |
| [`"Identifier Type"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code system | USCoreElements |  |
| [`"IdentifierType"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
| [`"imaging"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"inactive"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`inactive(List<FHIR.AllergyIntolerance>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`includedEncounters(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L143) | Fluent function | CQMElements | [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters), [Encounters: Included Encounters](pattern_encounters.html#included-encounters), [Encounters: Normalized Encounters](pattern_encounters.html#normalized-encounters) |
| [`includesCode(List<CodeableConcept>, Concept)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Claim: Principal Diagnosis](pattern_claim.html#principal-diagnosis), [FHIR Patterns: Use of terminologies](pattern_fhir.html#use-of-terminologies), [FHIR Patterns: Terminology Functions](pattern_fhir.html#terminology-functions) |
| [`individualSex(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`industry(FHIR.Observation)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L252) | Fluent function | CQMConcepts |  |
| [`"Inhaled Oxygen Concentration"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L68) | Code | CQMConcepts |  |
| [`"Inhaled Oxygen Flow Rate"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L67) | Code | CQMConcepts |  |
| [`"Inpatient"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon | [Medications: Medication administered](pattern_medications.html#medication-administered) |
| [`inpatient(List<FHIR.Claim>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L431)<br/>[`inpatient(List<FHIR.ExplanationOfBenefit>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L461) | Fluent function | ClaimCommon |  |
| [`inpatient(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L250)<br/>[`inpatient(List<FHIR.MedicationAdministration>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L382) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`"inpatient acute"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"inpatient acute"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`"Inpatient Encounter"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L27) | Expression | CQMCommon |  |
| [`"Inpatient Encounter"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L25) | Expression | CQMElements | [Encounters: Encounter Definitions](pattern_encounters.html#encounter-definitions), [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters), [Encounters: Example: CMS529: Hybrid Hospital-Wide Readmission](pattern_encounters.html#example-cms529-hybrid-hospital-wide-readmission), [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services), [Encounters: Normalized Encounters](pattern_encounters.html#normalized-encounters), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`"inpatient encounter"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"inpatient encounter"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`"Inpatient Encounter During Measurement Period"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMInferences.cql#L27) | Expression | CQMInferences | [Encounters: Encounter Definitions](pattern_encounters.html#encounter-definitions), [Encounters: Relationship to CQMCommon](pattern_encounters.html#relationship-to-cqmcommon) |
| [`"inpatient non-acute"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"inpatient non-acute"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`instant(DateTime)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L126) | Function | FHIRBuilders |  |
| [`institutional(List<FHIR.Claim>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L211)<br/>[`institutional(List<FHIR.ExplanationOfBenefit>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L323) | Fluent function | ClaimCommon |  |
| [`"Institutional Claim Sub Type Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L52) | Code system | ClaimCommon |  |
| [`integer(Integer)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L138) | Function | FHIRBuilders |  |
| [`"Intensive Care Unit"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L17) | Value set | CQMCommon |  |
| [`"Intensive Care Unit"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L44) | Value set | CQMConcepts |  |
| [`is(String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`isActive(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L137)<br/>[`isActive(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L253) | Fluent function | ClaimCommon | [Billing-related Elements: Preferring claim information](pattern_billingrelated.html#preferring-claim-information), [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isActive(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`isActive(FHIR.AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue), [Allergies: Current Allergies](pattern_allergies.html#current-allergies), [Allergies: Onset, abatement, and prevalence period](pattern_allergies.html#onset-abatement-and-prevalence-period), [Allergies: Allergy date and relevant period](pattern_allergies.html#allergy-date-and-relevant-period), [Allergies: No Known Allergies](pattern_allergies.html#no-known-allergies), [Conditions: Active conditions](pattern_conditions.html#active-conditions), [Conditions: Diagnosis date and relevant period](pattern_conditions.html#diagnosis-date-and-relevant-period), [FHIR Patterns: Accessing data](pattern_fhir.html#accessing-data) |
| [`isActive(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L117) | Fluent function | MedicationCommon | [Medications: Accessing medications with terminology](pattern_medications.html#accessing-medications-with-terminology), [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication ordered](pattern_medications.html#medication-ordered), [Medications: Medication Not Ordered](pattern_medications.html#medication-not-ordered), [Medications: Medication in use](pattern_medications.html#medication-in-use), [Medications: Self-administered OTCs](pattern_medications.html#self-administered-otcs) |
| [`isActivity(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isAdmittingDiagnosis(List<FHIR.CodeableConcept>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L393) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isAmended(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Observations](pattern_observations.html) |
| [`isCancelled(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L150)<br/>[`isCancelled(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L266) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isCancelled(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L156)<br/>[`isCancelled(FHIR.MedicationDispense)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L450) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isClaim(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L176)<br/>[`isClaim(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L288) | Fluent function | ClaimCommon | [Billing-related Elements: Preferring claim information](pattern_billingrelated.html#preferring-claim-information), [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures), [US Quality Core Update Process: Example: Updated Billing Access](usqc_update_process.html#example-updated-billing-access) |
| [`isCommunity(MedicationRequest)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isCommunity(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L270)<br/>[`isCommunity(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L402) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication ordered](pattern_medications.html#medication-ordered), [Medications: Medication Not Ordered](pattern_medications.html#medication-not-ordered), [Medications: Self-administered OTCs](pattern_medications.html#self-administered-otcs) |
| [`isComplete(FHIR.DiagnosticReport)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`isCompleted(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L143)<br/>[`isCompleted(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L319)<br/>[`isCompleted(FHIR.MedicationDispense)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L419) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication ordered](pattern_medications.html#medication-ordered), [Medications: Medication Not Ordered](pattern_medications.html#medication-not-ordered), [Medications: Medication administered](pattern_medications.html#medication-administered), [Medications: Medication dispensed](pattern_medications.html#medication-dispensed) |
| [`isConfirmed(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`isConfirmed(FHIR.AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Allergies: Verified Allergies](pattern_allergies.html#verified-allergies), [Conditions: Verified Conditions](pattern_conditions.html#verified-conditions) |
| [`isCorrected(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Observations](pattern_observations.html) |
| [`isDeclined(FHIR.MedicationDispense)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L464) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isDifferential(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Conditions: Verified Conditions](pattern_conditions.html#verified-conditions) |
| [`isDischarge(MedicationRequest)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isDischarge(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L283) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication ordered](pattern_medications.html#medication-ordered), [Medications: Medication Not Ordered](pattern_medications.html#medication-not-ordered) |
| [`isDraft(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L157)<br/>[`isDraft(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L272) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isDraft(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L168) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isEncounterDiagnosis(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Conditions: Active conditions](pattern_conditions.html#active-conditions) |
| [`isEnteredInError(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L165)<br/>[`isEnteredInError(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L278) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isEnteredInError(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L176)<br/>[`isEnteredInError(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L358)<br/>[`isEnteredInError(FHIR.MedicationDispense)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L470) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isExam(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isFinal(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Observations](pattern_observations.html) |
| [`isHealthConcern(FHIR.Condition)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon | [Conditions: Active conditions](pattern_conditions.html#active-conditions) |
| [`isImaging(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isInactive(FHIR.AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isInpatient(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L424)<br/>[`isInpatient(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L454) | Fluent function | ClaimCommon |  |
| [`isInpatient(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L244)<br/>[`isInpatient(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L376) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication administered](pattern_medications.html#medication-administered), [Medications: Medication not administered](pattern_medications.html#medication-not-administered) |
| [`isInProgress(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L332)<br/>[`isInProgress(FHIR.MedicationDispense)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L432) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication dispensed](pattern_medications.html#medication-dispensed) |
| [`isInstitutional(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L205)<br/>[`isInstitutional(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L317) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isLaboratory(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isNotDone(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L352) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isOnHold(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L130)<br/>[`isOnHold(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L338)<br/>[`isOnHold(FHIR.MedicationDispense)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L444) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication dispensed](pattern_medications.html#medication-dispensed) |
| [`isOral(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L237)<br/>[`isOral(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L349) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isOrder(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L188) | Fluent function | MedicationCommon | [Medications: Accessing medications with terminology](pattern_medications.html#accessing-medications-with-terminology), [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication ordered](pattern_medications.html#medication-ordered), [Medications: Medication Not Ordered](pattern_medications.html#medication-not-ordered) |
| [`isOrderIntent(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L209) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Medication in use](pattern_medications.html#medication-in-use) |
| [`isOutpatient(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L439)<br/>[`isOutpatient(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L469) | Fluent function | ClaimCommon |  |
| [`isOutpatient(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L257)<br/>[`isOutpatient(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L389) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isPharmacy(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L231)<br/>[`isPharmacy(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L343) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isPlan(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L194) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category), [Medications: Self-administered OTCs](pattern_medications.html#self-administered-otcs) |
| [`isPreauthorization(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L189)<br/>[`isPreauthorization(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L301) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isPredetermination(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L195)<br/>[`isPredetermination(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L307) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isPreparation(FHIR.MedicationDispense)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L438) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isPrimaryProcedure(List<FHIR.CodeableConcept>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L401) | Fluent function | ClaimCommon | [Billing-related Elements: Primary Procedure](pattern_billingrelated.html#primary-procedure), [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures), [Claim: Primary Procedure](pattern_claim.html#primary-procedure), [Claim: Examples](pattern_claim.html#examples-2) |
| [`isPrincipalDiagnosis(List<FHIR.CodeableConcept>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L387) | Fluent function | ClaimCommon | [Billing-related Elements: Principal Diagnosis](pattern_billingrelated.html#principal-diagnosis), [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures), [Claim: Principal Diagnosis](pattern_claim.html#principal-diagnosis), [Claim: Examples](pattern_claim.html#examples-1) |
| [`isProblemListItem(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Conditions: Active conditions](pattern_conditions.html#active-conditions) |
| [`isProcedure(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isProfessional(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L218)<br/>[`isProfessional(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L330) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isProposal(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L200) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isProvisional(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Conditions: Verified Conditions](pattern_conditions.html#verified-conditions) |
| [`isPulseOximetry(FHIR.Observation)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L266) | Fluent function | CQMConcepts |  |
| [`isReasonForVisit(FHIR.Condition, FHIR.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L400) | Fluent function | CQMConcepts | [Billing-related Elements: Evidence of Diagnosis during an Encounter](pattern_billingrelated.html#evidence-of-diagnosis-during-an-encounter), [Encounters: Reason for Visit](pattern_encounters.html#reason-for-visit), [Encounters: Evidence of Diagnosis during an Encounter](pattern_encounters.html#evidence-of-diagnosis-during-an-encounter) |
| [`isRefuted(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`isRefuted(FHIR.AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Allergies: Verified Allergies](pattern_allergies.html#verified-allergies), [Conditions: Verified Conditions](pattern_conditions.html#verified-conditions) |
| [`isRelatedTo(Tuple{ claim USQualityCore.Claim, FHIR.id, FHIR.positiveInt, FHIR.CodeableConcept, FHIR.CodeableConcept, List<FHIR.CodeableConcept>, List<FHIR.CodeableConcept>, Interval<System.DateTime>, Choice<FHIR.Address,FHIR.CodeableConcept,FHIR.Reference>, FHIR.CodeableConcept, List<FHIR.CodeableConcept>, List<FHIR.Reference>, FHIR.positiveInt, Choice<FHIR.CodeableConcept,FHIR.Reference>, List<FHIR.CodeableConcept>, FHIR.CodeableConcept }, FHIR.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimElements.cql#L159) | Fluent function | ClaimElements | [Billing-related Elements: Evidence of Diagnosis during an Encounter](pattern_billingrelated.html#evidence-of-diagnosis-during-an-encounter), [Claim: Encounter-related Items](pattern_claim.html#encounter-related-items), [Claim: Evidence of Diagnosis on an Encounter](pattern_claim.html#evidence-of-diagnosis-on-an-encounter) |
| [`isResolved(FHIR.AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isResulted(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Observations](pattern_observations.html), [Observations: Smoking Status](pattern_observations.html#smoking-status), [Observations: Simple Observations](pattern_observations.html#simple-observations) |
| [`isSecondaryProcedure(List<FHIR.CodeableConcept>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L407) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isSocialHistory(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isStopped(FHIR.MedicationRequest)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L162)<br/>[`isStopped(FHIR.MedicationAdministration)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L344)<br/>[`isStopped(FHIR.MedicationDispense)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L456) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`isSurvey(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isTherapy(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`isUnconfirmed(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`isUnconfirmed(FHIR.AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Allergies: Verified Allergies](pattern_allergies.html#verified-allergies), [Conditions: Verified Conditions](pattern_conditions.html#verified-conditions) |
| [`isVerified(FHIR.Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`isVerified(FHIR.AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Allergies: Allergy date and relevant period](pattern_allergies.html#allergy-date-and-relevant-period), [Allergies: Verified Allergies](pattern_allergies.html#verified-allergies), [Billing-related Elements: History of a Condition](pattern_billingrelated.html#history-of-a-condition), [Conditions: Verified Conditions](pattern_conditions.html#verified-conditions), [Conditions: History of a condition](pattern_conditions.html#history-of-a-condition), [Conditions: Diagnosis date and relevant period](pattern_conditions.html#diagnosis-date-and-relevant-period), [Logic Layers: Item Level, List Level, or Both](pattern_layers.html#item-level-list-level-or-both) |
| [`isVision(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L243)<br/>[`isVision(FHIR.ExplanationOfBenefit)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L355) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`isVitalSign(FHIR.Observation)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
{: .grid}

#### L {#declarations-l}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"laboratory"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"Laboratory Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L109) | Code | ClaimCommon |  |
| [`lastFirstMiddle(FHIR.HumanName)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`lastName(FHIR.HumanName)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`latest(Choice<FHIR.dateTime, FHIR.Period, FHIR.Age, FHIR.Range>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [FHIR Patterns: Interval Calculations](pattern_fhir.html#interval-calculations), [FHIR Patterns: Further considerations](pattern_fhir.html#further-considerations) |
| [`lengthInDays(Interval<DateTime>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L45) | Fluent function | CQMCommon | [Encounters: Encounters with a certain length](pattern_encounters.html#encounters-with-a-certain-length) |
| [`lengthInDays(Interval<DateTime>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L108) | Fluent function | CQMConcepts | [Encounters: Encounters with a certain length](pattern_encounters.html#encounters-with-a-certain-length), [Encounters: Hospitalization Period and Length Of Stay](pattern_encounters.html#hospitalization-period-and-length-of-stay) |
| [`"LOINC"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L54) | Code system | CQMConcepts |  |
| [`"LOINC"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"LOINC"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code system | USCoreElements |  |
{: .grid}

#### M {#declarations-m}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"Male"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"Male (finding)"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L24) | Code | SupplementalDataElements |  |
| [`"Measurement Period"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L21) | Parameter | CQMCommon |  |
| [`"Measurement Period"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMInferences.cql#L22) | Parameter | CQMInferences | [Encounters: Encounter Definitions](pattern_encounters.html#encounter-definitions), [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters) |
| [`"MedicalRecordNumber"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`medicalRecordNumber(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`medication(MedicationAdministrationNotDone)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html)<br/>[`medication(MedicationDispenseDeclined)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html)<br/>[`medication(MedicationNotRequested)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon | [Negation Patterns: Extent of negation](pattern_negation.html#extent-of-negation) |
| [`"medicationadministration-community"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L95) | Code | MedicationCommon |  |
| [`"medicationadministration-completed"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L87) | Code | MedicationCommon |  |
| [`"medicationadministration-entered-in-error"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L88) | Code | MedicationCommon |  |
| [`"medicationadministration-in-progress"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L84) | Code | MedicationCommon |  |
| [`"medicationadministration-inpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L93) | Code | MedicationCommon |  |
| [`"medicationadministration-not-done"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L85) | Code | MedicationCommon |  |
| [`"medicationadministration-on-hold"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L86) | Code | MedicationCommon |  |
| [`"medicationadministration-outpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L94) | Code | MedicationCommon |  |
| [`"medicationadministration-stopped"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L89) | Code | MedicationCommon |  |
| [`"medicationadministration-unknown"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L90) | Code | MedicationCommon |  |
| [`"MedicationAdministrationCategoryCodes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L54) | Code system | MedicationCommon |  |
| [`MedicationAdministrationPeriod(MedicationAdministration)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`medicationAdministrationPeriod(MedicationAdministration)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Fluent function | CumulativeMedicationDuration |  |
| [`"MedicationAdministrationStatusCodes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L53) | Code system | MedicationCommon |  |
| [`"medicationdispense-cancelled"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L100) | Code | MedicationCommon |  |
| [`"medicationdispense-completed"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L102) | Code | MedicationCommon |  |
| [`"medicationdispense-declined"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L105) | Code | MedicationCommon |  |
| [`"medicationdispense-entered-in-error"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L103) | Code | MedicationCommon |  |
| [`"medicationdispense-in-progress"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L99) | Code | MedicationCommon |  |
| [`"medicationdispense-on-hold"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L101) | Code | MedicationCommon |  |
| [`"medicationdispense-preparation"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L98) | Code | MedicationCommon |  |
| [`"medicationdispense-stopped"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L104) | Code | MedicationCommon |  |
| [`"medicationdispense-unknown"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L106) | Code | MedicationCommon |  |
| [`MedicationDispensePeriod(MedicationDispense)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`medicationDispensePeriod(MedicationDispense)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Fluent function | CumulativeMedicationDuration |  |
| [`"MedicationDispenseStatusCodes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L55) | Code system | MedicationCommon |  |
| [`MedicationPeriod(Choice<MedicationRequest, MedicationDispense>)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`medicationPeriod(Choice<MedicationRequest, MedicationDispense>)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Fluent function | CumulativeMedicationDuration |  |
| [`"medicationrequest-active"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L58) | Code | MedicationCommon |  |
| [`"medicationrequest-cancelled"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L60) | Code | MedicationCommon |  |
| [`"medicationrequest-community"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L80) | Code | MedicationCommon |  |
| [`"medicationrequest-completed"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L61) | Code | MedicationCommon |  |
| [`"medicationrequest-discharge"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L81) | Code | MedicationCommon |  |
| [`"medicationrequest-draft"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L64) | Code | MedicationCommon |  |
| [`"medicationrequest-entered-in-error"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L62) | Code | MedicationCommon |  |
| [`"medicationrequest-filler-order"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L73) | Code | MedicationCommon |  |
| [`"medicationrequest-inpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L78) | Code | MedicationCommon |  |
| [`"medicationrequest-instance-order"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L74) | Code | MedicationCommon |  |
| [`"medicationrequest-on-hold"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L59) | Code | MedicationCommon |  |
| [`"medicationrequest-option"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L75) | Code | MedicationCommon |  |
| [`"medicationrequest-order"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L70) | Code | MedicationCommon |  |
| [`"medicationrequest-original-order"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L71) | Code | MedicationCommon |  |
| [`"medicationrequest-outpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L79) | Code | MedicationCommon |  |
| [`"medicationrequest-plan"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L69) | Code | MedicationCommon |  |
| [`"medicationrequest-proposal"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L68) | Code | MedicationCommon |  |
| [`"medicationrequest-reflex-order"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L72) | Code | MedicationCommon |  |
| [`"medicationrequest-stopped"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L63) | Code | MedicationCommon |  |
| [`"medicationrequest-unknown"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L65) | Code | MedicationCommon |  |
| [`"MedicationRequestCategory"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"MedicationRequestCategoryCodes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L52) | Code system | MedicationCommon |  |
| [`"MedicationRequestIntentCodes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L51) | Code system | MedicationCommon |  |
| [`MedicationRequestPeriod(MedicationRequest)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`medicationRequestPeriod(MedicationRequest)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Fluent function | CumulativeMedicationDuration |  |
| [`"MedicationRequestStatusCodes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L50) | Code system | MedicationCommon |  |
| [`"Member Number"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code | USCoreElements |  |
| [`memberID(FHIR.Coverage)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements | [Coverage: Member or subscriber ID](pattern_coverage.html#member-or-subscriber-id) |
| [`memberOf(code, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`memberOf(Coding, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`memberOf(CodeableConcept, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`middleNames(FHIR.HumanName)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`mobile(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html)<br/>[`mobile(FHIR.Practitioner)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`modifierExt(DomainResource, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`modifierExt(BackboneElement, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`modifierExtension(BackboneElement, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`modifierExtension(DomainResource, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`modifierExts(DomainResource, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`modifierExts(BackboneElement, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"MORN"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"MORN.early"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"MORN.late"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Most Recent BSA"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Most Recent Medication Request"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Most Recent Smoking Status"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`mostRecent()`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) (5 overloads) | Fluent function | FHIRCommon |  |
| [`mostRecent(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L306) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`MostRecentSR(List<FHIR.ServiceRequest>)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`mostRecentSR(List<FHIR.ServiceRequest>)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
{: .grid}

#### N {#declarations-n}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`naic(FHIR.Organization)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L339) | Fluent function | CQMConcepts |  |
| [`name(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html)<br/>[`name(FHIR.Practitioner)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`"Negative"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`negative(List<FHIR.Observation>)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`"NIGHT"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"No Known Allergies (Confirmed)"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"No Known Allergies (Not Asked)"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"No known allergy (situation)"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code | USCoreElements |  |
| [`"Nonbinary"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"NOON"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Normalize Encounters"(List<USQualityCore.Encounter>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L109) | Function | CQMElements | [Encounters: Normalized Encounters](pattern_encounters.html#normalized-encounters) |
| [`notDoneReason(ObservationCancelled)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`npi(FHIR.Organization)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L317)<br/>[`npi(FHIR.Practitioner)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L350) | Fluent function | CQMConcepts |  |
| [`"Nursing Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L110) | Code | ClaimCommon |  |
{: .grid}

#### O {#declarations-o}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"Observation Encounter"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L33) | Expression | CQMElements | [Encounters: Encounter Definitions](pattern_encounters.html#encounter-definitions), [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters), [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services), [Encounters: Normalized Encounters](pattern_encounters.html#normalized-encounters) |
| [`"observation encounter"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"observation encounter"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`"Observation Encounter During Measurement Period"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMInferences.cql#L35) | Expression | CQMInferences |  |
| [`"Observation Services"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L18) | Value set | CQMCommon |  |
| [`"Observation Services"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L45) | Value set | CQMConcepts |  |
| [`"observation-amended"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"observation-cancelled"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"observation-corrected"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"observation-entered-in-error"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"observation-final"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"observation-preliminary"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"observation-registered"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"observation-unknown"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"ObservationCategoryCodes"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"ObservationInterpretation"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
| [`"ObservationStatusCodes"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`observationVisit(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L212) | Fluent function | CQMElements | [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services) |
| [`officialName(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html)<br/>[`officialName(FHIR.Practitioner)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`ofType(String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`"Once daily (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"One to four times a day (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"One to three times a day (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"One to two times a day (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`onHold(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L136) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`orderIntent(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L219) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`"Outpatient"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`outpatient(List<FHIR.Claim>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L446)<br/>[`outpatient(List<FHIR.ExplanationOfBenefit>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L476) | Fluent function | ClaimCommon |  |
| [`outpatient(List<FHIR.MedicationRequest>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L263)<br/>[`outpatient(List<FHIR.MedicationAdministration>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql#L395) | Fluent function | MedicationCommon | [Medications: Medication status, intent, and category](pattern_medications.html#medication-status-intent-and-category) |
| [`"Outpatient Surgery Encounter"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L37) | Expression | CQMElements | [Encounters: Encounter Definitions](pattern_encounters.html#encounter-definitions), [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services) |
| [`"Outpatient Surgery Encounter During Measurement Period"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMInferences.cql#L39) | Expression | CQMInferences |  |
| [`"Outpatient Surgery Service"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L19) | Value set | CQMCommon |  |
| [`"Outpatient Surgery Service"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L46) | Value set | CQMConcepts |  |
| [`outpatientSurgeryVisit(USQualityCore.Encounter)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql#L225) | Fluent function | CQMElements | [Encounters: Observation and Outpatient Surgery Services](pattern_encounters.html#observation-and-outpatient-surgery-services) |
| [`"Oxygen Saturation in Arterial Blood"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L66) | Code | CQMConcepts |  |
| [`"Oxygen Saturation in Arterial Blood by Pulse Oximetry"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L65) | Code | CQMConcepts |  |
{: .grid}

#### P {#declarations-p}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"Payer Type"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L21) | Value set | SupplementalDataElements | [Coverage: Payer](pattern_coverage.html#payer) |
| [`"PC"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"PCD"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"PCM"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"PCV"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Pediatric BMI for Age"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Pediatric BMI for Age All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Pediatric Head Circumference Percentile"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Pediatric Head Circumference Percentile All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Pediatric Weight for Height"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Pediatric Weight for Height All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`Period(System.DateTime, System.DateTime, System.Boolean)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L421) | Function | CQMConcepts | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue) |
| [`Period(Interval<DateTime>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L215) | Function | FHIRBuilders |  |
| [`"PHS"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"POA-1"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L125) | Code | ClaimCommon |  |
| [`"POA-N"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L123) | Code | ClaimCommon |  |
| [`"POA-U"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L126) | Code | ClaimCommon |  |
| [`"POA-W"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L124) | Code | ClaimCommon |  |
| [`"POA-Y"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L122) | Code | ClaimCommon |  |
| [`pointOfOrigin(FHIR.Claim)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L375) | Fluent function | ClaimCommon | [Billing-related Elements: Admission Source](pattern_billingrelated.html#admission-source), [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures), [Claim: Admission Source](pattern_claim.html#admission-source) |
| [`"pointoforigin"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L92) | Code | ClaimCommon |  |
| [`policyNumber(FHIR.Coverage)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements | [Coverage: Member or subscriber ID](pattern_coverage.html#member-or-subscriber-id) |
| [`"Positive"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`positive(List<FHIR.Observation>)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`"post-op"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"pre-admission"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"pre-admission"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`"pre-op"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"Prenatal Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L111) | Code | ClaimCommon |  |
| [`"Present On Admission Indicators"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L48) | Code system | ClaimCommon | [Encounters: Present on Admission](pattern_encounters.html#present-on-admission) |
| [`"Present on Admission or Clinically Undetermined"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L57) | Value set | ClaimCommon |  |
| [`presentOnAdmission(USQualityCore."Encounter.Diagnosis")`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon | [Billing-related Elements: Present on Admission](pattern_billingrelated.html#present-on-admission), [Encounters: Present on Admission](pattern_encounters.html#present-on-admission) |
| [`prevalenceInterval(Condition)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`prevalenceInterval(AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Known Issues: Cannot Resolve Fluent Functions on Choices](knownissues.html#cannot-resolve-fluent-functions-on-choices), [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue), [Allergies: Onset, abatement, and prevalence period](pattern_allergies.html#onset-abatement-and-prevalence-period), [Billing-related Elements: Evidence of Diagnosis during an Encounter](pattern_billingrelated.html#evidence-of-diagnosis-during-an-encounter), [Conditions: Onset, abatement, and prevalence period](pattern_conditions.html#onset-abatement-and-prevalence-period), [Encounters: Evidence of Diagnosis during an Encounter](pattern_encounters.html#evidence-of-diagnosis-during-an-encounter), [FHIR Patterns: Further considerations](pattern_fhir.html#further-considerations) |
| [`prevalencePeriod(FHIR.Condition)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L435)<br/>[`prevalencePeriod(FHIR.AllergyIntolerance)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L484) | Fluent function | CQMConcepts | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue), [Allergies: Allergy date and relevant period](pattern_allergies.html#allergy-date-and-relevant-period), [Billing-related Elements: Evidence of Diagnosis during an Encounter](pattern_billingrelated.html#evidence-of-diagnosis-during-an-encounter), [Conditions: Active conditions](pattern_conditions.html#active-conditions), [Conditions: Diagnosis date and relevant period](pattern_conditions.html#diagnosis-date-and-relevant-period), [Encounters: Evidence of Diagnosis during an Encounter](pattern_encounters.html#evidence-of-diagnosis-during-an-encounter) |
| [`"Primary procedure"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L119) | Code | ClaimCommon |  |
| [`"Principal Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L112) | Code | ClaimCommon |  |
| [`"problem-list-item"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"procedure"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"Procedure Type Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L47) | Code system | ClaimCommon |  |
| [`"proceduretype-primary"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L87) | Code | ClaimCommon |  |
| [`"proceduretype-secondary"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L88) | Code | ClaimCommon |  |
| [`professional(List<FHIR.Claim>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L224)<br/>[`professional(List<FHIR.ExplanationOfBenefit>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L336) | Fluent function | ClaimCommon |  |
| [`"provisional"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`provisional(List<FHIR.Condition>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"Pulse Oximetry"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Pulse Oximetry All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
{: .grid}

#### Q {#declarations-q}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`Quantity(Decimal, String)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`Quantity(System.Quantity)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L254) | Function | FHIRBuilders |  |
{: .grid}

#### R {#declarations-r}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"Race"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L22) | Value set | SupplementalDataElements |  |
| [`race(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon | [FHIR Patterns: Authoring against the US Quality Core model](pattern_fhir.html#authoring-against-the-us-quality-core-model), [Patient: Patient race and ethnicity](pattern_patient.html#patient-race-and-ethnicity) |
| [`"Radiology Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L113) | Code | ClaimCommon |  |
| [`reasonRefused(ServiceNotRequested)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`recorded()`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) (5 overloads) | Fluent function | USQualityCoreCommon | [FHIR Patterns: Retrieve by profile](pattern_fhir.html#retrieve-by-profile) |
| [`"recurrence"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue) |
| [`Reference(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L319) | Function | FHIRBuilders |  |
| [`reference(String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`reference(Resource)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers | [FHIR Patterns: References](pattern_fhir.html#references) |
| [`references(FHIR.Reference, FHIR.Resource)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`references(FHIR.Reference, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`references(List<FHIR.Reference>, FHIR.Resource)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`references(List<FHIR.Reference>, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Billing-related Elements: Evidence of Diagnosis during an Encounter](pattern_billingrelated.html#evidence-of-diagnosis-during-an-encounter), [Billing-related Elements: CMS1218](pattern_billingrelated.html#cms1218), [Billing-related Elements: Present on Admission](pattern_billingrelated.html#present-on-admission), [Billing-related Elements: Principal Diagnosis](pattern_billingrelated.html#principal-diagnosis), [Billing-related Elements: Primary Procedure](pattern_billingrelated.html#primary-procedure), [Claim: Encounter-related Items](pattern_claim.html#encounter-related-items), [Devices: Device ordered](pattern_devices.html#device-ordered), [Devices: Device not ordered](pattern_devices.html#device-not-ordered), [Encounters: Reason for Visit](pattern_encounters.html#reason-for-visit), [Encounters: Evidence of Diagnosis during an Encounter](pattern_encounters.html#evidence-of-diagnosis-during-an-encounter), [Encounters: Present on Admission](pattern_encounters.html#present-on-admission), [Encounters: Principal Diagnosis](pattern_encounters.html#principal-diagnosis), [Encounters: Primary Procedure](pattern_encounters.html#primary-procedure), [FHIR Patterns: References](pattern_fhir.html#references), [Medications: Medication ordered](pattern_medications.html#medication-ordered), [Medications: Medication Not Ordered](pattern_medications.html#medication-not-ordered), [Negation Patterns: Positive requests and rejected proposals](pattern_negation.html#positive-requests-and-rejected-proposals), [Observations: Observations Not Done](pattern_observations.html#observations-not-done), [Observations: Observations Non-Patient](pattern_observations.html#observations-non-patient), [Procedures: Procedure ordered](pattern_procedures.html#procedure-ordered), [Procedures: Procedure not ordered](pattern_procedures.html#procedure-not-ordered), [Procedures: Imaging Procedures](pattern_procedures.html#imaging-procedures), [US Quality Core Update Process: Example: Updated Billing Access](usqc_update_process.html#example-updated-billing-access) |
| [`"refuted"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`refuted(List<FHIR.Condition>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`refuted(List<FHIR.AllergyIntolerance>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"relapse"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue) |
| [`RelatedCondition(FHIR.ServiceRequest)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`relevantDate(FHIR.Condition)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L452)<br/>[`relevantDate(FHIR.AllergyIntolerance)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L501) | Fluent function | CQMConcepts | [Allergies: Allergy date and relevant period](pattern_allergies.html#allergy-date-and-relevant-period), [Conditions: Diagnosis date and relevant period](pattern_conditions.html#diagnosis-date-and-relevant-period) |
| [`relevantPeriod(FHIR.Condition)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L469)<br/>[`relevantPeriod(FHIR.AllergyIntolerance)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L518) | Fluent function | CQMConcepts | [Allergies: Allergy date and relevant period](pattern_allergies.html#allergy-date-and-relevant-period), [Billing-related Elements: Evidence of Diagnosis during an Encounter](pattern_billingrelated.html#evidence-of-diagnosis-during-an-encounter), [Conditions: Active conditions](pattern_conditions.html#active-conditions), [Conditions: Diagnosis date and relevant period](pattern_conditions.html#diagnosis-date-and-relevant-period), [Encounters: Evidence of Diagnosis during an Encounter](pattern_encounters.html#evidence-of-diagnosis-during-an-encounter) |
| [`"remission"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"Remote Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L114) | Code | ClaimCommon |  |
| [`Requester(MedicationRequestProfile)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`RequesterRole(MedicationRequestProfile)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`RequestingProvider(FHIR.ServiceRequest)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`"RequestIntent"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"Research Subject"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`resolutionAge(AllergyIntolerance)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`resolve(String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`resolve(Reference)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers | [FHIR Patterns: References](pattern_fhir.html#references) |
| [`"resolved"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`resolved(List<FHIR.AllergyIntolerance>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`resulted(List<FHIR.Observation>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"Resulted Laboratory Results"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"Retrospective Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L115) | Code | ClaimCommon |  |
| [`"RoleCode"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L77) | Code system | CQMConcepts |  |
| [`"RoleCode"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`RolloutIntervals(List<Interval<Date>>)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`rolloutIntervals(List<Interval<Date>>)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Fluent function | CumulativeMedicationDuration |  |
| [`"Rx Transmission Method"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
{: .grid}

#### S {#declarations-s}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"SDE Ethnicity"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L29) | Expression | SupplementalDataElements |  |
| [`"SDE Payer"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L36) | Expression | SupplementalDataElements | [Coverage: Payer](pattern_coverage.html#payer) |
| [`"SDE Race"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L43) | Expression | SupplementalDataElements |  |
| [`"SDE Sex"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L50) | Expression | SupplementalDataElements |  |
| [`"Self Diagnosis"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L116) | Code | ClaimCommon |  |
| [`ServicingProvider(FHIR.ServiceRequest)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Function | USCoreElements |  |
| [`severity(FamilyMemberHistory)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`sex(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon | [US Quality Core Update Process: Step 4: Replace extension elements:](usqc_update_process.html#step-4-replace-extension-elements) |
| [`sexParameterForClinicalUse(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html)<br/>[`sexParameterForClinicalUse(FHIR.Patient, System.DateTime)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`"short stay"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"short stay"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon |  |
| [`slice(Element, String, String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`"Smoking Status"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements | [Observations: Smoking Status](pattern_observations.html#smoking-status) |
| [`"Smoking Status All Statuses"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
| [`"SNOMED"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
| [`"SNOMEDCT"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"SNOMEDCT"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/SupplementalDataElements.cql#L17) | Code system | SupplementalDataElements |  |
| [`"social-history"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`string(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L150) | Function | FHIRBuilders |  |
| [`"Subscriber Number"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code | USCoreElements |  |
| [`subsumedBy(Coding, Coding)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`subsumedBy(CodeableConcept, CodeableConcept)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`subsumes(Coding, Coding)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`subsumes(CodeableConcept, CodeableConcept)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`"subtype-inpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L77) | Code | ClaimCommon |  |
| [`"subtype-outpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L78) | Code | ClaimCommon |  |
| [`"Supporting Info Type Codes"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L55) | Code system | ClaimCommon |  |
| [`"survey"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`systolic(FHIR.Observation)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon | [FHIR Patterns: Further considerations](pattern_fhir.html#further-considerations), [Observations: Vital Signs](pattern_observations.html#vital-signs) |
| [`"Systolic Blood Pressure"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"Systolic Blood Pressure"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Expression | USCoreElements |  |
{: .grid}

#### T {#declarations-t}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"TaskCodeSystem"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code system | FHIRCommon |  |
| [`"TaskCodeSystem"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code system | USQualityCoreCommon |  |
| [`"TESTING SUPPORT: Emergency Department Visit"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L529) | Expression (testing support) | CQMConcepts |  |
| [`"TESTING SUPPORT: Encounter Inpatient"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L536) | Expression (testing support) | CQMConcepts |  |
| [`"TESTING SUPPORT: Intensive Care Unit"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L543) | Expression (testing support) | CQMConcepts |  |
| [`"TESTING SUPPORT: Observation Services"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L550) | Expression (testing support) | CQMConcepts |  |
| [`"TESTING SUPPORT: Outpatient Surgery Service"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L557) | Expression (testing support) | CQMConcepts |  |
| [`"TESTING SUPPORT: Present on Admission or Clinically Undetermined"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L509) | Expression (testing support) | ClaimCommon |  |
| [`TherapeuticDuration(Concept)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`"therapy"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`"Three times daily (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`time(Time)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L162) | Function | FHIRBuilders |  |
| [`toActivityExtent(FHIR.CodeableConcept)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon | [FHIR Patterns: Terminology Functions](pattern_fhir.html#terminology-functions) |
| [`ToBoolean(boolean)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`ToCalendarUnit(System.String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`ToCode(FHIR.Coding)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue) |
| [`ToConcept(FHIR.CodeableConcept)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`ToDaily(System.Integer, System.Quantity)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html)<br/>[`ToDaily(Code)`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Function | CumulativeMedicationDuration |  |
| [`ToDate(date)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`toDateInterval(Interval<DateTime>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql#L39) | Fluent function | CQMCommon |  |
| [`toDateInterval(Interval<DateTime>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql#L96) | Fluent function | CQMConcepts |  |
| [`ToDateTime(dateTime)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`ToDateTime(instant)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`toDayNumbers(Interval<DateTime>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`toDayNumbers(Interval<DateTime>)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon |  |
| [`ToDecimal(decimal)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`toFHIRBase64Binary(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L36) | Fluent function | FHIRBuilders |  |
| [`toFHIRBoolean(Boolean)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L48) | Fluent function | FHIRBuilders |  |
| [`toFHIRCanonical(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L60) | Fluent function | FHIRBuilders |  |
| [`toFHIRCode(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L72) | Fluent function | FHIRBuilders |  |
| [`toFHIRCodeableConcept(System.Concept)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L291)<br/>[`toFHIRCodeableConcept(System.Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L306) | Fluent function | FHIRBuilders |  |
| [`toFHIRCoding(System.Code)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L271) | Fluent function | FHIRBuilders |  |
| [`toFHIRDate(Date)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L84) | Fluent function | FHIRBuilders |  |
| [`toFHIRDateTime(DateTime)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L96) | Fluent function | FHIRBuilders |  |
| [`toFHIRDecimal(Decimal)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L108) | Fluent function | FHIRBuilders |  |
| [`toFHIRId(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L120) | Fluent function | FHIRBuilders |  |
| [`toFHIRInstant(DateTime)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L132) | Fluent function | FHIRBuilders |  |
| [`toFHIRInteger(Integer)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L144) | Fluent function | FHIRBuilders |  |
| [`toFHIRPeriod(Interval<DateTime>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L224) | Fluent function | FHIRBuilders |  |
| [`toFHIRReference(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L325) | Fluent function | FHIRBuilders |  |
| [`toFHIRString(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L156) | Fluent function | FHIRBuilders |  |
| [`toFHIRTime(Time)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L168) | Fluent function | FHIRBuilders |  |
| [`toFHIRUri(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L180) | Fluent function | FHIRBuilders |  |
| [`toFHIRUrl(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L192) | Fluent function | FHIRBuilders |  |
| [`toFHIRXhtml(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L207) | Fluent function | FHIRBuilders |  |
| [`toIndividualSex(FHIR.code)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`ToInteger(integer)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`ToInterval(FHIR.Period)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`ToInterval(FHIR.Quantity)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html)<br/>[`ToInterval(FHIR.Range)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`toInterval(Choice<FHIR.dateTime, FHIR.Period, FHIR.Timing, FHIR.instant, FHIR.string, FHIR.Age, FHIR.Range>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Known Issues: Prevalence Interval Issue:](knownissues.html#prevalence-interval-issue), [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures), [Claim: CMS1028 - Severe Obstetric Complications](pattern_claim.html#cms1028---severe-obstetric-complications), [Encounters: Hospitalization Encounters](pattern_encounters.html#hospitalization-encounters), [FHIR Patterns: Retrieve by profile](pattern_fhir.html#retrieve-by-profile), [FHIR Patterns: References](pattern_fhir.html#references), [FHIR Patterns: Interval Calculations](pattern_fhir.html#interval-calculations), [FHIR Patterns: Further considerations](pattern_fhir.html#further-considerations), [Logic Layers: What to Provide Instead: Accessors](pattern_layers.html#what-to-provide-instead-accessors) |
| [`topic(CommunicationNotDone)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon | [Communication: Communication Not Done](pattern_communication.html#communication-not-done), [Negation Patterns: Extent of negation](pattern_negation.html#extent-of-negation) |
| [`ToQuantity(FHIR.Quantity)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`ToQuantityIgnoringComparator(FHIR.Quantity)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`ToRatio(FHIR.Ratio)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`toServicedInterval(Choice<FHIR.date, FHIR.Period>)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L495) | Fluent function | ClaimCommon | [Claim: Claim elements used by measures](pattern_claim.html#claim-elements-used-by-measures) |
| [`ToString()`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) (251 overloads) | Function | FHIRHelpers |  |
| [`ToTime(time)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`ToValue(Choice<base64Binary, boolean, canonical, code, date, dateTime, decimal, id, instant, integer, markdown, oid, positiveInt, string, time, unsignedInt, uri, url, uuid, Address, Age, Annotation, Attachment, CodeableConcept, Coding, ContactPoint, Count, Distance, Duration, HumanName, Identifier, Money, Period, Quantity, Range, Ratio, Reference, SampledData, Signature, Timing, ContactDetail, Contributor, DataRequirement, Expression, ParameterDefinition, RelatedArtifact, TriggerDefinition, UsageContext, Dosage, Meta>)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`ToValueSet(String)`]({{site.data.fhir.ver.cql}}/Library-FHIRHelpers.html) | Function | FHIRHelpers |  |
| [`toValueSet(FHIR.canonical)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon | [FHIR Patterns: Terminology Functions](pattern_fhir.html#terminology-functions) |
| [`transmissionMethod(FHIR.MedicationDispense)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`tribalAffiliation(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Fluent function | USCoreCommon |  |
| [`"Twice a day (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"Two to four times a day (qualifier value)"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`"type-institutional"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L95) | Code | ClaimCommon |  |
| [`"type-oral"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L96) | Code | ClaimCommon |  |
| [`"type-pharmacy"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L97) | Code | ClaimCommon |  |
| [`"type-professional"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L98) | Code | ClaimCommon |  |
| [`"type-vision"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L99) | Code | ClaimCommon |  |
{: .grid}

#### U {#declarations-u}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"unconfirmed"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
| [`unconfirmed(List<FHIR.Condition>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`unconfirmed(List<FHIR.AllergyIntolerance>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"Unknown"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`uri(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L174) | Function | FHIRBuilders |  |
| [`url(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L186) | Function | FHIRBuilders |  |
| [`url(FHIR.canonical)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"USCoreConditionCategory"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code system | USCoreCommon |  |
| [`"use-claim"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L72) | Code | ClaimCommon |  |
| [`"use-preauthorization"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L73) | Code | ClaimCommon |  |
| [`"use-predetermination"`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql#L74) | Code | ClaimCommon |  |
| [`usualName(FHIR.Patient)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html)<br/>[`usualName(FHIR.Practitioner)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
{: .grid}

#### V {#declarations-v}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"V3TimingEvent"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code system | CumulativeMedicationDuration |  |
| [`vaccineCode(ImmunizationNotDone)`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Fluent function | USQualityCoreCommon | [Immunizations: Immunization not performed](pattern_immunizations.html#immunization-not-performed), [Negation Patterns: Extent of negation](pattern_negation.html#extent-of-negation) |
| [`"Verification Status"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Code system | USCoreElements |  |
| [`verified(List<FHIR.Condition>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html)<br/>[`verified(List<FHIR.AllergyIntolerance>)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon | [Allergies: Verified Allergies](pattern_allergies.html#verified-allergies), [Conditions: Verified Conditions](pattern_conditions.html#verified-conditions), [Logic Layers: Item Level, List Level, or Both](pattern_layers.html#item-level-list-level-or-both) |
| [`version(FHIR.canonical)`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Fluent function | FHIRCommon |  |
| [`"virtual"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
| [`"virtual"`](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/Library-USQualityCoreCommon.html) | Code | USQualityCoreCommon | [Encounters: Encounters by class](pattern_encounters.html#encounters-by-class) |
| [`"vital-signs"`]({{site.data.fhir.ver.cql}}/Library-FHIRCommon.html) | Code | FHIRCommon |  |
{: .grid}

#### W {#declarations-w}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`"WAKE"`]({{site.data.fhir.ver.uscql}}/en/Library-CumulativeMedicationDuration.html) | Code | CumulativeMedicationDuration |  |
| [`work(FHIR.Organization)`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreElements.html) | Fluent function | USCoreElements |  |
| [`"Written Prescription"`]({{site.data.fhir.ver.uscql}}/en/Library-USCoreCommon.html) | Code | USCoreCommon |  |
{: .grid}

#### X {#declarations-x}

| Declaration | Kind | Library | Discussed in |
|----|----|----|----|
| [`xhtml(String)`](https://github.com/cqframework/cms-qmd/blob/main/input/cql/FHIRBuilders.cql#L201) | Function | FHIRBuilders |  |
{: .grid}

<!-- END GENERATED DECLARATION INDEX -->
