This page documents known issues in the current authoring technical stack for FHIR-based measures using US Quality Core:

* FHIR version 4.0.1
* US Core version 6.1.0-derived
* US Quality Core version 0.5.0

### Missing Primary Code Paths

The published model info specifications for US Core 6.1.0-derived and US Quality Core 0.5.0 are missing some primary code path designators, resulting in warnings at compile-time, and potentially errors at run-time:

```cql
// TODO:
```

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
