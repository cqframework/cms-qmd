This topic provides an index of the shared libraries used in QICore and USQualityCore, and where refactored content from those shared libraries can be found in the refactored versions.

### Library Index

This index lists all the shared libraries used by measures. Note that for QICore measures, all shared libraries were developed and published in MADiE, whereas for US Quality Core measures, a core set of shared libraries are published as part of HL7 or ONC implementation guides and made available through the NPM packages for those implementation guides. Libraries available in published implementation guides are listed in the table below with the namespace and name of the library, and linked to the published content for that library.

The remaining libraries are expected to still be developed in MADiE, but are included in the proposed set of refactored measures for reference, testing, and to support the development of this guidance. A third group &mdash; ClaimCommon, ClaimElements, and MedicationCommon &mdash; is drafted in this guide itself, supplying functions that no published library provides yet; the status, use, and type functions in ClaimCommon and all of MedicationCommon are intended for proposal to FHIRCommon. The version numbers of those libraries are suggested based on both a Major and Minor version increment for each library (for example, AdultOutpatientEncounters in QICore is version 4.19.000, whereas the suggested refactoring is 5.1.000). The content for these libraries is suggested, and it is expected that these libraries will be developed in MADiE once full US Quality Core support is available. Measure developers can use the content as a starting point for that development if desired. 

