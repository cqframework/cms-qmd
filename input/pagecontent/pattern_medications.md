# Medications
_Reviewed 2025-07-22_

FHIR defines several medication-related resources that are profiled for use in the US by US Core, and then by QI-Core for use in quality improvement artifacts. For background on the FHIR medication resources, see the [Medication module](https://hl7.org/fhir/medications-module.html) in the base FHIR specification. Additional guidance on how medication information is profiled within US Core can be found in the [Medication list guidance](https://hl7.org/fhir/us/core/STU6.1/medication-list.html) topic in the US Core implementation guide.  In comparison to STU 4.1.1, there are no new medication profiles added to STU6 of QI-Core.

## Medication ordered
QICore defines the [MedicationRequest](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-medicationrequest.html) profile to represent medication proposals, plans, and orders, as well as self-reported medications. The following example illustrates an order for Antithrombotic Therapy to be taken by the patient once discharged. MedicationRequest resources in QI-Core are characterized by the `medication` element which can be represented as a code or a reference.
```
define "Antithrombotic Therapy at Discharge":
  ["MedicationRequest": "Antithrombotic Therapy"] Antithrombotic
    where (Antithrombotic.isCommunity() or Antithrombotic.isDischarge())
      and Antithrombotic.status in { 'active', 'completed' }
      and Antithrombotic.intent = 'order'
      and not exists (["TaskRejected"] TaskReject where TaskReject.focus.references(Antithrombotic) and TaskReject.code ~ "fulfill")
```

NOTE: Because the `status` element is a modifier that is not constrained by the profile to a specific value or value set, authors must consider all the possible values of the status to ensure the expression matches measure intent. In this case the statuses of `active` and `completed` indicate active or filled prescriptions for medications in the Antithrombotic Therapy value set.
NOTE: Because the MedicationRequest profile fixes the value of the `doNotPerform` element to false if it is present, that element does not need to be tested in the expression.

## Medication not ordered
QI-Core defines the [MedicationNotRequested](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-medicationnotrequested.html) profile to represent documentation of the reason for not ordering a particular medication or class of medications. By default, MedicationNotRequested resources in QI-Core are characterized by the `medication` element which can be represented as a code or a reference. Note that the profile includes _MedicationNotRequested.doNotPerform, fixed value = true_ to fulfill the use case asking that the medication order not occur (i.e. the Medication is prohibited). To fulfill the use case for which the user rejects a proposal to order a medication requires the TaskRejected profile

1. _Search for medication prohibited (not ordered) for a reason:_
```
define "Antithrombotics Prohibited for Reason":
  ["MedicationNotRequested": "Antithrombotic Therapy"] NoAntithromboticDischarge
    where (NoAntithromboticDischarge.reasonCode in "Medical Reason"
      or NoAntithromboticDischarge.reasonCode in "Patient Refusal")
      and (NoAntithromboticDischarge.isCommunity() or NoAntithromboticDischarge.isDischarge())
      and NoAntithromboticDischarge.status in { 'active', 'completed' }
      and NoAntithromboticDischarge.intent = 'order'
      and not exists (["TaskRejected"] TaskReject where TaskReject.focus.references(Antithrombotic) and TaskReject.code ~ "fulfill")
```

NOTE: Because the `status` element is a modifier that is not constrained by the profile to a specific value or value set, authors must consider all the possible values of the status to ensure the expression matches measure intent. In this case the statuses of `active` and `completed` indicate no active or filled prescriptions for medications in the Antithrombotic Therapy value set.  
NOTE: Because the MedicationNotRequested profile fixes the value of `doNotPerform` to true, that element does not need to be tested in the expression.

2. _Search for evidence that the proposal to order the medication was rejected:_
```
define "Antithrombotics Rejected for Reason":
  ["MedicationRequest": "Antithrombotic Therapy"] AntithromboticsDischarge
    with ["TaskRejected":"Fullfill"] TaskRejected
      such that TaskRejected.focus.references(AntithromboticsDischarge)
        and (TaskRejected.statusReason in "Medical Reason"
          or TaskRejected.statusReason in "Patient Refusal")
    where AntithromboticsDischarge.status = 'active'
      and TaskRejected.code = 'Fulfill'
```

3. _Union the not ordered for reason and the rejected proposal options:_
```
define "Exclusion Criteria":
  exists "Antithrombotics Prohibited for Reason"
  or exists "Antithrombotics Rejected for Reason"
```

NOTE: A measure could also express a full set of exclusions for a medication by including the concepts of MedicationAdministrationNotDone and MedicationDispenseDeclined as:

```
define "Exclusion Criteria":
  exists "Antithrombotics Prohibited for Reason"
  or exists "Antithrombotics Rejected for Reason"
  or exists "Antithrombotics Not Administered for Reason" (using MedicationAdministeredNotDone)
  or exists "Antithrombotics Not Dispensed for Reason" (using MedicationDispenseDeclined)
```

## Medication administered
QI-Core defines the [MedicationAdministration](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-medicationadministration.html) profile to represent the administration of a medication to a patient. By default, MedicationAdministration resources in QICore are characterized by the `medication` element, which can be represented as a code or a reference.

```
define "Low Dose Unfractionated Heparin Administration":
  ["MedicationAdministration": "Low Dose Unfractionated Heparin for VTE Prophylaxis"] VTEMedication
    where VTEMedication.status = 'completed'
      and VTEMedication.category ~ QICoreCommon."Inpatient"
```

NOTE: Because the MedicationAdministration profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression matches measure intent. In this case, the `completed` status indicates the only completed medication administrations should be returned.

## Medication not administered
QI-Core defines the [MedicationAdministrationNotDone](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-medicationadministrationnotdone.html) profile to represent documentation of the reason a medication administration did not occur. By default, MedicationAdministrationNotDone resources in QI-Core are characterized by the `medication` element, which can be represented as a code or a reference. Note that the MedicationAdministrationNotDone fulfills the use case indicating the user documented a reason for not administering the medication. 

```
define "Low Dose Unfractionated Heparin for VTE Prophylaxis Not Administered":
  ["MedicationAdministrationNotDone": "Low Dose Unfractionated Heparin for VTE Prophylaxis"] VTEMedication
    where VTEMedication.category ~ QICoreCommon."Inpatient"
      and (VTEMedication.reasonCode in "Medical Reason" or VTEMedication.reasonCode in "Patient Refusal")
```

NOTE: Because the MedicationAdministrationNotDone profile fixes the value of `status` to not-done, that element does not need to be tested in the expression.

## Medication dispensed  
QI-Core defines the [MedicationDispense](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-medicationdispense.html) profile to represent the fulfillment of a medication request, either in a hospital or community pharmacy. By default, MedicationDispense resources in QI-Core are characterized by the `medication` element, which can be represented as a code or a reference.

```
define "Dementia Medication Dispensed":
  ["MedicationDispense": "Dementia Medications"] MedicationDispense
    where MedicationDispense.status in { 'active', 'completed', 'on-hold' }
```

NOTE: Because the MedicationDispense profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression matches measure intent. In this case, the `active`, `completed`, and `on-hold` statuses are used to retrieve any positive dispensing event.

## Medication not dispensed
QI-Core defines the [MedicationDispenseDeclined](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-medicationdispensedeclined.html) profile to represent documentation of the reason that a dispense did not occur. By default, MedicationDispenseDeclined resources in QICore are characterized by the `medication` element, which can be represented as a code or a reference.

```
define "Dementia Medication Not Dispensed":
    ["MedicationDispenseDeclined": "Dementia Medications"] MedicationDispense
      where MedicationDispense.statusReason in "Medical Reason"
        or MedicationDispense.statusReason in "Patient Refusal"
```

NOTE: Because the MedicationDispenseDeclined profile fixes the value of the `status` element to `declined`, that element does not need to be tested in the expression.

## Medication in use
In addition to medications ordered at discharge or administered in the hospital setting, measure developers may also want to look for medications that are currently in use by a patient outside the hospital setting or those medications not prescribed by a provider (commonly referred to as OTC or over the counter).  Two examples are shown below:

### Medication in use 
```
define "Antithrombotic Therapy Active":
  ["MedicationRequest": "Antithrombotic Therapy"] Antithrombotic
    where Antithrombotic.status = 'active'
```
### Self-administered OTCs
```
define "Niacin OTC at home":
  ["MedicationRequest": "NiacinOTC"] Niacin
    where (Niacin.isCommunity())
      and Niacin.status = 'active'
      and Niacin.intent = 'plan'
      and Niacin.reporter = 'patient'
```
Note that 'Niacin.isCommunity' reflects the MedicationRequest category which indicates the setting in which the medication is taken (or is expected to be taken) is community.
