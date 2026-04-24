# Observations 

QI-Core defines a variety of profiles for representing and accessing patient’s observations. These include vital signs, laboratory data, imaging, clinical findings, device measurements, clinical assessments, pregnancy and smoking status and more.

## Vital Signs

When using QI-Core to access profiled resources, the result of the retrieve will only include resources that conform to that profile. This means that the retrieve is effectively a filter by conformance, meaning that the expression does not need to provide filters for values that are fixed by the profile definition. When retrieving Respiratory rate, for example, this means that the expression does not need to test that the code of the Observation is the LOINC code for respiratory rate (9279-1), the retrieve will only result in observations that already have that code:

```cql
CQL:
// Respiratory rate - 9279-1
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-respiratory-rate.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-respiratory-rate.html)
define "Respiratory Rate":
  [USCoreRespiratoryRateProfile] RR
    where RR.status in { 'final', 'amended', 'corrected' }
```

As a rule of thumb, if a profile definition defines a fixed value constraint for an element, then the expression does not need to use that element.

```cql
CQL:
// Heart rate - 8867-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-heart-rate.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-heart-rate.html)
define "Heart Rate":
  [USCoreHeartRateProfile] HR
    where HR.status in { 'final', 'amended', 'corrected' }
```
```cql
// Body temperature - 8310-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-temperature.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-temperature.html)
define "Body Temperature":
  [USCoreBodyTemperatureProfile] BodyTemp
    where BodyTemp.status in { 'final', 'amended', 'corrected' }
```

```cql
// Body height - 8302-2
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-height.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-height.html)
define "Body Height":
  [USCoreBodyHeightProfile] BodyHt
    where BodyHt.status in { 'final', 'amended', 'corrected' }
```

```cql
// Head circumference - 9843-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-head-occipital-frontal-circumference-percentile.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-head-occipital-frontal-circumference-percentile.html)
define "Head Circumference":
  [USCoreHeadCircumferenceProfile] HeadSize
    where HeadSize.status in { 'final', 'amended', 'corrected' }
```

```cql
// Body weight - 29463-7
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-weight.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-weight.html)
define "Body Weight":
  [USCoreBodyWeightProfile] BodyWt
    where BodyWt.status in { 'final', 'amended', 'corrected' }
```

```cql
// Body mass index - 39156-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-bmi.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-bmi.html)
define "Body Mass Index":
  [USCoreBMIProfile] BMI
    where BMI.status in { 'final', 'amended', 'corrected' }
```

```cql
// Blood pressure systolic and diastolic - 85354-9
// Systolic blood pressure - 8480-6
// Diastolic blood pressure - 8462-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-blood-pressure.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-blood-pressure.html)
define "Blood Pressure Less Than 140 Over 90":
  [USCoreBloodPressureProfile] BP
    where BP.status in { 'final', 'amended', 'corrected' }
      and BP.systolic.value < 140 'mm[Hg]'
      and BP.diastolic.value < 90 'mm[Hg]'
```

```cql
// USCore Pediatric BMI for Age - 59576-9
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-bmi-for-age.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-bmi-for-age.html)
define "Pediatric BMI For Age":
  [USCorePediatricBMIforAgeObservationProfile] PedsBMI
    where PedsBMI.status in { 'final', 'amended', 'corrected' }
```

```cql
// USCore Pediatric Weight for Height - 77606-2
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-weight-for-height.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-weight-for-height.html)
define "Pediatric Weight For Height":
  [USCorePediatricWeightForHeightObservationProfile] PedsHt
    where PedsHt.status in { 'final', 'amended', 'corrected' }
```

```cql
// USCore Pulse Oximetry - 59408-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-pulse-oximetry.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-pulse-oximetry.html)
define "Pulse Oximetry":
  [USCorePulseOximetryProfile] Pulse
    where Pulse.status in { 'final', 'amended', 'corrected' }
```

