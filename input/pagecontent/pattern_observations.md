US Core defines a variety of profiles for representing and accessing patient’s observations. US Quality Core defines observation profiles where additional conformances are needed beyond the US Core profiles. 

### Vital Signs

When using US Core to access profiled resources, the result of the retrieve will only include resources that conform to that profile. This means that the retrieve is effectively a filter by conformance, meaning that the expression does not need to provide filters for values that are fixed by the profile definition. When retrieving Respiratory rate, for example, this means that the expression does not need to test that the code of the Observation is the LOINC code for respiratory rate (9279-1), the retrieve will only result in observations that already have that code:

```cql
CQL:
// Respiratory rate - 9279-1
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-respiratory-rate.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-respiratory-rate.html)
define RespiratoryRate:
  [USCore.RespiratoryRateProfile] RR
    where RR.status in { 'final', 'amended', 'corrected' }
```

As a rule of thumb, if a profile definition defines a fixed value constraint for an element, then the expression does not need to use that element.

```cql
CQL:
// Heart rate - 8867-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-heart-rate.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-heart-rate.html)
define "Heart Rate":
  [USCore.HeartRateProfile] HR
    where HR.status in { 'final', 'amended', 'corrected' }
```
```cql
// Body temperature - 8310-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-temperature.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-temperature.html)
define BodyTemperature:
 [USCore.BodyTemperatureProfile] BodyTemp
   where BodyTemp.status in { 'final', 'amended', 'corrected' }
    and BodyTemp.value as Quantity > 94 '[degF]' 
```

```cql
// Body height - 8302-2
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-height.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-height.html)
define BodyHeight:
  [USCore.BodyHeightProfile] BodyHt
    where BodyHt.status in { 'final', 'amended', 'corrected' }
```

```cql
// Head circumference - 9843-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-head-occipital-frontal-circumference-percentile.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-head-occipital-frontal-circumference-percentile.html)
define HeadCircumference:
  [USCore.HeadCircumferenceProfile] HeadSize
    where HeadSize.status in { 'final', 'amended', 'corrected' }
```

```cql
// Body weight - 29463-7
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-weight.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-body-weight.html)
define BodyWeight:
  [USCore.BodyWeightProfile] BodyWt
    where BodyWt.status in { 'final', 'amended', 'corrected' }
     and BodyWt.value as Quantity > 0 '[lb_av]'   
```

```cql
// Body mass index - 39156-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-bmi.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-bmi.html)
define BodyMassIndex:
  [USCore.BMIProfile] BMI
    where BMI.status in { 'final', 'amended', 'corrected' }
```

```cql
// Blood pressure systolic and diastolic - 85354-9
// Systolic blood pressure - 8480-6
// Diastolic blood pressure - 8462-4
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-blood-pressure.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-blood-pressure.html)
define "BloodPressure less than 140 over 90":
  [USCore.BloodPressureProfile] BP
    where BP.status in { 'final', 'amended', 'corrected' }
      and (BP.component[0].value as Quantity) < 140 'mm[Hg]'
      and (BP.component[1].value as Quantity) < 90 'mm[Hg]' 
```

```cql
// USCore Pediatric BMI for Age - 59576-9
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-bmi-for-age.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-bmi-for-age.html)
define PediatricBMIForAge:
  [USCore.PediatricBMIforAgeObservationProfile] PedsBMI
    where PedsBMI.status in { 'final', 'amended', 'corrected' }  
```

```cql
// USCore Pediatric Weight for Height - 77606-2
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-weight-for-height.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-pediatric-weight-for-height.html)
define PediatricWeightForHeight:
  [USCore.PediatricWeightForHeightObservationProfile] PedsHt
    where PedsHt.status in { 'final', 'amended', 'corrected' }
```

```cql
// USCore Pulse Oximetry - 59408-5
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-pulse-oximetry.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-pulse-oximetry.html)
define PulseOximetry:
  [USCore.PulseOximetryProfile] Pulse
    where Pulse.status in { 'final', 'amended', 'corrected' } 
```

