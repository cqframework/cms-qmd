FHIR defines several medication-related resources that are profiled for use in US Quality Core for use in quality improvement artifacts. For background on the FHIR medication resources, see the [Medication module](https://hl7.org/fhir/R4/medications-module.html) in the base FHIR specification. Additional guidance on how medication information is profiled within US Core can be found in the [Medication list guidance](https://hl7.org/fhir/us/core/STU6.1/medication-list.html) topic in the US Core implementation guide. 

### Medication ordered
US Quality Core defines the [US Quality Core MedicationRequest](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationrequest.html) profile to represent medication proposals, plans, and orders, as well as self-reported medications. The following example illustrates an order for Antithrombotic Therapy to be taken by the patient once discharged. MedicationRequest resources in US Quality Core are characterized by the `medication` element which can be represented as a code or a reference.

```
CQL:
define "Antithrombotic Therapy at Discharge":
 [MedicationRequest: "Antithrombotic Therapy Anticoagulant"] Antithrombotic
    where (Antithrombotic.isCommunity() or Antithrombotic.isDischarge())
    and Antithrombotic.status in { 'active', 'completed' }
      and Antithrombotic.intent = 'order'
       and not exists (["TaskRejected"] TaskReject 
        where TaskReject.focus.references(Antithrombotic) 
         and TaskReject.code ~ FHIRCommon."Fulfill")
```

NOTES: 
* Because the `status` element is a modifier that is not constrained by the profile to a specific value or value set, authors must consider all the possible values of the status to ensure the expression matches measure intent. In this case the statuses of `active` and `completed` indicate active or filled prescriptions for medications in the Antithrombotic Therapy value set.
* Because the MedicationRequest profile fixes the value of the `doNotPerform` element to false if it is present, that element does not need to be tested in the expression.

### Medication Not Ordered
US Quality Core defines the [US Quality Core Medication Not Requested](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationnotrequested.html) profile to represent documentation of the reason for not ordering a particular medication or class of medications. By default, MedicationNotRequested resources in US Quality Core are characterized by the `medication` element which can be represented as a code or a reference. Note that the profile includes _MedicationNotRequested.doNotPerform, fixed value = true_ to fulfill the use case asking that the medication order not occur (i.e. the Medication is prohibited). To fulfill the use case for which the user rejects a proposal to order a medication requires the TaskRejected profile

1. _Search for medication prohibited (not ordered) for a reason:_
```
CQL:
define "Antithrombotics Prohibited for Reason":
 [USQualityCore.MedicationNotRequested: "Antithrombotic Therapy Anticoagulant"] NoAntithromboticDischarge
   where (NoAntithromboticDischarge.reasonCode in "Medical Reason For Not Providing Treatment"
    or NoAntithromboticDischarge.reasonCode in "Patient Declined")
     and (NoAntithromboticDischarge.isCommunity() or NoAntithromboticDischarge.isDischarge())
      and NoAntithromboticDischarge.status in { 'active', 'completed' }
       and NoAntithromboticDischarge.intent = 'order'
        and not exists (["TaskRejected"] TaskReject                                                                        
         where TaskReject.focus.references(NoAntithromboticDischarge)                                              
           and TaskReject.code ~ FHIRCommon."Fulfill" )  
```

NOTES: 
* Because the `status` element is a modifier that is not constrained by the profile to a specific value or value set, authors must consider all the possible values of the status to ensure the expression matches measure intent. In this case the statuses of `active` and `completed` indicate no active or filled prescriptions for medications in the Antithrombotic Therapy value set.  
* Because the MedicationNotRequested profile fixes the value of `doNotPerform` to true, that element does not need to be tested in the expression.

2. _Search for evidence that the proposal to order the medication was rejected:_
```
CQL:
define "Antithrombotics Rejected for Reason":
 [MedicationRequest: "Antithrombotic Therapy Anticoagulant"] AntithromboticsDischarge
    with [USQualityCore."TaskRejected"] TaskRejected
     such that TaskRejected.focus.references(AntithromboticsDischarge)
      and TaskRejected.code ~ FHIRCommon."Fulfill"
      and (TaskRejected.statusReason in "Medical Reason For Not Providing Treatment"
       or TaskRejected.statusReason in "Patient Declined")
        and (AntithromboticsDischarge.status = 'active') 
```

3. _Union the not ordered for reason and the rejected proposal options:_
```
CQL:
define "Exclusion Criteria":
  exists "Antithrombotics Prohibited for Reason"
  or exists "Antithrombotics Rejected for Reason"
```

NOTE: A measure could also express a full set of exclusions for a medication by including the concepts of MedicationAdministrationNotDone and MedicationDispenseDeclined as:

```
CQL:
define "Exclusion Criteria":
  exists "Antithrombotics Prohibited For Reason"
  or exists "Antithrombotics Rejected For Reason"
  or exists "Antithrombotics Not Administered For Reason" (using MedicationAdministeredNotDone)
  or exists "Antithrombotics Not Dispensed For Reason" (using MedicationDispenseDeclined)
```

### Medication administered
US Quality Core defines the [US Quality Core MedicationAdministration](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationadministration.html) profile to represent the administration of a medication to a patient. By default, MedicationAdministration resources in US Quality Core are characterized by the `medication` element, which can be represented as a code or a reference.

```
CQL:
define "Antithrombotic Therapy Administration":
  [MedicationAdministration: "Antithrombotic Therapy Anticoagulant"] VTEMedication
    where VTEMedication.status = 'completed'
      and VTEMedication.category ~ FHIRCommon."Inpatient"
```

NOTE: Because the MedicationAdministration profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression matches measure intent. In this case, the `completed` status indicates the only completed medication administrations should be returned.

### Medication not administered
US Quality Core defines the [US Quality Core MedicationAdministration Not Done](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationadministrationnotdone.html) profile to represent documentation of the reason a medication administration did not occur. By default, MedicationAdministrationNotDone resources in US Quality Core are characterized by the `medication` element, which can be represented as a code or a reference. Note that the MedicationAdministrationNotDone fulfills the use case indicating the user documented a reason for not administering the medication. 

```
CQL:
define "Antithrombotic Therapy Not Administered":
  [MedicationAdministrationNotDone: "Antithrombotic Therapy Anticoagulant"] VTEMedication
    where VTEMedication.category ~ FHIRCommon."Inpatient"
      and (VTEMedication.reasonCode in "Medical Reason For Not Providing Treatment" 
       or VTEMedication.reasonCode in "Patient Declined" )
```

NOTE: Because the MedicationAdministrationNotDone profile fixes the value of `status` to not-done, that element does not need to be tested in the expression.

### Medication dispensed  
US Quality Core defines the [US Quality Core MedicationDispense](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationdispense.html) profile to represent the fulfillment of a medication request, either in a hospital or community pharmacy. By default, MedicationDispense resources in US Quality Core are characterized by the `medication` element, which can be represented as a code or a reference.

```
CQL:
define "Antithrombotic Medication Dispensed":
  [USQualityCore.MedicationDispense: "Antithrombotic Therapy Anticoagulant"] MedicationDispense
    where MedicationDispense.status in { 'in-progress', 'completed', 'on-hold'  }
```

NOTE: Because the MedicationDispense profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression matches measure intent. In this case, the `active`, `completed`, and `on-hold` statuses are used to retrieve any positive dispensing event.

### Medication not dispensed
US Quality Core defines the [US Quality Core MedicationDispense Declined](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationdispensedeclined.html) profile to represent documentation of the reason that a dispense did not occur. By default, MedicationDispenseDeclined resources in US Quality Core are characterized by the `medication` element, which can be represented as a code or a reference.

```
CQL:
define"Antithrombotic Medication Not Dispensed":
    [MedicationDispenseDeclined: "Antithrombotic Therapy Anticoagulant"] MedicationDispense
      where MedicationDispense.statusReason in "Medical Reason For Not Providing Treatment" 
        or MedicationDispense.statusReason in "Patient Declined"
```

NOTE: Because the MedicationDispenseDeclined profile fixes the value of the `status` element to `declined`, that element does not need to be tested in the expression.

### Medication in use
In addition to medications ordered at discharge or administered in the hospital setting, measure developers may also want to look for medications that are currently in use by a patient outside the hospital setting or those medications not prescribed by a provider (commonly referred to as OTC or over the counter).  Two examples are shown below:

#### Medication in use 
```
CQL:
define "Antithrombotic Therapy Active":
  [MedicationRequest: "Antithrombotic Therapy Anticoagulant"] Antithrombotic
    where Antithrombotic.status = 'active'
```
#### Self-administered OTCs
```
CQL:
define "Cold OTC At Home":
  [MedicationRequest: "OIA_Cough_Cold_Meds"] CoughCold
   where (CoughCold.isCommunity())
      and CoughCold.status = 'active'
      and CoughCold.intent = 'plan'
```
Note that 'CoughCold.isCommunity' reflects the MedicationRequest category which indicates the setting in which the medication is taken (or is expected to be taken) is community.