Note that Oxygen Saturation is now part of the pulse oximetry profile.

  
## Pregnancy Status

QI-Core 6.0.0 allows for the presence of pregnancy to be represented in multiple profile resources. The US Core profile [Pregnancy Status](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancystatus.html) allows for the representation of pregnancy as an Observation. Pregnancy may also be represented as a Condition using the ConditionEncounterDiagnosis or ConditionProblemsHealthConcerns profiles.

To determine whether an individual is pregnant, measure authors should consider these four representations: 

```
CQL:
valueset "Pregnancy Condition Codes": 'TBD'
valueset "Pregnancy Test Codes": 'TBD'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
code "Pregnant": '77386006' from "SNOMEDCT" display 'Pregnant (finding)'
code "Positive": 'positive' from "Interpretation Codes"
 
define "Positive Pregnancy Observation":
  [USCoreObservationPregnancyStatusProfile] PregnancyStatus
    where PregnancyStatus.status = 'final'
      and PregnancyStatus.value ~ "Pregnant" 
      and PregnancyStatus.effective.toInterval() during day of "Measurement Period"

define "Positive Pregnancy Test Result":
  [LaboratoryResultObservation: "Pregnancy Test Codes"] PregnancyTest
    where PregnancyTest.status = 'final'
      and PregnancyTest.value ~ "Positive"
      and PregnancyTest.effective.toInterval() during day of "Measurement Period"
      
define "Pregnancy Encounter Diagnosis":
  [ConditionEncounterDiagnosis] EncounterDiagnosis
    with "Encounters" Encounter
      such that EncounterDiagnosis.encounter.references(Encounter)
    where EncounterDiagnosis.code in "Pregnancy Condition Codes" 
      
define "Pregnancy Condition":
  [ConditionProblemsHealthConcerns] Condition
    where Condition.code in "Pregnancy Condition Codes"
      and Condition.clinicalStatus ~  "active"
      and Condition.verificationStatus ~ "confirmed"
      and Condition.prevalenceInterval() starts during day of "Measurement Period"

define "Is Pregnant":
  exists "Positive Pregnancy Observation" 
    or exists "Positive Pregnancy Test"
    or exists "Pregnancy Condition"
    or exists "Pregnancy Encounter Diagnosis"
```
Note that the examples above assume the existence of a ValueSet "Pregnancy Condition Codes" which contain codes representing conditions associated with pregnancy.

The "Pregnancy Encounter Diagnosis" logic assumes the presences of an "Encounters" expression that filters encounters and their associated diagnoses-according the measures’ intent and measurement period.

If a use case requires evaluation of a prevalence period (onset and/or abatement), then the logic must rely on the ConditionProblemsHealthConcerns or ConditionEncounterDiagnosis profiles. This is because onset and/or abatement information is available only within the Condition resource and cannot be derived from observation -based pregnancy representations. 

### Pregnancy Intent

The [Pregnancy Intent](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancyintent.html)profile defines minimum expectations for the Observation resource to support recording, searching, and retrieving information about a “patient’s intent to become pregnant” within the next year.

### Smoking Status
The Smoking Status profile defines the minimum expectations for the Observation resource to record, search, and retrieve a patient’s smoking status. The profile specifies the required core elements, extensions, vocabularies, and value sets that SHALL be present, and constrains how those elements must be used. 

QI-Core includes the USCore [Smoking Status](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html) profile:

```cql
CQL:
// USCore Smoking Status
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html)
define "Smoking Status":
  [USCoreSmokingStatusProfile] SmokingStatus
    where SmokingStatus.status in { 'final', 'amended', 'corrected' }
```

### Laboratory Result
QI-Core uses the US Core Laboratory Result Observation Profile which defines the minimum expectations for using the Observation resource to record, search, and retrieve laboratory test results for a patient. 