Note that Oxygen Saturation is now part of the pulse oximetry profile.

  
### Pregnancy Status

US Quality Core allows for the presence of pregnancy to be represented in multiple profile resources. The US Core profile [Pregnancy Status](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancystatus.html) allows for the representation of pregnancy as an Observation. Pregnancy may also be represented as a Condition using the ConditionEncounterDiagnosis or ConditionProblemsHealthConcerns profiles.

To determine whether an individual is pregnant, measure authors should consider these four representations: 

```
CQL:
valueset "Pregnancy Condition Codes": 'TBD'
valueset "Pregnancy Test Codes": 'TBD'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
code "Pregnant": '77386006' from "SNOMEDCT" display 'Pregnant (finding)'
code "Positive": 'positive' from "Interpretation Codes"
 
define "Positive Pregnancy Observation":
 [USCore.ObservationPregnancyStatusProfile] PregnancyStatus
   where PregnancyStatus.status = 'final'
    and PregnancyStatus.value ~ "Pregnant" 
     and PregnancyStatus.effective.toInterval() during day of "Measurement Period"

define "Positive Pregnancy Test Result":
 [USQualityCore.LaboratoryResultObservation: "Pregnancy Test Codes"] PregnancyTest
   where PregnancyTest.status = 'final'
    and PregnancyTest.value ~ "Positive"
     and PregnancyTest.effective.toInterval() during day of "Measurement Period"
      
define "Pregnancy Encounter Diagnosis":
 [ConditionEncounterDiagnosis] EncounterDiagnosis
   with "Office Visit Encounters" Encounter
    such that EncounterDiagnosis.encounter.references(Encounter)
     where EncounterDiagnosis.code in "Pregnancy Condition Codes" 
      
define "Pregnancy Condition":
 [USQualityCore.ConditionProblemsHealthConcerns: code in "Pregnancy Condition Codes"] PregnancyCondition
   where PregnancyCondition.clinicalStatus ~ "active"
    and PregnancyCondition.verificationStatus ~ "confirmed"
     and PregnancyCondition.prevalenceInterval() starts during day of "Measurement Period"

define IsPregnant:
  exists "Positive Pregnancy Observation" 
    or exists "Positive Pregnancy Test Result"
    or exists "Pregnancy Encounter Diagnosis"
    or exists "Pregnancy Condition"
```
Note that the examples above assume the existence of a ValueSet "Pregnancy Condition Codes" which contain codes representing conditions associated with pregnancy.

The "Pregnancy Encounter Diagnosis" logic assumes the presences of an "Encounters" expression that filters encounters and their associated diagnoses-according the measures’ intent and measurement period.

If a use case requires evaluation of a prevalence period (onset and/or abatement), then the logic must rely on the ConditionProblemsHealthConcerns or ConditionEncounterDiagnosis profiles. This is because onset and/or abatement information is available only within the Condition resource and cannot be derived from observation -based pregnancy representations. 

### Pregnancy Intent

The [Pregnancy Intent](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-observation-pregnancyintent.html)profile defines minimum expectations for the Observation resource to support recording, searching, and retrieving information about a “patient’s intent to become pregnant” within the next year.

### Smoking Status
The Smoking Status profile defines the minimum expectations for the Observation resource to record, search, and retrieve a patient’s smoking status. The profile specifies the required core elements, extensions, vocabularies, and value sets that SHALL be present, and constrains how those elements must be used. 

US Quality Core includes the US Core [Smoking Status](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html) profile:

```cql
CQL:
// USCore Smoking Status
// @profile: [https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-smokingstatus.html)
define SmokingStatus:
 [USCore.SmokingStatusProfile] SmokeStatus
   where SmokeStatus.status in { 'final', 'amended', 'corrected' }
```