Note also that the [dqm-content-cms-2026](https://github.com/cqframework/dqm-content-cms-2026) repository has minor increments for each of these libraries as well with the full update to the 0.5.0 published release. Those increments will be pulled into the cms-2025 repository once discrepancy testing has completed.

| Library | QI Core version | US Quality Core version |
|----|----|----|
| AdultOutpatientEncounters | [4.19.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/AdultOutpatientEncounters.cql) | [5.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/AdultOutpatientEncounters.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| AdvancedIllnessandFrailty | [1.27.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/AdvancedIllnessandFrailty.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/AdvancedIllnessandFrailty.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| AHAOverall | [4.1.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/AHAOverall.cql) | [5.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/AHAOverall.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| AlaraCommonFunctions | [1.10.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/AlaraCommonFunctions.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/AlaraCommonFunctions.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| Antibiotic | [1.11.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/Antibiotic.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/Antibiotic.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| ClaimCommon | - | [0.3.000](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimCommon.cql) _0.3.000 currently published in MADiE_ |
| ClaimElements | - | [0.3.000](https://github.com/cqframework/cms-qmd/blob/main/input/cql/ClaimElements.cql) _0.3.000 currently published in MADiE_ |
| CQMCommon | [4.1.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/CQMCommon.cql) | [5.2.000](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMCommon.cql) _5.2.000 currently published in MADiE_ |
| CQMConcepts | - | [0.2.000](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) _0.2.000 currently published in MADiE; part of the layer-based replacement for CQMCommon &mdash; measure developers should consider whether to adopt these libraries or keep the CQMCommon shared library_ |
| CQMElements | - | [0.2.000](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMElements.cql) _0.2.000 currently published in MADiE; part of the layer-based replacement for CQMCommon &mdash; measure developers should consider whether to adopt these libraries or keep the CQMCommon shared library_ |
| CQMInferences | - | [0.2.000](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMInferences.cql) _0.2.000 currently published in MADiE; part of the layer-based replacement for CQMCommon &mdash; measure developers should consider whether to adopt these libraries or keep the CQMCommon shared library_ |
| CumulativeMedicationDuration | [6.0.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/CumulativeMedicationDuration.cql) | [hl7.fhir.us.cql.CumulativeMedicationDuration version '2.0.0'](https://hl7.org/fhir/us/cql/Library-CumulativeMedicationDuration.html) |
| FHIRHelpers | [4.4.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/FHIRHelpers.cql) | [hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'](https://hl7.org/fhir/uv/cql/Library-FHIRHelpers.html) |
| FHIRCommon | - | [hl7.fhir.uv.cql.FHIRCommon version '2.0.0'](https://hl7.org/fhir/uv/cql/Library-FHIRHelpers.html) |
| Hospice | [6.18.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/Hospice.cql) | [7.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/Hospice.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| MedicationCommon | - | [0.1.0](https://github.com/cqframework/cms-qmd/blob/main/input/cql/MedicationCommon.cql) _draft content in this guide; needs review and authoring in MADiE_ |
| NHSNHelpers | [0.1.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/NHSNHelpers.cql) | [1.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/NHSNHelpers.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| PalliativeCare | [1.18.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/PalliativeCare.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/PalliativeCare.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| PCMaternal | [5.25.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/PCMaternal.cql) | [6.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/PCMaternal.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| QICoreCommon | [4.0.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/QICoreCommon.cql) | refactored into FHIRCommon, USCoreCommon, and [USQualityCoreCommon](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| Status | [1.15.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/Status.cql) | [2.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/Status.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| SupplementalDataElements | [5.1.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/SupplementalDataElements.cql) | [6.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/SupplementalDataElements.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| TJCOverall | [8.25.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/TJCOverall.cql) | [9.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/TJCOverall.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| VTE | [8.18.000](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/VTE.cql) | [9.1.000](https://github.com/cqframework/dqm-content-cms-2025/blob/main/input/cql/VTE.cql) _proposed draft content in Github; needs review and authoring in MADiE_ |
| USCoreCommon | - | [hl7.fhir.us.cql.USCoreCommon version '2.0.0'](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| USCoreElements | - | [hl7.fhir.us.cql.USCoreElements version '2.0.0'](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) |
| USQualityCoreCommon | - | [fhir.onc."us-quality-core".USQualityCoreCommon version '0.5.0'](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
{: .grid}

### Function Index

This index lists functions from the QICore-based library versions and where they are now following the refactor.

| Library | Prior version or name | New version or location |
|----|----|----|
| **CQMCommon** | 4.1.000 | 5.1.000 |
| **QICoreCommon** | deprecated | [FHIRCommon](https://hl7.org/fhir/uv/cql/Library-FHIRCommon.html), [USCoreCommon](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html), or [USQualityCoreCommon](https://fhir.org/guides/onc/us-quality-core/Library-USQualityCoreCommon.html) |
| **CumulativeMedicationDuration** | 6.0.000 | hl7.fhir.us.cql.CumulativeMedicationDuration 2.0.0 |
| **Status** | 1.15.000 | 2.1.000 |
{: .grid}

Notes on the libraries above:

* **CQMCommon** &mdash; The deprecated "ED Visit" and "Hospitalization" expression definitions have been removed; use the `edVisit()` and `hospitalization()` fluent functions instead. The claim navigation functions have moved to ClaimCommon and ClaimElements.
* **CumulativeMedicationDuration** &mdash; No changes.
* **Status** &mdash; verified() (consider deprecating); FHIRCommon verified() should be used instead.

#### QICoreCommon function locations

QICoreCommon is deprecated. Its functions are now distributed across three libraries:

| QICoreCommon function | New location |
|----|----|
| isActive() | FHIRCommon |
| hasCategory(Condition, Code) | FHIRCommon |
| isProblemListItem() | FHIRCommon |
| isEncounterDiagnosis() | FHIRCommon |
| hasCategory(Observation, Code) | FHIRCommon |
| isSocialHistory() | FHIRCommon |
| isVitalSign() | FHIRCommon |
| isImaging() | FHIRCommon |
| isLaboratory() | FHIRCommon |
| isProcedure() | FHIRCommon |
| isSurvey() | FHIRCommon |
| isExam() | FHIRCommon |
| isTherapy() | FHIRCommon |
| isActivity() | FHIRCommon |
| isCommunity() | FHIRCommon |
| isDischarge() | FHIRCommon |
| references() | FHIRCommon |
| toInterval() | FHIRCommon |
| abatementInterval() | FHIRCommon |
| prevalenceInterval() | FHIRCommon |
| includesCode() | FHIRCommon |
| HasStart() / hasStart() | FHIRCommon |
| HasEnd() / hasEnd() | FHIRCommon |
| Latest() / latest() | FHIRCommon |
| Earliest() / earliest() | FHIRCommon |
| getId() | USQualityCoreCommon |
| "Interval To Day Numbers" / toDayNumbers() | USQualityCoreCommon |
| "Days In Period" / daysInPeriod() | USQualityCoreCommon |
| doNotPerform(DeviceNotRequested) | USQualityCoreCommon |
| DeviceNotRequested.doNotPerformReason() | USQualityCoreCommon |
| DeviceNotRequested.doNotPerform() | USQualityCoreCommon |
| DeviceNotRequested.code() | USQualityCoreCommon |
| CommunicationNotDone.recorded() | USQualityCoreCommon |
| CommunicationNotDone.topic() | USQualityCoreCommon |
| ImmunizationNotDone.vaccineCode() | USQualityCoreCommon |
| MedicationAdministrationNotDone.recorded() | USQualityCoreCommon |
| MedicationAdministrationNotDone.medication() | USQualityCoreCommon |
| MedicationDispenseDeclined.recorded() | USQualityCoreCommon |
| MedicationDispenseDeclined.medication() | USQualityCoreCommon |
| MedicationNotRequested.medication() | USQualityCoreCommon |
| ObservationCancelled.notDoneReason() | USQualityCoreCommon |
| ObservationCancelled.code() | USQualityCoreCommon |
| ProcedureNotDone.recorded() | USQualityCoreCommon |
| ProcedureNotDone.code() | USQualityCoreCommon |
| ServiceNotRequested.reasonRefused() | USQualityCoreCommon |
| ServiceNotRequested.code() | USQualityCoreCommon |
| TaskRejected.code() | USQualityCoreCommon |
| isHealthConcern() | USCoreCommon |
{: .grid}

### Extension Index

This index lists every element that QI Core STU6 and US Quality Core 0.5.0 represent as an *extension* rather than as a core FHIR element, and shows where each one landed in the refactor. Extensions reach these profiles from three places: **inherited from US Core 6.1.0**, **defined by the IG itself**, or **borrowed from base FHIR and SDC**. Each is covered below. For the remaining slices &mdash; those discriminated by value or pattern rather than by extension URL &mdash; see the [Slice Index](#slice-index).

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

### Slice Index

The Extension Index above covers every element that the profiles represent as an *extension*. This index covers the remaining slices &mdash; the value- and pattern-discriminated slices on `category`, `identifier`, `class`, `component`, and `code.coding`. They follow exactly the same story as the extensions: the profiles are unchanged, but the model info no longer surfaces the slice as an element.

Every non-extension slice in QI Core STU6 is present at the same element path with the same slice name in US Quality Core 0.5.0. Nothing was added, removed, or renamed at the profile level. The difference is entirely in the model info: the QICore 6.0.0 model info was profile-informed, so it flattened each slice into a *named model element*, and CQL could write `Coverage.memberid` or `Observation.VSCat` directly. Neither the USQualityCore 0.5.0 model info nor the USCore 6.1.0-derived model info it builds on declares a single slice element &mdash; no element in either one carries a slice target. All slice access is now through **fluent functions**. Where no published library supplies one, a function is drafted in [CQMConcepts](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) in this guide, annotated with the library it is being proposed for; those are marked *proposed* in the tables below.

Note that most of these slice names are not valid CQL identifiers and had to be quoted (`Condition."us-core"`). Note also that, apart from `VSCat`, none of them carried a navigation target in the QICore 6.0.0 model info either, so in practice the QI Core expression resolved to a path named after the slice rather than to the sliced content. For those elements the refactor did not remove working access so much as remove the appearance of it.

**Category slices**

| Profile | Slice | Accessor in US Quality Core |
|----|----|----|
| [ConditionEncounterDiagnosis](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-condition-encounter-diagnosis.html) | `Condition.category:us-core` | [isEncounterDiagnosis()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [ConditionProblemsHealthConcerns](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-condition-problems-health-concerns.html) | `Condition.category:us-core` | [isProblemListItem()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html), [isHealthConcern()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| &nbsp; | `Condition.category:screening-assessment` | [isScreeningAssessment()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreCommon)* |
| [LaboratoryResultObservation](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-observation-lab.html) | `Observation.category:us-core` | [isLaboratory()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [ObservationClinicalResult](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-observation-clinical-result.html) | `Observation.category:us-core` | [hasCategory(Observation, Code)](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [SimpleObservation](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-simple-observation.html) | `Observation.category:us-core` | [hasCategory(Observation, Code)](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [ObservationScreeningAssessment](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-observation-screening-assessment.html) | `Observation.category:survey` | [isSurvey()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| &nbsp; | `Observation.category:screening-assessment` | [isScreeningAssessment()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreCommon)* |
| [MedicationRequest](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-medicationrequest.html) | `MedicationRequest.category:us-core` | [isCommunity()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html), [isDischarge()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html), [hasCategory(MedicationRequest, Code)](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [MedicationNotRequested](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-medicationnotrequested.html) | `MedicationRequest.category:us-core` | [isCommunity()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html), [isDischarge()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html), [hasCategory(MedicationRequest, Code)](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [CarePlan](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-careplan.html) | `CarePlan.category:AssessPlan` | [isAssessPlan()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreCommon)*, [hasCategory(CarePlan, Code)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for FHIRCommon)* |
| [DiagnosticReportLab](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-diagnosticreport-lab.html) | `DiagnosticReport.category:LaboratorySlice` | [isLaboratory(DiagnosticReport)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for FHIRCommon)* |
| [DiagnosticReportNote](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-diagnosticreport-note.html) | `DiagnosticReport.category:us-core` | [hasCategory(DiagnosticReport, Code)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for FHIRCommon)* |
| [ServiceRequest](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-servicerequest.html) | `ServiceRequest.category:us-core` | [hasCategory(ServiceRequest, Code)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for FHIRCommon)* |
| [ServiceNotRequested](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-servicenotrequested.html) | `ServiceRequest.category:us-core` | [hasCategory(ServiceRequest, Code)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for FHIRCommon)* |
{: .grid}

**Identifier and class slices**

| Profile | Slice | Accessor in US Quality Core |
|----|----|----|
| [Coverage](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-coverage.html) | `Coverage.identifier:memberid` | [memberID()](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) |
| &nbsp; | `Coverage.class:group` | [groupNumber()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreElements)* |
| &nbsp; | `Coverage.class:plan` | [planNumber()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreElements)* |
| [Organization](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-organization.html) | `Organization.identifier:NPI` | [npi(Organization)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreElements)* |
| &nbsp; | `Organization.identifier:CLIA` | [clia()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreElements)* |
| &nbsp; | `Organization.identifier:NAIC` | [naic()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreElements)* |
| &nbsp; | `Organization.identifier:ccn` | [ccn()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USQualityCoreCommon)* |
| &nbsp; | `Organization.identifier:ein` | [ein(Organization)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USQualityCoreCommon)* |
| [Practitioner](https://fhir.org/guides/onc/us-quality-core/StructureDefinition-us-quality-core-practitioner.html) | `Practitioner.identifier:NPI` | [npi(Practitioner)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreElements)* |
| &nbsp; | `Practitioner.identifier:ein` | [ein(Practitioner)](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USQualityCoreCommon)* |
{: .grid}

`ccn` and `ein` are QI Core additions carried into US Quality Core; the rest are inherited from US Core 6.1.0. [USCoreElements](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) also supplies `memberID()`, `policyNumber()`, and `medicalRecordNumber()`, which read identifiers by `type` rather than by `system`.

**Slices on US Core profiles used directly**

Neither QI Core nor US Quality Core profiles the US Core vital signs, occupation, or smoking status profiles &mdash; they are used as published. The QICore 6.0.0 model info flattened them in anyway (as `USCoreBloodPressureProfile` and so on) and exposed their slices; the USCore 6.1.0-derived model info does not.

| US Core 6.1.0 profile | Slice | Accessor |
|----|----|----|
| [us-core-vital-signs](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-vital-signs.html) and the 12 profiles derived from it | `Observation.category:VSCat` | [isVitalSign()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [us-core-blood-pressure](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-blood-pressure.html) | `Observation.component:systolic` | [systolic()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| &nbsp; | `Observation.component:diastolic` | [diastolic()](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) |
| [us-core-pulse-oximetry](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-pulse-oximetry.html) | `Observation.code.coding:PulseOx` | [isPulseOximetry()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreCommon)* |
| &nbsp; | `Observation.code.coding:O2Sat` | [isPulseOximetry()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreCommon)* |
| &nbsp; | `Observation.component:FlowRate` | [flowRate()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreCommon)* |
| &nbsp; | `Observation.component:Concentration` | [concentration()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreCommon)* |
| [us-core-smokingstatus](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html) | `Observation.category:SocialHistory` | [isSocialHistory()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [us-core-observation-pregnancystatus](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancystatus.html) | `Observation.category:SocialHistory` | [isSocialHistory()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [us-core-observation-pregnancyintent](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancyintent.html) | `Observation.category:SocialHistory` | [isSocialHistory()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| [us-core-observation-occupation](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-occupation.html) | `Observation.category:socialhistory` | [isSocialHistory()](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) |
| &nbsp; | `Observation.component:industry` | [industry()](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) *(CQMConcepts, proposed for USCoreCommon)* |
{: .grid}

**Notes on accessing slices from CQL**

Use the named function for the slice. The functions marked *proposed* follow the shape the published libraries already use for the equivalent slices - a `hasCategory()` overload and an `is` prefixed predicate for category slices, following FHIRCommon, and a `singleton from` accessor for component slices, following the USCoreCommon `systolic()` and `diastolic()` functions. Each one filters the unsliced element on the slice discriminator, matching what the profile declares:

```cql
codesystem "USCoreCarePlanCategoryCodes": 'http://hl7.org/fhir/us/core/CodeSystem/careplan-category'
code "Assess and Plan": 'assess-plan' from "USCoreCarePlanCategoryCodes" display 'Assess and Plan'

// CarePlan.category:AssessPlan - pattern discriminator on a fixed coding, so the predicate tests the
// category for that coding, exactly as the FHIRCommon isProblemListItem() and isVitalSign() predicates do
define fluent function hasCategory(carePlan FHIR.CarePlan, category Code):
  exists (carePlan.category C
    where C ~ category
  )

define fluent function isAssessPlan(carePlan FHIR.CarePlan):
  carePlan.hasCategory("Assess and Plan")

// Organization.identifier:NPI - pattern discriminator on identifier.system. The slice is 0..*, so the
// accessor returns a list; the 0..1 identifier slices (ccn, ein) use singleton from instead
define fluent function npi(organization FHIR.Organization):
  organization.identifier I
    where I.system = 'http://hl7.org/fhir/sid/us-npi'
    return I.value
```

Notes on the above content:

1. **No `hasCategory()` overload exists upstream for CarePlan, DiagnosticReport, or ServiceRequest.** [FHIRCommon](http://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) defines `hasCategory()` only for `Condition`, `Observation`, and `MedicationRequest`. The overloads for the other three, and the `isLaboratory(DiagnosticReport)` predicate, are drafted in [CQMConcepts](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql) and proposed for FHIRCommon, since none of them is US-specific.
2. **No accessors exist upstream for the identifier slices.** Neither [USCoreCommon](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) nor [USCoreElements](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) provides `npi()`, `clia()`, `naic()`, `ccn()`, or `ein()`, so measures that identified a provider or facility by `Practitioner.NPI` or `Organization.ccn` under QI Core must filter `identifier` by system. Those functions are drafted in [CQMConcepts](https://github.com/cqframework/cms-qmd/blob/main/input/cql/CQMConcepts.cql); `npi()`, `clia()`, and `naic()` are proposed for USCoreElements, while `ccn()` and `ein()` are proposed for USQualityCoreCommon, because those two slices are QI Core additions rather than US Core content.
3. **Some slice types survive in the model info but are orphaned.** `USQualityCore."Coverage.Class.group"` and `"Coverage.Class.plan"` are still declared, as are `USCore."Observation.Component.systolic"`, `".diastolic"`, `".FlowRate"`, `".Concentration"`, and `".industry"`, but no element in either model info has those types &mdash; all 22 `component` elements in the USCore 6.1.0-derived model info are plain `USCore."Observation.Component"`. The types are inert; they cannot be reached by navigation.
4. **Choice-type slices were never exposed as elements.** `Observation.value[x]:valueCodeableConcept` on NonPatientObservation, ObservationCancelled, and SimpleObservation, and the `effective[x]` slices on the occupation and smoking status profiles, are type slices on a choice element. Neither model info surfaces them as named elements; use the usual choice-type handling described in the [uv/cql patterns page](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html).
