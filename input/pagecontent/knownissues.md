This page documents known issues in the current authoring technical stack for FHIR-based measures using US Quality Core:

* FHIR version 4.0.1
* US Core version 6.1.0-derived
* US Quality Core version 0.5.0

### Incorrect or Missing Primary Code Paths

The published model info specifications for US Core 6.1.0-derived and US Quality Core 0.5.0 have some known issues with primary code path designators, resulting in warnings at compile-time, and potentially errors at run-time.

For US Core 6.1.0, the following types are affected:

| US Core 6.1.0-derived type | Base FHIR type | Suggested primary code path | QI Core 6.0.0 |
|----|----|----|----|
| [CarePlanProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-careplan.html) | `CarePlan` | `category` | `category` |
{: .grid}

For US Quality Core 0.5.0, the following types are affected:

| US Quality Core 0.5.0 type | Base FHIR type | Suggested primary code path |
|----|----|----|
| [NutritionOrder](https://fhir.org/guides/onc/us-quality-core/en/StructureDefinition-us-quality-core-nutritionorder.html) | `NutritionOrder` | Any of:\n\n* oralDiet.type\n* supplement.Type\n* enteralFormula.baseFormulaType |
| [ImmunizationRecommendation](https://fhir.org/guides/onc/us-quality-core/en/StructureDefinition-us-quality-core-immunizationrecommendation.html) | `ImmunizationRecommendation` | `recommendation.vaccineCode` |
{: .grid}

Note that for NutritionOrder specifically, the lack of a "primaryCodePath" in the model is deliberate because there is no justification for choosing any particular code path in the general case.

**Workaround**:

For both NutritionOrder and ImmunizationRecommendation, the translator does not allow qualified code paths to be used in the retrieve (see the feature request [#1853](https://github.com/cqframework/clinical_quality_language/issues/1853)). Until that is implemented, use a where clause rather than a terminology-based retrieve:

```cql
define "Immunization Recommendations":
  [ImmunizationRecommendation] IR
    where exists (
        IR.recommendation R
            where R.vaccineCode in "Vaccine Codes"
    )

define "Oral Diet Nutrition Orders":
  [NutritionOrder] O
    where O.type in "Oral Diet Types"
```

**Retrievable types that correctly have no primary code path**

The following retrievable types also have no primary code path, but this is not a defect: the base FHIR resource does not define one either, because the resource has no element that serves as a primary code.

| Model | Type | Base FHIR type |
|----|----|----|
| USCore 6.1.0-derived | [PatientProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-patient.html) | `Patient` |
| USCore 6.1.0-derived | [PractitionerProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-practitioner.html) | `Practitioner` |
| USCore 6.1.0-derived | [Provenance](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-provenance.html) | `Provenance` |
| USCore 6.1.0-derived | [QuestionnaireResponseProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-questionnaireresponse.html) | `QuestionnaireResponse` |
| USQualityCore 0.5.0 | `NutritionOrder` | `NutritionOrder` |
| USQualityCore 0.5.0 | `Patient` | `Patient` |
| USQualityCore 0.5.0 | `Practitioner` | `Practitioner` |
| USQualityCore 0.5.0 | `QuestionnaireResponse` | `QuestionnaireResponse` |
{: .grid}

#### Vital-signs Profiles

All the specific vital-sign profiles in US Core (such as BMIProfile, BloodPressureProfile) deliberately omit a primary code path because the profile fixes the code, so no terminology filter is required:

```cql
// US Core 6.1.0-derived declares BloodPressureProfile as retrievable, and does not declare a
// primary code path for it because the profile fixes the code to the LOINC code for BloodPressure, 
// so no terminology filter is required:
define "Blood Pressure Readings":
  [USCore.BloodPressureProfile]
```

The following vital-signs profiles in US Core 6.1.0 do not specify a primary code path because the profile constrains the code:

| US Core 6.1.0-derived type |
|----|
| [BMIProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-bmi.html) |
| [BloodPressureProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-blood-pressure.html) |
| [BodyHeightProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-height.html) |
| [BodyTemperatureProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-temperature.html) |
| [BodyWeightProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-weight.html) |
| [HeadCircumferenceProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-head-circumference.html) |
| [HeartRateProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-heart-rate.html) |
| [ObservationPregnancyIntentProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancyintent.html) |
| [ObservationPregnancyStatusProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancystatus.html) |
| [ObservationSexualOrientationProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-sexual-orientation.html) |
| [PediatricBMIforAgeObservationProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-bmi-for-age.html) |
| [PediatricHeadOccipitalFrontalCircumferencePercentileProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-head-occipital-frontal-circumference-percentile.html) |
| [PediatricWeightForHeightObservationProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-weight-for-height.html) |
| [PulseOximetryProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-pulse-oximetry.html) |
| [RespiratoryRateProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-respiratory-rate.html) |
| [SmokingStatusProfile](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html) |
{: .grid}

### Cannot Resolve Fluent Functions on Choices

The fluent function `.prevalenceInterval()` can be invoked on `ConditionEncounterDiagnosis` and `ConditionProblemsHealthConcerns`, but it cannot be invoked on `Choice<ConditionEncounterDiagnosis, ConditionProblemsHealthConvers>`:

```cql
define "Asthma Encounter Diagnosis Prevalent During Measurement Period":
  [ConditionEncounterDiagnosis: "Asthma"] C
    where C.prevalenceInterval() during "Measurement Period"

define "Asthma Problem List Item Prevalent During Measurement Period":
  [ConditionProblemsHealthConcerns: "Asthma"] C
    where C.prevalenceInterval() during "Measurement Period"

define "Asthma Prevalent During Measurement Period":
  (
    [ConditionEncounterDiagnosis: "Asthma"]
      union [ConditionProblemsHealthConcerns: "Asthma"]
  ) C
    where C.prevalenceInterval() during "Measurement Period"
```

The first two expressions work correctly, the last one does not compile and gives the translator error:

```
Could not resolve call to operator prevalenceInterval with signature (choice<USQualityCore.ConditionEncounterDiagnosis,USQualityCore.ConditionProblemsHealthConcerns>).
Expression of type 'choice<…>' cannot be cast as a value of type 'Condition'.
```

This is a known issue with the CQL-to-ELM translator (https://github.com/cqframework/clinical_quality_language/issues/1831)

**Workaround**:

The workaround is to either rewrite the union to use the base type:

```cql
define "Asthma Prevalent During Measurement Period":
  [FHIR.Condition: "Asthma"] C
    where C.prevalenceInterval() during "Measurement Period"
```

or perform the tests individually:

```cql
define "Asthma Prevalent During Measurement Period":
  ([ConditionEncounterDiagnosis: "Asthma"] C where C.prevalenceInterval() during "Measurement Period")
    union ([ConditionProblemsHealthConcerns: "Asthma"] C where C.prevalenceInterval() during "Measurement Period")
```

### Seemingly Ambiguous Type References Are Allowed

When using multiple models, the possibility exists for the same type name to be used in different models. For example, both FHIR and USQualityCore define a Procedure type. In FHIR, it is the base Procedure resource, in USQualityCore, it is a Procedure profile. In a library with both models declared, the unqualified reference to Procedure could result in an ambiguous reference:

```cql
using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

...

define Procedures: [Procedure]
```

As a result, best-practice is to use the qualified name, `USQualityCore.Procedure` when talking about the USQualityCore Procedure profile, and `FHIR.Procedure` when talking about the base FHIR resource. Note that the way the model information files are currently defined, the use of the unqualified `Procedure` does not result in an ambiguous reference. This is because resolution of a type identifier in CQL first looks across all the models for any type that has a `label` with the given identifier. If the identifier can be unambiguously resolved as a label, that is the type that is used. Otherwise, resolution proceeds to looking for a type with the name:

| Model | Type | Label |
|----|----|----|
| FHIR (4.0.1) | Procedure | Procedure |
| USCore (6.1.0-derived) | ProcedureProfile | Procedure Profile |
| USQualityCore (0.5.0) | Procedure | US Quality Core Procedure |

The labels are inconsistent as currently published, but the result is that the label `Procedure` is unique among the three models, and so resolves to the type `FHIR.Procedure`.

Care should be taken not to rely on this behavior since it is currently inconsistent and subject to change in future publications of the model info files.

**Workaround**:

Artifact logic should _always_ use the model qualified name of the type.

### Fluent Function Overloads

Fluent function overloads that use profiles derived from the same base resource will result in an ambiguous function call error at run-time:

```cql
define fluent function isCommunity(medicationRequest MedicationRequest):
  exists (medicationRequest.category C
    where C ~ Community
  )

define fluent function isCommunity(medicationRequest MedicationNotRequested):
  exists (medicationRequest.category C
    where C ~ Community
  )
```

Logic that makes use of these functions will compile, but will fail at run-time with the error:

```
Ambiguous call to operator 'isCommunity(org.hl7.fhir.r4.model.MedicationRequest)'
```

This is happening because the underlying type in the ELM is the same (`MedicationRequest` in this case), driven by the type of the resource the profile is based on. So even though the types can be distinguished at compiled-time, in the underlying ELM they are the same function.

This is a known issue with the CQL-to-ELM translator (https://github.com/cqframework/clinical_quality_language/issues/1435).

**Workaround**:

Define the function at the base type, rather than at the profiled types:

```cql
define fluent function isCommunity(medicationRequest FHIR.MedicationRequest):
  exists (
    medicationRequest.category C
      where C ~ Community
  )
```

This should be able to done either in the artifact logic directly, or as part of a shared library that is included ahead of the library in which the conflicting fluent functions are defined. If the inclusion results in a compile-time ambiguity, use a more specific name for the fluent-function (e.g.: `isCommunityRequest`).