Laboratory results in QI-Core use the [LaboratoryResultObservation](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-observation-lab.html) profile. By default, Laboratory results in QI-Core are characterized by the code element.

```cql
CQL:
define "Laboratory Result Observation":
  [LaboratoryResultObservation] LabResult
    where LabResult.status in { 'final', 'amended', 'corrected' }
```
Category is fixed to laboratory.

### Clinical Result
Clinical test results (including imaging results) in QI-Core use [ObservationClinicalResult](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-observation-clinical-result.html) Profile which defines the minimum expectations for using the Observation resource to record and search non-laboratory clinical test results, such as imaging findings or procedure-based observations (e.g., the size of a polyp seen during colonoscopy).

```cql
CQL:
define "Observation Clinical Result":
  [ObservationClinicalResult] ClinicalResult
    where ClinicalResult.status in { 'final', 'amended', 'corrected' }
```

NOTE: Observations associated with imaging are expected to represent specific measurements obtained from imaging. See the [Imaging Procedures](#imaging-procedures) discussion for more information.


### Surveys and Assessments
The QI-Core Observation Screening Assessment Profile, derived from the US Core version, supports representing individual survey responses, multi-question panels, and multi-select (“check all that apply”) answers. 

**New from 4.1.1** Surveys and assessments in QI-Core use the [ObservationScreeningAssessment](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-observation-screening-assessment.html) profile. By default, survey observations in QI-Core are characterized by the code element.

```cql
CQL:
define "Observation Assessment":
  [ObservationScreeningAssessment] Assessment
    where Assessment.status in { 'final', 'amended', 'corrected' }
```
Category is fixed to survey.

## Simple Observations

QI-Core defines a [Simple Observation](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-simple-observation.html) profile for use when accessing observations that are not covered by the specific profiles defined in FHIR and US Core. Observations in QI-Core are characterized by the code element, which is typically filtered to a particular value set:

```cql
CQL:
define "Pap Test With Results":
  [SimpleObservation: "Pap Test"] PapTest
    where PapTest.value is not null
      and PapTest.status in { 'final', 'amended', 'corrected', 'preliminary' }
```

NOTE: As with the other observation profiles, the status of a QI-Core Observation must be considered to ensure that the results of the expression will match measure intent. This typically means that the status element will be used in the expression as in the prior example.

## Observations cancelled (not done) NO LONGER RECOMMENDED

QI-Core defines an [ObservationCancelled](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-observationcancelled.html) profile originally intended to support identifying observations that were not performed for a particular reason. However, feedback from implementers and HL7 standards experts indicates that an observation not performed for a reason does not exist since no observations occurred. Therefore, there is no such concept of an observation cancelled. However, a user can reject a proposal to perform an observation. To express such a rejection in QI-Core, use [QI-Core TaskRejected](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-taskrejected.html) with [focus](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-taskrejected-definitions.html#diff_Task.focus) = [ServiceRequested](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-servicerequested.html) where the requested service is the intended observation represented as a code or a value set.

```cql
CQL:
define "Pap Test Rejected For Reason":
  [ServiceRequest: "Pap Test"] PapTestRequest
    with [TaskRejected: code "Fulfill"] Rejection
      such that Rejection.focus.references(PapTestRequest)
        and Rejection.statusReason in "Patient Declined"
    where PapTestRequest.status = "Active"
```

### Observations Non-Patient (NEW)

QI-Core defines an [ObservationNonPatient](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-nonpatient-observation.html) profile for evaluating resource use and availability rather than focusing on patients:

```cql
CQL:
define "Hemodialysis Machine Availability":
  [ObservationNonPatient: "Hemodialysis"] Hemo
    where Hemo.subject.getDevice().type ~ "Device Hemodialysis machine, device (physical object)"
      and Hemo.value ~ "Equipment available"

define fluent function "getDevice"(reference QICore.Reference):                 
 singleton from (
  [Device] Device
    where reference.references(Device)
      )  
```
