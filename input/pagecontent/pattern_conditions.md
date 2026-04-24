# Conditions 

**Change from 4.1.1**: QI-Core STU 6 defines two profiles:
* [ConditionProblemsHealthConcerns](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-condition-problems-health-concerns.html) profile to represent information about patient problems and health concerns  
* [ConditionEncounterDiagnosis](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-condition-encounter-diagnosis.html) profile to represent diagnoses indicated as part of an encounter.

**Change from 4.1.1**: QI-Core STU6 no longer supports the use of the Encounter.diagnosisPresentOnAdmission element. The Present on Admission concepts should be represented using the Claim profile as described in the [Conditions present on admission](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#conditions-present-on-admission) section below .
Measure developers should carefully consider measure intent when building logic that evaluates conditions. If the intent is to identify conditions that were present on admission or to determine the principal diagnosis, the Claim profile must be used to access that billing related information. Refer to the [Conditions present on admission](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/Authoring-Patterns-QICore-v6.0.0#conditions-present-on-admission) section for recommended patterns and examples.

## Active conditions

By default, the Condition resource is characterized by the code element which is typically bound to a value set of diagnosis codes.

Many clinical systems distinguish between a patient's active conditions (e.g. the problem list or health concerns) and encounter diagnoses. Problem list items and health concerns generally include risher information such as clinical status and prevalence period whereas, encounter diagnoses often include only the diagnosis code recorded for the encounter. FHIR, however, both types of information is represented using the Condition resource. The category element is used to differentiate these types and the ConditionProblemsHealthProblems and ConditionEncounterDiagnosis profiles separate conditions accordingly.

Depending on measure intent, different approaches may be required to retieve condition data. In particular, clinicalStatus and prevalencePeriod are typically expected only for problem list items and health concerns. For example:

```cql
CQL:
define "Active Diabetes Conditions":
  [ConditionProblemsHealthConcerns: "Diabetes"] Condition
    where Condition.isActive()
```

The [QICoreCommon]([https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/input/cql/QICoreCommon.cql](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/wiki/input/cql/QICoreCommon.cql)) library provides `isProblemListItem()` and `isHealthConcern()` fluent functions to help identify the category of a Condition. It also provides the `isActive()` fluent function to determine whether the Condition represents an active diagnosis for the patient. The `isActive()` fluent function is equivalent to checking whether the clinicalStatus element is one of the active, recurrence, or relapse values.

NOTE: The isActive fluent function depends on the `clinicalStatus` of the Condition record. In retrospective scenarios, the data avalailable at evaluation times may no longer reflect the status that existed during the "Measurement Period" that exists at the time of evaluation. A condition may have been active during the period of interest but, inactive when the measure is executed. Therefore `isActive()` should not be used in retrospective contexts. In those cases, the most reliable approach is to evaluate the [Onset, Abatement, and Prevalence Period](#onset-abatement-and-prevalence-period) elements as described below.

NOTE: If measure intent indicates that the condition should be considered regardless of whether it is problem list, health concern, or encounter diagnosis, the category check may be omitted.

## Verified Conditions

The FHIR Condition resource includes a `verificationStatus` element that indicates, for example, whether the condition has been confirmed. Although this element is not required, it is a modifier element, meaning it has the ptential to change or even negate the meaning of the Condition (e.g. refuted). In most cases, when measure intent is to identify positive evidence of a condition, any verificationStatus of `refuted` and `entered-in-error` should be excluded if the verificationStatus element is present:

```cql
CQL:
define "Verified Conditions":
  [Condition ProblemsHealthConcerns] VerifiedCondition
    where VerifiedCondition.verificationStatus is not null implies
      (VerifiedCondition.verificationStatus ~ "confirmed"
        or VerifiedCondition.verificationStatus ~ "unconfirmed"
        or VerifiedCondition.verificationStatus ~ "provisional"
        or VerifiedCondition.verificationStatus ~ "differential"
      )
```

The following fluent functions can be used to support consistent reuse of this pattern:

```cql
CQL:
/*
@description: Returns true if the given condition either has no verification status or has a verification status of confirmed, unconfirmed, provisional, or differential
*/
define fluent function isVerified(condition FHIR.ConditionProblemsHealthConcerns):
  condition.verificationStatus is not null implies
    (condition.verificationStatus ~ "confirmed"
      or condition.verificationStatus ~ "unconfirmed"
      or condition.verificationStatus ~ "provisional"
      or condition.verificationStatus ~ "differential"
    )

/*
@description: Returns conditions in the given list that either have no verification status or have a verification status of confirmed, unconfirmed, provisional, or differential
*/
define fluent function verified(conditions List<FHIR.ConditionProblemsHealthConcerns>):
  conditions Diagnosis
    where Diagnosis.verificationStatus is not null implies
      (Diagnosis.verificationStatus ~ "confirmed"
        or Diagnosis.verificationStatus ~ "unconfirmed"
        or Diagnosis.verificationStatus ~ "provisional"
        or Diagnosis.verificationStatus ~ "differential"
      )
```

## Encounters with a condition

New to STU 6.0 
To determine whether a condition was present during the encounter, measure developers should use one of the following approaches:
1.	Encounter.reasonCode - A direct reference code or value set representing the Condition
2.	Encounter.reasonReference - A reference to a ConditionProblemsHealthConcern or ConditionEncounterDiagnosis
3.	Claim.diagnosis - Diagnosis codes captured on claims

This is a change from 4.1.1 where measure developers used the Encounter.diagnosis= value set pattern.  Measure developers should note that not all EHRs provide both Encounter.reasonCode and Encounter.reasonReference. The below support both approaches to accommodate differences in EHR implementations. 
The following example illustrates how to combine the approaches 1 and 2 above:

```cql
CQL:
define "Encounters With A Diabetes Condition":
  "Completed Encounters During the Measurement Period" CompletedEncounter
    where CompletedEncounter.reasonCode in "Diabetes"
      or exists (
        [ConditionEncounterDiagnosis: "Diabetes"] DiabetesCondition
          where CompletedEncounter.reasonReference.references(DiabetesCondition)
      )
```
Alternatively, measure developers can use the encounterDiagnosis fluent function from the CQMCommon library to express the same logic as:

```cql
CQL:
define "Encounters With A Diabetes Condition": 
   "Completed Encounters During The Measurement Period" CompletedEncounter
      where CompletedEncounter.reasonCode in "Diabetes"
        or CompletedEncounter.encounterDiagnosis().code in "Diabetes"
```

Additional Considerations:
If the clinical use case requires access to a condition’s prevalence period (i.e., onset to abatement) or even just its onset time, developers must use Approach 2 – the Encounter.reasonReference. This is because onset and/or abatement information is only available within the Condition resource.

## History of a condition

**Change from 4.1.1** When identifying a history of a condition, elements such as clinicalStatus and whether the condition appears on the problem list, or as a health concern, or as an encounter diagnosis are often less relevant. For this reason, these attributes/elements are typically not referenced in basic historical queries. However, in QI-Core, conditions are represented using two different profiles. As a result, separate retrievals are required to ensure complete capture:

```cql
CQL:
define "History Of Diabetes":
  [ConditionProblemsHealthConcerns: "Diabetes"]
    union [ConditionEncounterDiagnosis: "Diabetes"]
```

When Additional Filtering is Needed:
Depending on measure's intent, it may still be necessary to evaluate specific elements such as:

* Encounter completion status for encounter diagnoses
* clinicalStatus of problem list items and health concerns
* verificationStatus, especially to exclude refuted conditions

For example:
```cql
CQL:
define "History Of Diabetes":
  ([ConditionProblemsHealthConcerns: "Diabetes"] ConditionDM
    where ConditionDM.verificationStatus is not null implies ConditionDM.verificationStatus !~ QICoreCommon. "refuted"
  ) union (
    [ConditionEncounterDiagnosis: "Diabetes"] ConditionDM
      where ConditionDM.encounter.getEncounter().status = 'finished'
  )

define fluent function "getEncounter"(reference QICore.Reference):                 
//revised to fluent function
 singleton from (
  [Encounter] Encounter
    where reference.references(Encounter)
      )  
```

## Onset, abatement, and prevalence period

The Condition profile defines onset and abatement elements that describe a conditions’ prevalence period. These elements are modeled as choices to give systems flexibility in how the information is captured. 
In QI-Core, these choice types are constrained to forms that support actual computation of a prevalence period. The QICoreCommon library provides abatementInterval and prevalenceInterval functions to simplify access to this information. For example:

```cql
CQL:
define "Active Diabetes Conditions":                                        
 [ConditionEncounterDiagnosis: "Diabetes"] DM
  where DM.isActive()

define "Active Diabetes Conditions Onset During The Measurement Period":
  "Active Diabetes Conditions" Diabetes
    where Diabetes.prevalenceInterval() starts during "Measurement Period"
```

The `prevalenceInterval` function takes a Condition resource and returns the interval beginning at onset and ending at the abatement. If the Condition is active- that is, it has a clinicalStatus of active, recurrence, or relapse, the interval inclusive (closed). Otherwise, the ending boundary is exclusive (open). 

When determining whether a condition was active during a particular time period, measure developer should use prevalenceInterval rather than relying solely on the clinicalStatus element. The interval-based approach yields more accurate and clinically meaningful results.

## Conditions present on admission and principal diagnoses
QICore STU6 no longer supports the use of the Encounter.diagnosisPresentOnAdmission element.  To express the concept of a condition present on admission (POA), measure developers should use the QI-Core Claim profile.


### Present on Admission

```cql
CQL:
define "Encounter With Asthma Present On Admission":
  [Encounter: “Office Visit”] OfficeEncounter
   where exists  ((OfficeEncounter.claimDiagnosis()) CDiagnosis
    where (CDiagnosis.diagnosis in "Asthma"
    or CDiagnosis.diagnosis.getCondition().code in "Asthma")  
     and  CDiagnosis.onAdmission ~ "POA-Y"
      and CDiagnosis.sequence ~ 1)
```

Alternatively, this logic can be expressed using the `claimDiagnosis` fluent function from the CQMCommon library:

```cql
CQL:
define "Encounter With Asthma Present On Admission":
  [Encounter] Encounters
    where exists (
      (Encounters.claimDiagnosis()) Dx
        where Dx.onAdmission ~ "POA-Y"
          and (
            Dx.diagnosis in "Asthma"
              or Dx.diagnosis.getCondition().code in "Asthma" 
          )
    )
```

"POA" Indicator codes:

```cql
CQL:
codesystem "Present On Admission Indicators": 'https://www.cms.gov/Medicare/Medicare-Fee-for-Service-Payment/HospitalAcqCond/Coding'

code "POA-Y": 'Y' from "Present On Admission Indicators"
code "POA-N": 'N' from "Present On Admission Indicators"
code "POA-W": 'W' from "Present On Admission Indicators"
code "POA-1": '1' from "Present On Admission Indicators"
code "POA-U": 'U' from "Present On Admission Indicators"
```

Handling Code vs. Reference for Diagnosis
The examples above assume that `diagnosis` element is represented as a code rather than a reference. To account for both representations, use the isDiagnosisPresentOnAdmission fluent function:

```cql
CQL:
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
A principal diagnosis represents the condition chiefly responsible for the patient’s admission. In QI-Core, principal diagnosis information is available through the QI-Core Claim profile using the diagnosis.type element or the sequence associated with the principal diagnosis.

Principal diagnoses can be retrieved either directly from the claim resource or through the CQMCommon claimDiagnosis fluent function.

Direct Retrieval Example

```cql
CQL:
define "Patient Claim":
[Claim]
define fluent function claimDiagnosis(encounter Encounter):
  encounter E
    let 
      claim: ([Claim] C where C.status = 'Active' and C.use = 'claim' and exists (C.item I where I.encounter.references(E))),
      claimItem: (claim.item I where I.encounter.references(E))
    return claim.diagnosis D where D.sequence in claimItem.diagnosisSequence


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

Using the claimDiagnosis fluent function found in the CQM Common library:

```cql
CQL:
define "Encounter With Principal Diagnosis Of Asthma":
  [Encounter] ValidEncounter
    where exists (
      (ValidEncounter.principalDiagnosis()) Dx
        where Dx.diagnosis in "Asthma"
          or Dx.diagnosis.getCondition().code in "Asthma" 
    )
```

Including the `hasPrincipalDiagnosisOf` fluent function to simplify the expression:

```cql
CQL:
define fluent function hasPrincipalDiagnosisOf(encounter Encounter, valueSet ValueSet):
  encounter Visit
    let
      PD: singleton from ((Visit.claimDiagnosis()) D where D.type.includesCode("Principal Diagnosis")),
      CD: singleton from (([ConditionEncounterDiagnosis] union [ConditionProblemsHealthConcerns]) Diagnosis where PD.diagnosis.references(Diagnosis.id))
	return PD.diagnosis in valueSet
	  or CD.code in valueSet
```