### Laboratory Result
Laboratory results in US Quality Core use the [US Quality Core Laboratory Result Observation](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-observation-lab.html) profile. By default, Laboratory results in US Quality Core are characterized by the code element.

```cql
CQL:
  define LaboratoryResultObservation:
  [LaboratoryResultObservation] LabResult
    where LabResult.status in { 'final', 'amended', 'corrected' }
```
Category is fixed to laboratory.

### Clinical Result
Clinical test results (non- imaging and non-lab results) in US Quality Core use [US Quality Core Observation Clinical Result](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-observation-clinical-result.html) profile which defines the minimum expectations for using the Observation resource to record and search non-laboratory clinical test results, such as procedure-based observations (e.g., the size of a polyp seen during colonoscopy).

```cql
CQL:
define ObservationClinicalResult:
  [ObservationClinicalResult] ClinicalResult
    where ClinicalResult.status in { 'final', 'amended', 'corrected' }
```

<strong style="color:red;">REVIEW NEEDED: Confirm imaging language.</strong>NOTE: Observations associated with imaging are expected to represent specific measurements obtained from imaging. See the [Imaging Procedures](#imaging-procedures) discussion for more information.


### Surveys and Assessments
The US Quality Core Observation Screening Assessment Profile, derived from the US Core version, supports representing individual survey responses, multi-question panels, and multi-select (“check all that apply”) answers. 

Surveys and assessments in US Quality Core use the [US Quality Core Observation Screening Assessment](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-observation-screening-assessment.html) profile. By default, survey observations in US Quality Core are characterized by the code element.

```cql
CQL:
define ObservationAssessemt:
  [ObservationScreeningAssessment] Assessment
    where Assessment.status in { 'final', 'amended', 'corrected' }
```
Category is fixed to survey.

### Simple Observations

US Quality Core defines a [US Quality Core Simple Observation](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-simple-observation.html) profile for use when accessing observations that are not covered by the specific profiles defined in FHIR and US Core. Observations in US Quality Core are characterized by the code element, which is typically filtered to a particular value set:

```cql
CQL:
define "Pap Test With Results":
  [SimpleObservation: "Pap Test"] PapTest
    where PapTest.value is not null
      and PapTest.status in { 'final', 'amended', 'corrected', 'preliminary' }
```

NOTE: As with the other observation profiles, the status of a US Quality Core Observation must be considered to ensure that the results of the expression will match measure intent. This typically means that the status element will be used in the expression as in the prior example.

### Observations Not Done

In US Quality Core, an observation not done is represented by the rejection of a proposal to perform an observation. To express such a rejection, use [US Quality Core Task Rejected](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-taskrejected.html) with [focus](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-taskrejected-definitions.html#Task.focus) = [US Quality Core ServiceRequest](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-servicerequest.html) where the requested service is the intended observation represented as a code or a value set.

```cql
CQL:
define "Pap Test Rejected For Reason":
  [ServiceRequest: "Pap Test"] PapTestRequest
    with [TaskRejected: code "Fulfill"] Rejection
      such that Rejection.focus.references(PapTestRequest)
        and Rejection.statusReason in "Patient Declined"
    where PapTestRequest.status = "Active"
```

### Observations Non-Patient

<strong style="color:red;">REVIEW NEEDED: should it be noted this is out of scope</strong>

US Quality Core defines a [US Quality Core NonPatient Observation](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-nonpatient-observation.html) profile for evaluating resource use and availability rather than focusing on patients:

```cql
CQL:
define "Hemodialysis Machine Availability":
 [NonPatientObservation: "Hemodialysis"] Hemo                                                        
   where Hemo.subject.getDevice().type ~ "Hemodialysis machine, device (physical object)"              
    and Hemo.value ~ "Equipment type available"

define fluent function "getDevice"(reference FHIR.Reference):                 
 singleton from (
  [Device] Device
    where reference.references(Device)
      )   
```
