# Procedures
_Reviewed 2024-08-06_

FHIR defines several procedure-related resources to support representing the proposal, planning, ordering, and performance of services and procedures for a patient. In comparison to STU 4.1.1, there are no new procedure profiles added to STU6 of QI-Core.

## Procedure performed
QI-Core defines the [Procedure](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-procedure.html) profile to represent an in-progress or complete procedure for a patient. By default, Procedure resources in QI-Core are characterized by the `code` element.

```
define "Application of Intermittent Pneumatic Compression Devices":
  ["Procedure": "Application of Intermittent Pneumatic Compression Devices (IPC)"] DeviceApplied
    where DeviceApplied.status = 'completed'
```

NOTE: Because the Procedure profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression meets measure intent. In this case, `completed` status is used to indicate that only completed procedures should be returned.

## Procedure not done
QI-Core defines the [ProcedureNotDone](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-procedurenotdone.html) profile to represent documentation of the reason a particular procedure, or class of procedures, was not performed. By default, ProcedureNotDone resources in QI-Core are characterized by the `code` element.

```
define "Intermittent Pneumatic Compression Devices Not Applied":
  [ProcedureNotDone: "Application of Intermittent Pneumatic Compression Devices (IPC)"] DeviceNotApplied
    where DeviceNotApplied.statusReason in "Medical Reason" 
      or DeviceNotApplied.statusReason in "Patient Refusal"
```

NOTE: Because the ProcedureNotDone profile fixes the value of the `status` element to `not-done`, that element does not need to be tested in the expression.

## Procedure ordered
_Reviewed 2025-07-22_

QI-Core defines the [ServiceRequest](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-servicerequest.html) profile to represent the proposal, planning, or ordering of a particular service. By default, ServiceRequest resources in QI-Core are characterized by the `code` element.

```
define "Intermittent Pneumatic Compression Devices Ordered":
  ["ServiceRequest": "Application of intermittent pneumatic compression devices (IPC)"] DeviceOrdered
    where DeviceOrdered.status in { 'active', 'completed', 'on-hold' }
      and not exists (["TaskRejected"] TaskReject where TaskReject.focus.references(DeviceOrdered) and TaskReject.code ~ "fulfill")          
```
NOTE: ServiceRequest is the appropriate profile to retrieve information about orders for non-patient use devices such as the example intermittent pneumatic compression devices (IPC). If the order was for a patient-use device, the appropriate profile would be DeviceRequest.  

NOTE: Because the ServiceRequest profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression matches measure intent. In this case, the `active`, `completed`, and `on-hold` statuses are used to ensure a positive order.  

NOTE: Because the ServiceRequest profile fixes the value of the `doNotPerform` element to false if it is present, that element does not need to be tested in the expression. However, since real-world applications may not populate the value for doNotPerform unless it is _true_, the expression should include indication that doNotPerform is not null.  

## Procedure not ordered

1. _Search for procedure not ordered for a reason:_  

QI-Core defines the [ServiceNotRequested](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-servicenotrequested.html) profile to represent documentation of the reason a particular service or class of services was not ordered. By default, ServiceNotRequested resources in QI-Core are characterized by the `code` element.

```
define "Intermittent Pneumatic Compression Devices Prohibited":
  ["ServiceNotRequested": "Application of intermittent pneumatic compression devices (IPC)"] DeviceProhibited
    where (DeviceProhibited.reasonRefused in "Medical Reason"
      or DeviceProhibited.reasonRefused in "Patient Refusal")
      and DeviceProhibited.status in { 'active', 'completed', 'on-hold' }
```

NOTE: Because the ServiceNotRequested profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression matches measure intent. In this case, the `active`, `completed`, and `on-hold` statuses are used to ensure a valid order statement.
NOTE: Because the ServiceNotRequested profile fixes the value of `doNotPerform` to true, that element does not need to be tested in the expression.


2. _Search for evidence that the proposal to order the procedure was rejected_  

```
define "Application of intermittent pneumatic compression devices (IPC) Order Rejected for Reason":
  ["ServiceRequest": "Application of intermittent pneumatic compression devices (IPC)"] DeviceOrdered
    with ["TaskRejected": "Fulfill"] TaskRejected
      such that TaskRejected.focus.references(DeviceOrdered)
        and TaskRejected.code = 'Fulfill'
        and (TaskRejected.statusReason in "Medical Reason"
          or TaskRejected.statusReason in "Patient Refusal"
        )
    where DeviceOrdered.status = 'active'
```

