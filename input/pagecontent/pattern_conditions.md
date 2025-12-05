# Conditions 
_Reviewed 2025-04-01_

**Change from 4.1.1**: QI-Core STU 6 defines two profiles:
* [ConditionProblemsHealthConcerns](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-condition-problems-health-concerns.html) profile to represent information about patient problems and health concerns  
* [ConditionEncounterDiagnosis](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-condition-encounter-diagnosis.html) profile to represent diagnoses indicated as part of an encounter.

**Change from 4.1.1**: QI-Core STU6 no longer supports the use of the Encounter.diagnosisPresentOnAdmission element.  This concept should be modeled using the Claim profile and is discussed in the [Conditions present on admission](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#conditions-present-on-admission) section below .
Measure developers need to consider their measure intent when building measure logic to look for conditions.  If the measure intent is looking to capture conditions that were present on admission or a principal diagnosis, the Claim profile is now used to access that billing related content.  Please reference the [Conditions present on admission](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#conditions-present-on-admission) section for patterns related to those concepts.

## Active conditions
_Reviewed 2025-05-06_

By default, Condition resources are characterized by the code element which is typically associated with a value set of diagnosis codes.

Many clinical systems make a distinction between the active conditions for a patient (i.e. the problem list or health concerns) and the diagnoses associated with an encounter. Problem list items and health concerns are typically documented with additional information about the condition such as prevalence period and clinical status, while encounter diagnoses typically have less information, usually only the diagnosis code as part of the encounter information. Within FHIR, both these types of data are represented using the Condition resource. The category element is used to indicate which kind of data the Condition represents, a problem list item, a health concern, or an encounter diagnosis, and the ConditionProblemsHealthProblems and ConditionEncounterDiagnosis profiles separate conditions by these categories.

Depending on measure intent, different approaches may be needed to access condition data. In particular, clinical status and prevalence period would only be expected to be present on problem list items and health concerns:

```cql
define "Active Diabetes Conditions":
  [ConditionProblemsHealthConcerns: "Diabetes"] Condition
    where Condition.isActive()
```

The [QICoreCommon]([https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/input/cql/QICoreCommon.cql](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/input/cql/QICoreCommon.cql)) library defines `isProblemListItem()` and `isHealthConcern()` functions to facilitate identifying the category of a Condition, as well as an `isActive()` function to facilitate determining whether the Condition indicates the presence of a particular diagnosis for the patient. The `isActive()` function is equivalent to testing the clinicalStatus element for the active, recurrence, and relapse values.

NOTE: The isActive function makes use of the `clinicalStatus` element of the Condition, which is the _current_ status of the Condition record. In other words, in retrospective cases, the logic may be evaluated on data that exists at the time of evaluation. This means that while a given condition may have been active during the measurement period, it might no longer be active when the measure is run. As such, the `isActive()` function should not be used in retrospective contexts. Instead, the most reliable way to determine whether a condition was active _at some point in time_ is to use the [Onset, Abatement, and Prevalence Period](#onset-abatement-and-prevalence-period) elements as discussed below.

NOTE: If measure intent is such that condition information should be considered whether it is problem list, health concern, or encounter diagnosis, the category check can be omitted.

## Verified Conditions
_Updated 2025-06-10_

The Condition resource in FHIR has a `verificationStatus` element to represent, for example, whether the information has been confirmed. The element is not required, but if it is present, it is a modifier element, and has the potential to negate the information the Condition resource represented (e.g. refuted). For most usage, when measure intent is looking for positive evidence of a condition, the verificationStatuses of `refuted` and `entered-in-error` should be excluded if verificationStatus is present:

```cql
define "Verified Conditions":
  [Condition] VerifiedCondition
    where VerifiedCondition.verificationStatus is not null implies
      (VerifiedCondition.verificationStatus ~ "confirmed"
        or VerifiedCondition.verificationStatus ~ "unconfirmed"
        or VerifiedCondition.verificationStatus ~ "provisional"
        or VerifiedCondition.verificationStatus ~ "differential"
      )
```

To support reuse of this pattern, the following fluent functions can be used:

```cql
/*
@description: Returns true if the given condition either has no verification status or has a verification status of confirmed, unconfirmed, provisional, or differential
*/
define fluent function isVerified(condition FHIR.Condition):
  condition.verificationStatus is not null implies
    (condition.verificationStatus ~ "confirmed"
      or condition.verificationStatus ~ "unconfirmed"
      or condition.verificationStatus ~ "provisional"
      or condition.verificationStatus ~ "differential"
    )

/*
@description: Returns conditions in the given list that either have no verification status or have a verification status of confirmed, unconfirmed, provisional, or differential
*/
define fluent function verified(conditions List<FHIR.Condition>):
  conditions C
    where C.verificationStatus is not null implies
      (C.verificationStatus ~ "confirmed"
        or C.verificationStatus ~ "unconfirmed"
        or C.verificationStatus ~ "provisional"
        or C.verificationStatus ~ "differential"
      )
```

## Encounters with a condition
_Reviewed 2025-05-06_

New to STU 6.0 
To determine a condition existed during the encounter, measure developers should use one of the following approaches:
1.	Encounter.reasonCode = direct reference code or value set (of the Condition)
2.	Encounter.reasonReference references ConditionProblemsHealthConcern or ConditionEncounterDiagnosis
3.	Claim.diagnosis

This is a change from 4.1.1 where measure developers used the Encounter.diagnosis= value set pattern.  Measure developers should note that not all EHRs will have both Encounter.reasonCode and Encounter.reasonReference and patterns are developed below to look for that information both ways to account for differences in EHR implementation. The following example combines the approaches from 1 and 2 above:

```cql
define "Encounters with a Diabetes Condition":
  "Completed Encounters During the Measurement Period" CompletedEncounter
    where CompletedEncounter.reasonCode in "Diabetes"
      or exists (
        [ConditionEncounterDiagnosis: "Diabetes"] DiabetesCondition
          where CompletedEncounter.reasonReference.references(DiabetesCondition)
      )
```
Alternatively, measure developers can use the CQMCommon library fluent function encounterDiagnosis to write the same logic as:

```cql
define "Encounters with a Diabetes Condition": 
   "Completed Encounters During the Measurement Period" CompletedEncounter
      where CompletedEncounter.reasonCode in "Diabetes"
        or CompletedEncounter.encounterDiagnosis().code in "Diabetes"
```

It is also important for measure developers to consider that if their clinical use case requires the use of prevalence period (i.e., onset to abatement time for a condition) or even just onset time, that will require the use of option 2 – the Encounter.reasonReference to a ConditionProblemsHealthConcerns, because onset and/or abatement times are only available in the Condition resource.

## History of a condition
_Reviewed 2025-04-01_

**Change from 4.1.1** When looking for history of a condition, clinical status and whether or not the condition is documented as a problem list, health concern, or encounter diagnosis are typically less relevant, so those elements are not typically referenced. However, in QI-Core, because the two types of conditions are represented with different profiles, separate retrieve statements are used to gather both:

```cql
define "History of Diabetes":
  [ConditionProblemsHealthConcerns: "Diabetes"]
    union [ConditionEncounterDiagnosis: "Diabetes"]
```

Note that depending on measure intent, it may still be necessary to reference elements such as:

* Completion status of the associated encounter for encounter diagnoses
* Clinical status of problem list items and health concerns
* Verification status of problem list items and health concerns, especially refuted conditions

For example:
```cql
define "History of Diabetes":
  ([ConditionProblemsHealthConcerns: "Diabetes"] Condition
    where Condition.verificationStatus is not null implies Condition.verificationStatus !~ "refuted"
  ) union (
    [ConditionEncounterDiagnosis: "Diabetes"] Condition
      where Condition.getEncounter().status = 'finished'
  )
```

## Onset, abatement, and prevalence period
_Reviewed 2025-04-01_

The Condition profiles define `onset` and `abatement` elements that specify the prevalence period of the condition. The elements can be specified as choices of various types to allow systems flexibility in the way that information is represented. The QI-Core profiles for Condition constrain those choices to only those that support actual computation of a prevalence period, and the QICoreCommon library defines `abatementInterval` and `prevalenceInterval` functions to facilitate accessing this information:

```cql
define "Active Diabetes Conditions Onset During the Measurement Period":
  "Active Diabetes Conditions" Diabetes
    where Diabetes.prevalenceInterval() starts during "Measurement Period"
```

The `prevalenceInterval` function takes a Condition resource and returns the interval from the start of the onset to the end of the abatement. If the Condition is active (i.e. has a clinicalStatus of active, recurrence, or relapse), then the ending boundary of the interval is inclusive (i.e. closed). Otherwise, the ending boundary of the interval is exclusive (i.e. open). When looking for whether a condition was active at some point, use the prevalenceInterval function rather than looking at the status element only.

## Conditions present on admission and principal diagnoses
QICore STU6 no longer supports the use of the Encounter.diagnosisPresentOnAdmission element.  To express the concept of a condition present on admission, measure developers should use the QI Core Claim profile.


### Present on Admission
_Reviewed 2025-04-01_

```cql
define "Encounter With Asthma Present On Admission":
  [Encounter] E
    let
      claim: ("Patient Claim" C where exists (C.item I where I.encounter.references(E))),
      claimItem: (claim.item I where I.encounter.references(E))
      claimDiagnosis: (claim.diagnosis D where D.sequence in claimItem.diagnosisSequence)
    where claimDiagnosis.diagnosis in "Asthma"
      and claimDiagnosis.onAdmission ~ "POA-Y"
```

Alternatively, this can be expressed by making use of the `claimDiagnosis` fluent function found in the CQMCommon library:

```cql
define "Encounter With Asthma Present On Admission":
  [Encounter] E
    where exists (
      (E.claimDiagnosis()) D
        where D.onAdmission ~ "POA-Y"
          and (
            D.diagnosis in "Asthma"
              or D.diagnosis.getCondition().code in "Asthma" 
          )
    )
```

Note that the "POA-Y" code is defined as:

```cql
codesystem "Present On Admission Indicators": 'https://www.cms.gov/Medicare/Medicare-Fee-for-Service-Payment/HospitalAcqCond/Coding'

code "POA-Y": 'Y' from "Present On Admission Indicators"
code "POA-N": 'N' from "Present On Admission Indicators"
code "POA-W": 'W' from "Present On Admission Indicators"
code "POA-1": '1' from "Present On Admission Indicators"
code "POA-U": 'U' from "Present On Admission Indicators"
```

Note also that the above examples assume the `diagnosis` element is represented as a code rather than a reference. To account for both possibilities, use the isDiagnosisPresentOnAdmission fluent function:

```cql
define fluent function isDiagnosisPresentOnAdmission(encounter Encounter, diagnosisValueSet ValueSet, poaValueSet ValueSet):
  exists (
    (encounter.claimDiagnosis()) CD
      where CD.onAdmission in poaValueSet
        and (
          CD.diagnosis in diagnosisValueSet
            or CD.diagnosis.getCondition().code in diagnosisValueSet
        )
  )
```

### Principal Diagnosis
_Reviewed 2025-04-01_

```cql
define "Encounter With Principal Diagnosis of Asthma":
  [Encounter] E
    let
      claim: ("Patient Claim" C where exists (C.item I where I.encounter.references(E))),
      claimItem: (claim.item I where I.encounter.references(E))
      claimDiagnosis: (claim.diagnosis D where D.sequence in claimItem.diagnosisSequence)
    where claimDiagnosis.type.includesCode("Principal Diagnosis")
      and (
        claimDiagnosis.diagnosis in "Asthma"
          or claimDiagnosis.diagnosis.getCondition().code in "Asthma" 
      )
```

Alternatively, this can be expressed by making use of the `principalDiagnosis` fluent function found in the CQM Common library:

```cql
define "Encounter With Principal Diagnosis of Asthma":
  [Encounter] E
    where exists (
      (E.principalDiagnosis()) D
        where D.diagnosis in "Asthma"
          or D.diagnosis.getCondition().code in "Asthma" 
    )
```

Note that the above can be further simplified by using the `hasPrincipalDiagnosisOf` fluent function:

```cql
define fluent function hasPrincipalDiagnosisOf(encounter Encounter, valueSet ValueSet):
  encounter E
    let
      PD: singleton from ((E.claimDiagnosis()) D where D.type.includesCode("Principal Diagnosis")),
      CD: singleton from (([ConditionEncounterDiagnosis] union [ConditionProblemsHealthConcerns]) C where PD.diagnosis.references(C.id))
	return PD.diagnosis in valueSet
	  or CD.code in valueSet
```
