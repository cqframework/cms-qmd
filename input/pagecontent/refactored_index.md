This topic provides an index of the shared libraries used in QICore and USQualityCore, and where refactored content from those shared libraries can be found in the refactored versions.

### Library Index

This index lists all the shared libraries used by measures. Note that for QICore measures, all shared libraries were developed and published in MADiE, whereas for US Quality Core measures, a core set of shared libraries are published as part of HL7 or ONC implementation guides and made available through the NPM packages for those implementation guides. Libraries available in published implementation guides are listed in the table below with the namespace and name of the library, and linked to the published content for that library.

The remaining libraries are expected to still be developed in MADiE, but are included in the proposed set of refactored measures for reference, testing, and to support the development of this guidance. The version numbers of those libraries are suggested based on both a Major and Minor version increment for each library (for example, AdultOutpatientEncounters in QICore is version 4.19.000, whereas the suggested refactoring is 5.1.000). The content for these libraries is suggested, and it is expected that these libraries will be developed in MADiE once full US Quality Core support is available. Measure developers can use the content as a starting point for that development if desired.

| Library | QI Core version | US Quality Core version |
|----|----|----|
| AdultOutpatientEncounters | [4.19.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/AdultOutpatientEncounters.cql) | [5.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/AdultOutpatientEncounters.cql) |
| AdvancedIllnessandFrailty | [1.27.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/AdvancedIllnessandFrailty.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/AdvancedIllnessandFrailty.cql) |
| AHAOverall | [4.1.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/AHAOverall.cql) | [5.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/AHAOverall.cql) |
| AlaraCommonFunctions | [1.10.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/AlaraCommonFunctions.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/AlaraCommonFunctions.cql) |
| Antibiotic | [1.11.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/Antibiotic.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/Antibiotic.cql) |
| CQMCommon | [4.1.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/CQMCommon.cql) | [5.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/CQMCommon.cql) |
| CumulativeMedicationDuration | [6.0.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/CumulativeMedicationDuration.cql) | [hl7.fhir.us.cql.CumulativeMedicationDuration version '2.0.0'](https://hl7.org/fhir/us/cql/Library-CumulativeMedicationDuration.html) |
| FHIRHelpers | [4.4.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/FHIRHelpers.cql) | [hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'](https://hl7.org/fhir/uv/cql/Library-FHIRHelpers.html) |
| FHIRCommon | - | [hl7.fhir.uv.cql.FHIRCommon version '2.0.0'](https://hl7.org/fhir/uv/cql/Library-FHIRHelpers.html) |
| Hospice | [6.18.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/Hospice.cql) | [7.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/Hospice.cql) |
| NHSNHelpers | [0.1.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/NHSNHelpers.cql) | [1.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/NHSNHelpers.cql) |
| PalliativeCare | [1.18.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/PalliativeCare.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/PalliativeCare.cql) |
| PCMaternal | [5.25.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/PCMaternal.cql) | [6.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/PCMaternal.cql) |
| QICoreCommon | [4.0.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/QICoreCommon.cql) | refactored into FHIRCommon, USCoreCommon, and [USQualityCoreCommon](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| Status | [1.15.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/Status.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/Status.cql) |
| SupplementalDataElements | [5.1.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/SupplementalDataElements.cql) | [6.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/SupplementalDataElements.cql) |
| TJCOverall | [8.25.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/TJCOverall.cql) | [9.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/TJCOverall.cql) |
| VTE | [8.18.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/VTE.cql) | [9.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/VTE.cql) |
| USCoreCommon | - | [hl7.fhir.us.cql.USCoreCommon version '2.0.0'](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| USCoreElements | - | [hl7.fhir.us.cql.USCoreElements version '2.0.0'](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) |
| USQualityCoreCommon | - | [fhir.onc."us-quality-core".USQualityCoreCommon version '0.5.0'](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
{: .grid}

### Function Index

This index lists functions from the QICore-based library versions and where they are now following the refactor.

| **Library** | **Prior Version or Name** | **New Version or New Library/Location** | **USCoreCommon** |
|----|----|----|----|
| **CQMCommon** | **4.1.000** | **5.1.000** |  |
|  |  | The new CQMCommon deliberately retains that same arrangement. "ED Visit" is deprecated in favor of edVisit(), and "Hospitalization" is deprecated in favor of hospitalization(). <br>The first is retained primarily for backward compatibility; **the fluent function is preferred.** |  |
| **QICoreCommon** | deprecated | **FHIRCommon, USCoreCommon, or USQualityCoreCommon** |
|  |  | [FHIRCommon](https://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
|  |  | [USCoreCommon](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
|  |  | [USQualityCoreCommon](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
|  | **QICoreCommon function** | **New location** |
|  | isActive() | **FHIRCommon** |
|  | hasCategory(Condition, Code) | FHIRCommon |
|  | isProblemListItem() | FHIRCommon |
|  | isEncounterDiagnosis() | FHIRCommon |
|  | hasCategory(Observation, Code) | FHIRCommon |
|  | isSocialHistory() | FHIRCommon |
|  | isVitalSign() | FHIRCommon |
|  | isImaging() | FHIRCommon |
|  | isLaboratory() | FHIRCommon |
|  | isProcedure() | FHIRCommon |
|  | isSurvey() | FHIRCommon |
|  | isExam() | FHIRCommon |
|  | isTherapy() | FHIRCommon |
|  | isActivity() | FHIRCommon |
|  | isCommunity() | FHIRCommon |
|  | isDischarge() | FHIRCommon |
|  | references() | FHIRCommon |
|  | toInterval() | FHIRCommon |
|  | abatementInterval() | FHIRCommon |
|  | prevalenceInterval() | FHIRCommon |
|  | includesCode() | FHIRCommon |
|  | HasStart() / hasStart() | FHIRCommon |
|  | HasEnd() / hasEnd() | FHIRCommon |
|  | Latest() / latest() | FHIRCommon |
|  | Earliest() / earliest() | FHIRCommon |
|  | getId() | **USQualityCoreCommon** |
|  | "Interval To Day Numbers" / toDayNumbers() | USQualityCoreCommon |
|  | "Days In Period" / daysInPeriod() | USQualityCoreCommon |
|  | doNotPerform(DeviceNotRequested) | USQualityCoreCommon |
|  | DeviceNotRequested.doNotPerformReason() | USQualityCoreCommon |
|  | DeviceNotRequested.doNotPerform() | USQualityCoreCommon |
|  | DeviceNotRequested.code() | USQualityCoreCommon |
|  | CommunicationNotDone.recorded() | USQualityCoreCommon |
|  | CommunicationNotDone.topic() | USQualityCoreCommon |
|  | ImmunizationNotDone.vaccineCode() | USQualityCoreCommon |
|  | MedicationAdministrationNotDone.recorded() | USQualityCoreCommon |
|  | MedicationAdministrationNotDone.medication() | USQualityCoreCommon |
|  | MedicationDispenseDeclined.recorded() | USQualityCoreCommon |
|  | MedicationDispenseDeclined.medication() | USQualityCoreCommon |
|  | MedicationNotRequested.medication() | USQualityCoreCommon |
|  | ObservationCancelled.notDoneReason() | USQualityCoreCommon |
|  | ObservationCancelled.code() | USQualityCoreCommon |
|  | ProcedureNotDone.recorded() | USQualityCoreCommon |
|  | ProcedureNotDone.code() | USQualityCoreCommon |
|  | ServiceNotRequested.reasonRefused() | USQualityCoreCommon |
|  | ServiceNotRequested.code() | USQualityCoreCommon |
|  | TaskRejected.code() | USQualityCoreCommon |
|  | isHealthConcern() | **USCoreCommon** |
| **Cumulative Medication Duration** | **6.0.000** | **hl7.fhir.us.cql.CumulativeMedicationDuration 2.0.0** |
|  |  | No changes |
| **Status** | **Old Status 1.15.000** | **New Status 2.1.000** |  |
|  | verified() (consider deprecating) | FHIRCommon verified() should be used instead |
{: .grid}

### Extension Index

This index lists every element that QI Core STU6 and US Quality Core 0.5.0 represent as an *extension* rather than as a core FHIR element, and shows where each one landed in the refactor. Extensions reach these profiles from three places: **inherited from US Core 6.1.0**, **defined by the IG itself**, or **borrowed from base FHIR and SDC**. Each is covered below.

Profile names map one-to-one between the two IGs: `QICore<Name>` in QI Core STU6 becomes `USQualityCore<Name>` in US Quality Core 0.5.0. Both IGs publish 57 profiles and 8 extension definitions, and every extension slice is at the same element path with the same slice name in both. The profile column below gives the US Quality Core name; prefix it with `QICore` instead of `USQualityCore` for the QI Core STU6 equivalent.

**Extensions inherited from US Core 6.1.0**

QI Core STU6 and US Quality Core 0.5.0 both depend on **US Core 6.1.0**, so this layer is identical in both IGs and was not touched by the refactor. US Core 6.1.0 publishes 49 profiles and 10 extension definitions.

Only four US Core profiles slice extensions into their content, 16 slices in total. Every one of them is inherited unchanged (i.e. Preserved) by the corresponding US Quality Core profile, and each appears in the by-profile table further below.

| US Core 6.1.0 profile | Extension slices | Inherited by | Preserved |
|----|----|----|----|
| [USCoreConditionEncounterDiagnosis](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-condition-encounter-diagnosis.html) | 1 | [USQualityCoreConditionEncounterDiagnosis](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-condition-encounter-diagnosis.html) | 1 of 1 |
| [USCoreConditionProblemsHealthConcerns](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-condition-problems-health-concerns.html) | 1 | [USQualityCoreConditionProblemsHealthConcerns](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-condition-problems-health-concerns.html) | 1 of 1 |
| [USCorePatient](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-patient.html) | 6 | [USQualityCorePatient](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-patient.html) | 6 of 6 |
| [USCoreQuestionnaireResponse](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-questionnaireresponse.html) | 8 | [USQualityCoreQuestionnaireResponse](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-questionnaireresponse.html) | 8 of 8 |
{: .grid}

The 10 extension definitions US Core 6.1.0 publishes, and where each one is used:

| US Core 6.1.0 extension | Allowed context | Sliced into | CQL accessor |
|----|----|----|----|
| [us-core-birthsex](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-birthsex.html) | `Patient` | [us-core-patient](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-patient.html) &rarr; `Patient.extension:birthsex` | [birthSex()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| [us-core-direct](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-direct.html) | `ContactPoint` | *not sliced into any profile* | *none* |
| [us-core-ethnicity](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-ethnicity.html) | `Patient`, `RelatedPerson`, `Person`, `Practitioner`, `FamilyMemberHistory` | [us-core-patient](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-patient.html) &rarr; `Patient.extension:ethnicity` | [ethnicity()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| [us-core-extension-questionnaire-uri](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-extension-questionnaire-uri.html) | `QuestionnaireResponse.questionnaire` | [us-core-questionnaireresponse](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-questionnaireresponse.html) &rarr; `QuestionnaireResponse.questionnaire.extension:url` | *none* |
| [us-core-genderIdentity](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-genderIdentity.html) | `Patient`, `RelatedPerson`, `Person`, `Practitioner` | [us-core-patient](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-patient.html) &rarr; `Patient.extension:genderIdentity` | *none* |
| [us-core-jurisdiction](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-jurisdiction.html) | `Element` | *not sliced into any profile* | *none* |
| [us-core-race](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-race.html) | `Patient`, `RelatedPerson`, `Person`, `Practitioner`, `FamilyMemberHistory` | [us-core-patient](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-patient.html) &rarr; `Patient.extension:race` | [race()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| [us-core-sex](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-sex.html) | `Patient` | [us-core-patient](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-patient.html) &rarr; `Patient.extension:sex` | [sex()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) *(deprecated)* use [individualSex()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| [us-core-tribal-affiliation](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-tribal-affiliation.html) | `Patient`, `RelatedPerson`, `Person`, `Practitioner`, `FamilyMemberHistory` | [us-core-patient](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-patient.html) &rarr; `Patient.extension:tribalAffiliation` | [tribalAffiliation()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| [uscdi-requirement](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-uscdi-requirement.html) | `ElementDefinition` | *tooling only &mdash; applied to `ElementDefinition` in 48 US Core StructureDefinitions* | &mdash; |
{: .grid}

`us-core-direct` and `us-core-jurisdiction` are published but not sliced into any US Core profile, so they never reach QI Core or US Quality Core by inheritance; they remain available for direct use. `uscdi-requirement` is the US Core counterpart of `qicore-keyelement`/`uscdiplusquality` &mdash; it annotates `ElementDefinition`, not patient data.

Note the allowed contexts: `race`, `ethnicity`, and `tribalAffiliation` are also legal on `RelatedPerson`, `Person`, `Practitioner`, and `FamilyMemberHistory`, but US Core slices them only into `us-core-patient`. `USQualityCoreRelatedPerson` and `USQualityCorePractitioner` therefore do not declare them, and the USCoreCommon accessors are all typed to `FHIR.Patient`.

**Extension definitions published by the IG**

The extensions QI Core defined itself were renamed from `qicore-*` to `us-quality-core-*` and moved to the `http://fhir.org/guides/onc/us-quality-core/StructureDefinition/` canonical base. Nothing was dropped and nothing was added.

| QI Core STU6 | US Quality Core 0.5.0 | Context |
|----|----|----|
| [qicore-doNotPerformReason](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-doNotPerformReason.html) | [us-quality-core-doNotPerformReason](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-doNotPerformReason.html) | `Resource` |
| [qicore-encounter-diagnosisPresentOnAdmission](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-encounter-diagnosisPresentOnAdmission.html) | [us-quality-core-encounter-diagnosisPresentOnAdmission](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-encounter-diagnosisPresentOnAdmission.html) | `Encounter.diagnosis` |
| [qicore-isElective](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-isElective.html) | [us-quality-core-isElective](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-isElective.html) | `ServiceRequest` |
| [qicore-notDoneReason](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneReason.html) | [us-quality-core-notDoneReason](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneReason.html) | `Resource` |
| [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) | [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | `CodeableConcept` |
| [qicore-recorded](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-recorded.html) | [us-quality-core-recorded](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-recorded.html) | `Resource` |
| [qicore-servicerequest-appropriatenessScore](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-servicerequest-appropriatenessScore.html) | [us-quality-core-servicerequest-appropriatenessScore](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-servicerequest-appropriatenessScore.html) | `ServiceRequest` |
| [qicore-keyelement](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-keyelement.html) | [uscdiplusquality](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-uscdiplusquality.html) | `ElementDefinition, ElementDefinition.type.targetProfile, ElementDefinition.type` |
{: .grid}

`isElective` and `servicerequest-appropriatenessScore` are defined but not used by any profile in either IG. `qicore-keyelement`/`uscdiplusquality` is a tooling extension applied to `ElementDefinition` inside every profile to flag key elements; it is not a data element and does not appear in the table below.

**Extension-backed elements, by profile**

19 of the 57 US Quality Core profiles carry extension-backed elements (18 of the 57 in QI Core STU6). The remaining 38 profiles have none.

Extensions borrowed from base FHIR, US Core, and SDC are marked *unchanged* &mdash; the same canonical URL is used in both IGs.

| Profile | Element | Card. | Extension | CQL accessor in US Quality Core |
|----|----|----|----|----|
| [AllergyIntolerance](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-allergyintolerance.html) | `AllergyIntolerance.extension:resolutionAge` | 0..1 | [allergyintolerance-resolutionAge](http://hl7.org/fhir/R4/extension-allergyintolerance-resolutionage.html) (unchanged) | [resolutionAge()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [CommunicationNotDone](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-communicationnotdone.html) | `Communication.extension:recorded` | 1..1 | [qicore-recorded](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-recorded.html) &rarr; [us-quality-core-recorded](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-recorded.html) | [recorded()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| &nbsp; | `Communication.topic.extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [topic()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [ConditionEncounterDiagnosis](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-condition-encounter-diagnosis.html) | `Condition.extension:assertedDate` | 0..1 | [condition-assertedDate](http://hl7.org/fhir/R4/extension-condition-asserteddate.html) (unchanged) | [assertedDate()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| [ConditionProblemsHealthConcerns](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-condition-problems-health-concerns.html) | `Condition.extension:assertedDate` | 0..1 | [condition-assertedDate](http://hl7.org/fhir/R4/extension-condition-asserteddate.html) (unchanged) | [assertedDate()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| [DeviceNotRequested](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-devicenotrequested.html) | `DeviceRequest.extension:doNotPerformReason` | 1..1 | [qicore-doNotPerformReason](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-doNotPerformReason.html) &rarr; [us-quality-core-doNotPerformReason](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-doNotPerformReason.html) | [doNotPerformReason()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| &nbsp; | `DeviceRequest.modifierExtension:doNotPerform` | 1..1 | `extension-DeviceRequest.doNotPerform` (R5 cross-version, unchanged) | [doNotPerform()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| &nbsp; | `DeviceRequest.code[x].extension:doNotPerformValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [code()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [DeviceRequest](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-devicerequest.html) | `DeviceRequest.modifierExtension:doNotPerform` | 0..1 | `extension-DeviceRequest.doNotPerform` (R5 cross-version, unchanged) | [doNotPerform()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) &#9888; |
| [Encounter](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-encounter.html) | `Encounter.diagnosis.extension:diagnosisPresentOnAdmission` **new in 0.5.0** | 0..1 | [qicore-encounter-diagnosisPresentOnAdmission](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-encounter-diagnosisPresentOnAdmission.html) &rarr; [us-quality-core-encounter-diagnosisPresentOnAdmission](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-encounter-diagnosisPresentOnAdmission.html) | [presentOnAdmission()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [FamilyMemberHistory](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-familymemberhistory.html) | `FamilyMemberHistory.condition.extension:condition-abatement` | 0..1 | [familymemberhistory-abatement](http://hl7.org/fhir/R4/extension-familymemberhistory-abatement.html) (unchanged) | [abatement()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) &#9888; |
| &nbsp; | `FamilyMemberHistory.condition.extension:condition-severity` | 0..1 | [familymemberhistory-severity](http://hl7.org/fhir/R4/extension-familymemberhistory-severity.html) (unchanged) | [severity()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) &#9888; |
| [ImmunizationNotDone](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-immunizationnotdone.html) | `Immunization.vaccineCode.extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [vaccineCode()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [MedicationAdministrationNotDone](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-medicationadministrationnotdone.html) | `MedicationAdministration.extension:recorded` | 1..1 | [qicore-recorded](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-recorded.html) &rarr; [us-quality-core-recorded](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-recorded.html) | [recorded()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| &nbsp; | `MedicationAdministration.medication[x].extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [medication()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [MedicationDispenseDeclined](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-medicationdispensedeclined.html) | `MedicationDispense.extension:recorded` | 1..1 | [qicore-recorded](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-recorded.html) &rarr; [us-quality-core-recorded](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-recorded.html) | [recorded()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| &nbsp; | `MedicationDispense.medication[x].extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [medication()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [MedicationNotRequested](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-medicationnotrequested.html) | `MedicationRequest.medication[x].extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [medication()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [ObservationCancelled](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-observationcancelled.html) | `Observation.extension:notDoneReason` | 1..1 | [qicore-notDoneReason](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneReason.html) &rarr; [us-quality-core-notDoneReason](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneReason.html) | [notDoneReason()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| &nbsp; | `Observation.code.extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [code()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [Patient](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-patient.html) | `Patient.extension:race` | 0..1 | [us-core-race](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-race.html) (unchanged) | [race()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| &nbsp; | `Patient.extension:ethnicity` | 0..1 | [us-core-ethnicity](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-ethnicity.html) (unchanged) | [ethnicity()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| &nbsp; | `Patient.extension:tribalAffiliation` | 0..* | [us-core-tribal-affiliation](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-tribal-affiliation.html) (unchanged) | [tribalAffiliation()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| &nbsp; | `Patient.extension:birthsex` | 0..1 | [us-core-birthsex](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-birthsex.html) (unchanged) | [birthSex()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| &nbsp; | `Patient.extension:sex` | 0..1 | [us-core-sex](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-sex.html) (unchanged) | [sex()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| &nbsp; | `Patient.extension:genderIdentity` | 0..* | [us-core-genderIdentity](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-genderIdentity.html) (unchanged) | *none* |
| &nbsp; | `Patient.telecom.extension:telecom-preferred` | 0..1 | [iso21090-preferred](http://hl7.org/fhir/R4/extension-iso21090-preferred.html) (unchanged) | *none* |
| &nbsp; | `Patient.address.extension:address-preferred` | 0..1 | [iso21090-preferred](http://hl7.org/fhir/R4/extension-iso21090-preferred.html) (unchanged) | *none* |
| [Procedure](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-procedure.html) | `Procedure.extension:recorded` | 0..1 | [qicore-recorded](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-recorded.html) &rarr; [us-quality-core-recorded](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-recorded.html) | [recorded()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [ProcedureNotDone](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-procedurenotdone.html) | `Procedure.extension:recorded` | 1..1 | [qicore-recorded](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-recorded.html) &rarr; [us-quality-core-recorded](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-recorded.html) | [recorded()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| &nbsp; | `Procedure.code.extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [code()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [QuestionnaireResponse](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-questionnaireresponse.html) | `QuestionnaireResponse.extension:signature` | 0..* | [questionnaireresponse-signature](http://hl7.org/fhir/R4/extension-questionnaireresponse-signature.html) (unchanged) | *none* |
| &nbsp; | `QuestionnaireResponse.extension:completionMode` | 0..1 | [questionnaireresponse-completionMode](http://hl7.org/fhir/R4/extension-questionnaireresponse-completionmode.html) (unchanged) | *none* |
| &nbsp; | `QuestionnaireResponse.questionnaire.extension:questionnaireDisplay` | 0..1 | [display](http://hl7.org/fhir/R4/extension-display.html) (unchanged) | *none* |
| &nbsp; | `QuestionnaireResponse.questionnaire.extension:url` | 0..1 | [us-core-extension-questionnaire-uri](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-extension-questionnaire-uri.html) (unchanged) | *none* |
| &nbsp; | `QuestionnaireResponse.item.extension:itemMedia` | 0..1 | [sdc-questionnaire-itemMedia](http://hl7.org/fhir/uv/sdc/StructureDefinition-sdc-questionnaire-itemMedia.html) (unchanged) | *none* |
| &nbsp; | `QuestionnaireResponse.item.extension:ItemSignature` | 0..* | [questionnaireresponse-signature](http://hl7.org/fhir/R4/extension-questionnaireresponse-signature.html) (unchanged) | *none* |
| &nbsp; | `QuestionnaireResponse.item.answer.extension:itemAnswerMedia` | 0..1 | [sdc-questionnaire-itemAnswerMedia](http://hl7.org/fhir/uv/sdc/StructureDefinition-sdc-questionnaire-itemAnswerMedia.html) (unchanged) | *none* |
| &nbsp; | `QuestionnaireResponse.item.answer.extension:ordinalValue` | 0..1 | [ordinalValue](http://hl7.org/fhir/R4/extension-ordinalvalue.html) (unchanged) | *none* |
| [ServiceNotRequested](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-servicenotrequested.html) | `ServiceRequest.extension:reasonRefused` | 1..1 | [qicore-doNotPerformReason](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-doNotPerformReason.html) &rarr; [us-quality-core-doNotPerformReason](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-doNotPerformReason.html) | [reasonRefused()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| &nbsp; | `ServiceRequest.code.extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [code()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| [TaskRejected](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-taskrejected.html) | `Task.code.extension:notDoneValueSet` | 0..1 | [qicore-notDoneValueSet](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-notDoneValueSet.html) &rarr; [us-quality-core-notDoneValueSet](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-notDoneValueSet.html) | [code()](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
{: .grid}

**Notes on accessing extensions from CQL**

The QICore 6.0.0 model info surfaced extensions as *named model elements*, so CQL could write `Patient.race` or `ProcedureNotDone.recorded` directly &mdash; 25 classes carried such elements. The USQualityCore 0.5.0 model info does not: no element in it declares an extension target, and neither does the USCore 6.1.0-derived model info it builds on. All extension access is now through **fluent functions**, so the same expressions become `Patient.race()` and `ProcedureNotDone.recorded()`. The last column above names the function and the library that defines it.

Extensions with no accessor in either common library must be read with the generic `ext()` function from [FHIRCommon](https://hl7.org/fhir/uv/cql/Library-FHIRCommon.html), for example:

```cql
define fluent function preferred(element FHIR.Element):
  element.ext('http://hl7.org/fhir/StructureDefinition/iso21090-preferred').value as FHIR.boolean
```

The three complex US Core extensions do not return a simple value. `race()`, `ethnicity()`, and `tribalAffiliation()` each return a tuple assembled from the extension's sub-extensions:

```cql
Patient.race()               // { ombCategory: List<Coding>, detailed: List<Coding>, text: String }
Patient.ethnicity()          // { ombCategory: Coding, detailed: List<Coding>, text: String }
Patient.tribalAffiliation()  // { tribalAffiliation: CodeableConcept, isEnrolled: Boolean }
```

Notes on the above content:

1. **`diagnosisPresentOnAdmission` is now accessible.** QI Core STU6 defined `qicore-encounter-diagnosisPresentOnAdmission` but had removed it from `QICoreEncounter` in favor of accessing present on admission in the `QICoreClaim` profile (see the [Present On Admission](pattern_conditions.html#conditions-present-on-admission-and-principal-diagnoses) authoring pattern). US Quality Core 0.5.0 slices it into `USQualityCoreEncounter.diagnosis` and provides `presentOnAdmission()`.
2. **`MedicationDispenseDeclined.medication` is now accessible.** The QICore 6.0.0 model info mapped it to a plain value with no `notDoneValueSet` target, unlike the other negation profiles. `USQualityCoreCommon.medication()` covers it.
3. &#9888; **`abatement()` and `severity()` do not resolve in 0.5.0.** Both are declared against `hl7.org/fhir/StructureDefinition/familymemberhistory-*` &mdash; the `http://` scheme is missing, so the URL will not match the extension on the instance. The profile slices themselves are correct. In addition, **`doNotPerform()`** does not resolve against a DeviceRequest, it is only defined for the DeviceNotRequested profile. These issues have all been addressed by adding overloads for these functions to the CQMCommon library, and tickets to address these issues in the source content are being filed.
4. **`individualSex()` targets an extension US Core 6.1.0 does not define.** [USCoreCommon](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) reads `us-core-individual-sex`, which was introduced after 6.1.0. It coalesces with `us-core-sex`, so it still resolves against 6.1.0 data; `sex()` itself is marked `@deprecated` in favor of it.
5. **`sexParameterForClinicalUse()` reads a base FHIR extension that no profile slices.** It targets `http://hl7.org/fhir/StructureDefinition/patient-sexParameterForClinicalUse`, which is not part of US Core 6.1.0 and is not declared on any QI Core or US Quality Core profile.
