# Observations 
_Reviewed 2024-06-25_

QI-Core defines a variety of profiles for use in accessing observations for a patient. Specifically, QI-Core includes the vital signs profiles defined in US Core such as blood pressure, body height and weight, and BMI. In addition, US Core includes two new profiles around pregnancy:
* [Pregnancy status](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancystatus.html)
* [Pregnancy intent](http://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancyintent.html)  

New QI-Core profiles added (since 4.1.1 and 5.0) include:
* [QI-Core Simple Observation](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-simple-observation.html)  
* [QI-Core Non-Patient Observation](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-nonpatient-observation.html)  

In general, these profiles do not constrain the value of the status element, meaning that retrieves of these profiles will return observations in any status. As a modifier element, authors must consider the possible values of the observation status when determining how to filter the results of a retrieve of these profiles.

## Vital Signs
_Reviewed 2024-06-25_

When using QI-Core to access profiled resources, the result of the retrieve will only include resources that conform to that profile. This means that the retrieve is effectively a filter by conformance, meaning that the expression does not need to provide filters for values that are fixed by the profile definition. When retrieving Respiratory rate, for example, this means that the expression does not need to test that the code of the Observation is the LOINC code for respiratory rate (9279-1), the retrieve will only result in observations that already have that code:

```cql
// Respiratory rate - 9279-1
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-respiratory-rate.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-respiratory-rate.html)
define RespiratoryRate:
  ["USCoreRespiratoryRateProfile"] O
    where O.status in { 'final', 'amended', 'corrected' }
```

As a rule of thumb, if a profile definition defines a fixed value constraint for an element, then the expression does not need to use that element.

```cql
// Heart rate - 8867-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-heart-rate.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-heart-rate.html)
define HeartRate:
  [USCoreHeartRateProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```
```cql
// Body temperature - 8310-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-temperature.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-temperature.html)
define BodyTemperature:
  [USCoreBodyTemperatureProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```

```cql
// Body height - 8302-2
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-height.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-height.html)
define BodyHeight:
  [USCoreBodyHeightProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```

```cql
// Head circumference - 9843-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-head-occipital-frontal-circumference-percentile.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-head-occipital-frontal-circumference-percentile.html)
define HeadCircumference:
  [USCoreHeadCircumferenceProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```

```cql
// Body weight - 29463-7
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-weight.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-weight.html)
define BodyWeight:
  [USCoreBodyWeightProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```

```cql
// Body mass index - 39156-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-bmi.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-bmi.html)
define BodyMassIndex:
  [USCoreBMIProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```

```cql
// Blood pressure systolic and diastolic - 85354-9
// Systolic blood pressure - 8480-6
// Diastolic blood pressure - 8462-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-blood-pressure.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-blood-pressure.html)
define "BloodPressure less than 140 over 90":
  [USCoreBloodPressureProfile] BP
    where BP.status in { 'final', 'amended', 'corrected' }
      and BP.systolic.value < 140 'mm[Hg]'
      and BP.diastolic.value < 90 'mm[Hg]'
```

```cql
// USCore Pediatric BMI for Age - 59576-9
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-bmi-for-age.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-bmi-for-age.html)
define PediatricBMIForAge:
  [USCorePediatricBMIforAgeObservationProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```

```cql
// USCore Pediatric Weight for Height - 77606-2
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-weight-for-height.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-weight-for-height.html)
define PediatricWeightForHeight:
  [USCorePediatricWeightForHeightObservationProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```

```cql
// USCore Pulse Oximetry - 59408-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-pulse-oximetry.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-pulse-oximetry.html)
define PulseOximetry:
  [USCorePulseOximetryProfile] O
    where O.status in { 'final', 'amended', 'corrected' }
```

Note that Oxygen Saturation is now part of the pulse oximetry profile.

  
## Pregnancy Status
_Reviewed 2025-07-22_

QICore 6.0.0 allows for the presence of pregnancy to be represented in multiple profile resources. The US Core profile [Pregnancy Status](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancystatus.html) allows for the representation of pregnancy as an Observation. Pregnancy may also be represented as a Condition in QICore 6.0.0 allows using the ConditionEncounterDiagnosis or ConditionProblemsHealthConcerns profiles.

To determine if an individual is pregnant, the following approach may be used to consider all three approaches: 

```
valueset "Pregancy Condition Codes": 'TBD'
valueset "Pregnancy Test Codes": 'TBD'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
code "Pregnant": '77386006' from "SNOMEDCT" display 'Pregnant (finding)'
code "Positive": 'positive' from "Interpretation Codes"
 
define "Positive Pregnancy Observation":
  [USCoreObservationPregnancyStatusProfile] PregnancyStatus
    where PregnancyStatus.status = 'final'
      and PregnancyStatus.value ~ "Pregnant" 
      and PregnancyStatus.effective.toInterval() during "Measurement Period"

define "Positive Pregnancy Test Result":
  ["Laboratory Result Observation": "Pregnancy Test Codes"] PregnancyTest
    where PregnancyTest.status = 'final'
      and PregnancyTest.value ~ "Positive"
      and PregnancyTest.effective.toInterval() during "Measurement Period"
      
define "Pregnancy Encounter Diagnosis":
  [ConditionEncounterDiagnosis] EncounterDiagnosis
    with "Encounters" Encounter
      such that EncounterDiagnosis.encounter.references(Encounter)
    where EncounterDiagnosis.code in "Pregancy Condition Codes" 
      
define "Pregnancy Condition":
  [ConditionProblemsHealthConcerns] Condition
    where Condition.code in "Pregancy Condition Codes"
      and Condition.clinicalStatus ~  "active"
      and Condition.verificationStatus ~ "confirmed"
      and Condition.prevalenceInterval() starts during "Measurement Period"

define IsPregnant:
  exists "Positive Pregnancy Observation" 
    or exists "Positive Pregnancy Test"
    or exists "Pregnancy Condition"
    or exists "Pregnancy Encounter Diagnosis"
```
Note that the examples above assume the existence of a ValueSet "Pregnancy Condition Codes" containing codes pertaining to conditions while pregnant.

In addition, the "Pregnancy Encounter Diagnosis" criteria is assuming the existence of an "Encounters" expression that constraints the encounter diagnoses to measure intent as well as the measurement period.

If a use case requires the use of prevalence period (onset and/or abatement time for a condition), it will require the use of ConditionProblemsHealthConcerns or ConditionEncounterDiagnosis profiles because onset and/or abatement times are only available in the Condition resource.

### Pregnancy Intent
_Reviewed 2025-07-22_

The [Pregnancy Intent](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancyintent.html)
This profile sets minimum expectations for the Observation resource to record, search, and fetch the “patient’s intent to become pregnant” over the next year.

### Smoking Status
_Reviewed 2024-06-25_

QI-Core includes the USCore [Smoking Status](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html) profile:

```cql
// USCore Smoking Status
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html)
define SmokingStatus:
  ["USCoreSmokingStatusProfile"] O
    where O.status in { 'final', 'amended', 'corrected' }
```

### Laboratory Result
_Reviewed 2024-06-25_

Laboratory results in QI-Core use the [LaboratoryResultObservation](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-observation-lab.html) profile. By default, Laboratory results in QI-Core are characterized by the code element.

```cql
define LaboratoryResultObservation:
  ["LaboratoryResultObservation"] O
    where O.status in { 'final', 'amended', 'corrected' }
```

### Clinical Result
_Updated 2025-09-25_

Clinical test results **(including imaging results)** in QI-Core use the [ObservationClinicalResult](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-observation-clinical-result.html) profile. By default, clinical test results in QI-Core are characterized by the code element.

```cql
define ObservationClinicalResult:
  ["ObservationClinicalResult"] O
    where O.status in { 'final', 'amended', 'corrected' }
```

Note that observations associated with imaging are expected to represent specific measurements obtained from imaging. See the [Imaging Procedures](#imaging-procedures) discussion for more information.

> NOTE: US Core STU 5 defined two different profiles for clinical results, one for [test results](https://hl7.org/fhir/us/core/STU5.0.1/StructureDefinition-us-core-observation-clinical-test.html), and one for [imaging results](https://hl7.org/fhir/us/core/STU5.0.1/StructureDefinition-us-core-observation-imaging.html). These profiles were combined in US Core 6 in the clinical result profile. There is currently a known issue with the QI Core STU 6 clinical result profile that incorrectly indicates that the profile excludes imaging results. This issue is being tracked as [FHIR-50135](https://jira.hl7.org/browse/FHIR-50135), current plan is to address as an STU update publication of QI Core 6.

### Surveys and Assessments
_Reviewed 2024-06-25_

**New from 4.1.1** Surveys and assessments in QI-Core use the [ObservationScreeningAssessment](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-observation-screening-assessment.html) profile. By default, survey observations in QI-Core are characterized by the code element.

```cql
define ObservationAssessemt:
  ["ObservationScreeningAssessment"] O
    where O.status in { 'final', 'amended', 'corrected' }
```

## Simple Observations
_Reviewed 2025-07-22_

In addition, QI-Core defines a [Simple Observation](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-simple-observation.html) profile for use when accessing observations that are not covered by the specific profiles defined in FHIR and US Core. Observations in QI-Core are characterized by the code element, which is typically filtered to a particular value set:

```cql
define "Pap Test with Results":
  ["SimpleObservation": "Pap Test"] PapTest
    where PapTest.value is not null
      and PapTest.status in { 'final', 'amended', 'corrected', 'preliminary' }
```

NOTE: As with the other observation profiles, the status of a QI-Core Observation must be considered in order to ensure that the results of the expression will match measure intent. This typically means that the status element will be used in the expression as in the prior example.

## Observations cancelled (not done)
_Reviewed 2025-07-22_

QI-Core defines an [ObservationCancelled](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-observationcancelled.html) profile originally intended to support identifying observations that were not performed for a particular reason. However, feedback from implementers and HL7 standards experts indicates that an observation not performed for a reason does not exist since no observations occurred. Therefore, there is no such concept of an observation cancelled. However, a user can reject a proposal to perform an observation. To express such a rejection in QI-Core, use [QI-Core TaskRejected](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-taskrejected.html) with [focus](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-taskrejected-definitions.html#diff_Task.focus) = [ServiceRequested](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-servicerequested.html) where the requested service is the intended observation represented as a code or a value set.

```cql
define "Pap Test Rejected for Reason":
  ["ServiceRequest": "Pap Test"] PapTestRequest
    with ["TaskRejected": Fulfill] Rejection
      such that Rejection.focus.references(PapTestRequest)
        and Rejection.statusReason in "Negation Reason Codes"
    where PapTestRequest.status = "active"
```

### Observations Non-Patient (NEW)
_Reviewed 2024-06-25_

QI-Core defines an [ObservationNonPatient](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-nonpatient-observation.html) profile for evaluating resource use and availability rather than focusing on patients:

```cql

define "Hemodialysis machine availability":
  ["ObservationNonPatient": "Hemodialysis"] Hemo
    Where Hemo.subject ~ "Device Hemodialysis machine, device (physical object)"
      And Hemo.value ~ "Equipment available"

```