## Imaging Procedures
_Updated 2025-10-08_

In FHIR generally, because they involve significant and specialized information, imaging procedures (such as X-Rays, CT-Scans, MRIs, etc.) have resources designed specifically to represent imaging information. Overall, imaging procedures are represented using a combination of the following FHIR resources:

* [ServiceRequest](http://hl7.org/fhir/R4/servicerequest.html) - representing a proposal, plan, or order for an imaging procedure, using the `code` element to distinguish the type of procedure being ordered
* [Procedure](http://hl7.org/fhir/R4/procedure.html) - representing the actual performance of the imaging procedure, using the `code` element to distinguish the type of procedure performed
* [ImagingStudy](http://hl7.org/fhir/R4/imagingstudy.html) - representing the resulting images and other DICOM content, using the `procedureCode`, `procedureReference`, and/or `basedOn` elements to associate the study to an order or procedure
* [DiagnosticReport](http://hl7.org/fhir/R4/diagnosticreport.html) - representing the interpretation or clinical impression of the imaging procedure (detected or ruled out diagnoses), using the `code` element to distinguish the type of test or report
* [Observation](http://hl7.org/fhir/R4/observation.html) - representing individual measurements and comments on the images, using the `code` element to distinguish the type of measurement
* [Claim](http://hl7.org/fhir/R4/claim.html) - when used in a provider system, representing the claim for an imaging procedure, specifically the `procedure[x]` element to distinguish the type of procedure performed

Depending on the procedure, and the extent to which the results of that procedure are captured by clinical systems, there is variation in whether each of these resources is present for any given imaging procedure. In particular, [Some diagnostic procedures might not have a Procedure record. The Procedure record is only necessary when there is a need to capture information about the physical intervention that was performed to capture the diagnostic information (e.g. anaesthetic, incision, scope size, etc.)](https://hl7.org/fhir/procedure.html#bnr). As a result, authors must consider how to approach gathering information for specific procedures to ensure expressions match measure intent.

For example, if measure intent is that a CT Scan was performed, regardless of the results of that scan, authors should consider looking in all of the above possible locations for evidence that a CT Scan was performed:

* [ServiceRequest](#procedure-ordered) with an intent of order and a status of completed
* [Procedure](#procedure-performed) with a status of completed
* [ImagingStudy](http://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-imagingstudy.html) with a status of available and related by `basedOn` or one of the `procedure` elements
* [DiagnosticReportNote](http://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-diagnosticreport-note) with a status of final, amended, appended, or corrected
* [ObservationClinicalResult](#clinical-result) with a status of final, amended, or corrected

If measure intent is only looking for the performance of the scan, not whether it was resulted, the first two may suffice:

```cql
define "CT Scan Order Completed":
  ["ServiceRequest": "CT Scan Codes"] SR
    where SR.intent = 'order'
      and SR.status = 'completed'

define "CT Scan Procedure Performed":
  ["Procedure": "CT Scan Codes"] P
    where P.status = 'completed'

define "CT Scan Performed":
  exists "CT Scan Order Completed"
    or exists "CT Scan Procedure Performed"
```

However, if measure intent is that the scan was performed and resulted, diagnostic report provides the next level of checking:

```cql
define "CT Scan Diagnostic Report":
  ["DiagnosticReportNote": "CT Scan Notes"] DR
    where DR.status in ('final', 'amended', 'corrected', 'appended')
```

An additional check may be considered by looking for any imaging study results:

```cql
define "CT Scan Imaging Study":
  ["ImagingStudy"] IS
    where exists (IS.procedureCode C where C in "CT Scan Procedure Codes")
      or exists ("CT Scan Procedure Performed" P
        where IS.procedureReference.references(P)
      )
```

As well as potentially looking for any measurements performed as part of the scan or study.

> NOTE: This topic is a summary of discussion with the Orders & Observations Work Group in the following FHIR Zulip chat: https://chat.fhir.org/#narrow/channel/179256-Orders-and-Observation-WG/topic/How.20to.20represent.20CT-Scan.3F/with/541254708. Also note that part of that discussion suggests that [ChargeItem](https://hl7.org/fhir/R4/chargeitem.html) may be useful as a source of evidence that something was done. This needs followup and additional investigation.
