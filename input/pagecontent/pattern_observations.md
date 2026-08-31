US Core defines a variety of profiles for representing and accessing a patient's observations. US Quality Core defines observation profiles where additional conformance is needed beyond the US Core profiles.

Authoring patterns for observations are documented in [Observation](https://hl7.org/fhir/us/cql/en/patterns-observation.html) in the US CQL implementation guide, covering status, category, interpretation, timings, and each of the observation profiles. This page records only what differs for quality measurement; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

For Observation, see also [modifier elements](https://hl7.org/fhir/us/cql/en/patterns-observation.html#modifier-elements), [search parameters](https://hl7.org/fhir/us/cql/en/patterns-observation.html#search-parameters), and [cross-version considerations](https://hl7.org/fhir/us/cql/en/patterns-observation.html#cross-version-considerations) in that guide.

Two points apply throughout. A retrieve against a profile is a filter by conformance, so the expression does not need to test elements the profile fixes &mdash; retrieving `[USCore.RespiratoryRateProfile]` does not need a test for LOINC 9279-1. And observation status should be tested with the [status functions](https://hl7.org/fhir/us/cql/en/patterns-observation.html#status) in [FHIRCommon](https://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) &mdash; `isResulted()` for the usual `final`, `amended`, or `corrected` test, or `isFinal()`, `isAmended()`, and `isCorrected()` individually &mdash; rather than by listing status codes inline.

```cql
define "Respiratory Rate":
  [USCore.RespiratoryRateProfile] RR
    where RR.isResulted()
```

### Vital Signs

See [Vital signs](https://hl7.org/fhir/us/cql/en/patterns-observation.html#vital-signs).

US Core defines a base vital signs profile along with specific profiles for respiratory rate, heart rate, body temperature, body height, head circumference, body weight, BMI, blood pressure, pediatric BMI for age, pediatric weight for height, and pulse oximetry. Each is retrieved by its profile as above; oxygen saturation is part of the pulse oximetry profile. Blood pressure components are reached with the `systolic()` and `diastolic()` fluent functions in [USCoreCommon](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html) rather than by component index.

### Pregnancy Status

See [Pregnancy status](https://hl7.org/fhir/us/cql/en/patterns-observation.html#pregnancy-status).

Pregnancy may be recorded as a pregnancy status observation, a laboratory result, an encounter diagnosis, or a problem list item, and logic that needs to establish pregnancy should consider all four. The US CQL example does this against US Core profiles; a measure builds the same expression against the corresponding US Quality Core profiles. Where the question involves a prevalence period, only the Condition profiles can answer it, since onset and abatement are not available on the observation representations.

### Pregnancy Intent

See [Pregnancy intent](https://hl7.org/fhir/us/cql/en/patterns-observation.html#pregnancy-intent).

### Smoking Status

US Quality Core uses the US Core [Smoking Status](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html) profile, which sets the minimum expectations for recording, searching, and retrieving a patient's smoking status.

```cql
define "Smoking Status":
  [USCore.SmokingStatusProfile] SmokingStatus
    where SmokingStatus.isResulted()
```

### Laboratory Result

See [Laboratory results](https://hl7.org/fhir/us/cql/en/patterns-observation.html#laboratory-results).

Measures use the [US Quality Core Laboratory Result Observation](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-observation-lab.html) profile, which is characterized by `code` and fixes `category` to laboratory.

### Clinical Result

See [Clinical results](https://hl7.org/fhir/us/cql/en/patterns-observation.html#clinical-results-1).

Measures use the [US Quality Core Observation Clinical Result](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-observation-clinical-result.html) profile for non-laboratory clinical test results, such as the size of a polyp seen during a colonoscopy. Observations associated with imaging are expected to represent specific measurements obtained from imaging; see [Imaging procedures](https://hl7.org/fhir/us/cql/en/patterns-service.html#imaging-procedures).

### Surveys and Assessments

See [Screening assessments](https://hl7.org/fhir/us/cql/en/patterns-observation.html#screening-assessments).

Measures use the [US Quality Core Observation Screening Assessment](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-observation-screening-assessment.html) profile, which is characterized by `code` and fixes `category` to survey. It supports individual survey responses, multi-question panels, and multi-select answers.

### Simple Observations

See [Simple observations](https://hl7.org/fhir/us/cql/en/patterns-observation.html#simple-observations).

Measures use the [US Quality Core Simple Observation](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-simple-observation.html) profile for observations not covered by a more specific profile, filtered by `code`. Because this profile does not fix a status, the status test matters more here than elsewhere &mdash; and where preliminary results are in scope, `isResulted()` is not sufficient:

```cql
define "Pap Test With Results":
  [USQualityCore.SimpleObservation: "Pap Test"] PapTest
    where PapTest.value is not null
      and (PapTest.isResulted() or PapTest.status ~ 'preliminary')
```

### Observations Not Done

An observation that was not performed is represented as the rejection of a proposal to perform it: [US Quality Core Task Rejected](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-taskrejected.html) with `focus` referencing a [US Quality Core ServiceRequest](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-servicerequest.html) for the intended observation. See [Negation Patterns](pattern_negation.html) for the general treatment.

```cql
define "Pap Test Rejected For Reason":
  [USQualityCore.ServiceRequest: "Pap Test"] PapTestRequest
    with [USQualityCore.TaskRejected] Rejection
      such that Rejection.focus.references(PapTestRequest)
        and Rejection.code ~ FHIRCommon."Fulfill"
        and Rejection.statusReason in "Patient Declined"
    where PapTestRequest.status = 'active'
```

### Observations Non-Patient

US Quality Core defines a [US Quality Core NonPatient Observation](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-nonpatient-observation.html) profile for evaluating resource use and availability rather than a patient's own data.

> NOTE: This profile is marked with an asterisk in the [US Quality Core profile list](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/profiles.html), meaning it is not part of that guide's conformance expectations. The same applies to the US Quality Core Device profile used in the example below.

```cql
define "Hemodialysis Machine Availability":
  [USQualityCore.NonPatientObservation: "Hemodialysis"] Hemo
    where Hemo.subject.getDevice().type ~ "Hemodialysis machine, device (physical object)"
      and Hemo.value ~ "Equipment type available"
```

CQMCommon provides `getCondition()` and `getLocation()` for resolving references, but there is no equivalent for Device, so the example declares one:

```cql
define fluent function getDevice(reference FHIR.Reference):
  singleton from (
    [USQualityCore.Device] Device
      where reference.references(Device)
  )
```
