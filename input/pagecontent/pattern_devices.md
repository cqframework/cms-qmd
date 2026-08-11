FHIR defines several resources for tracking and managing patient use, such as canes, glucometers or CPAP machines. These profiles [Device](http://hl7.org/fhir/device.html) and [DeviceRequest](http://hl7.org/fhir/devicerequest.html). represent devices intended for personal use by the patient.  In contrast, devices used by clinicians or for general resource management (e.g., infusion pumps, wheelchairs used in facilities) are represented using other profiles—not the patient-use device profiles. 

### Device ordered

US Quality Core defines the [US Quality Core DeviceRequest](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-devicerequest.html) profile to represent proposals, planning, and ordering of devices for a patient. By default, DeviceRequest resources are identified by their code element, which can be represented as a code or a reference.

```cql
CQL:
define "Device Indicating Frailty":
 [USQualityCore.DeviceRequest: "Frailty Device"] FrailtyDeviceOrder
   where FrailtyDeviceOrder.status in { 'active', 'on-hold', 'completed' }
    and FrailtyDeviceOrder.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
     and not exists (
     ["TaskRejected"] TaskReject 
      where TaskReject.focus.references(FrailtyDeviceOrder) 
       and TaskReject.code ~ "fulfill" )
```

> NOTES: 
*Status element considerations:
The DeviceRequest profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression matches measure intent. In this case the `active`, `completed` and `on-hold` statuses are used to ensure a positive device order.

*doNotPerform considerations:
Because the DeviceRequest profile fixes the value of the `doNotPerform` element to `false` if it is present, that element does not need to be tested in the expression. However, since real-world applications may not populate the value for doNotPerform unless it is true, the expression should include indication that doNotPerform is not null.

### Device not ordered

1. _Search for patient-use device not ordered for a reason:_  

US Quality Core defines the [US Quality Core Device Not Requested](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-devicenotrequested.html) profile to represent documentation of the reason for not ordering a particular device, or class of devices. By default, DeviceNotRequested resources in US Quality Core are characterized by the `code` element, which can be represented as a code or a reference.

```cql
CQL:
define "CPAP Prohibited":
  [DeviceNotRequested: "CPAP"] CPAPProhibited
    where CPAPProhibited.status = 'active'
      and CPAPProhibited.intent = 'order'
```

> NOTE: Because the DeviceNotRequested profile fixes the value of `doNotPerform` to true, this element does not need to be tested in the expression.  

2. _Search for evidence that the proposal to order the patient-use device was rejected:_  

```cql
CQL:
define "CPAP Order Rejected for Reason":
  [DeviceRequest: "CPAP"] DeviceOrdered
    with [ USQualityCore.TaskRejected: code ~ USQualityCoreCommon."Fulfill"] TaskRejected
      such that TaskRejected.focus.references(DeviceOrdered)
        and (TaskRejected.statusReason in "Medical Reason For Not Providing Treatment" 
          or TaskRejected.statusReason in "Patient Declined"
        )
    where DeviceOrdered.status = 'active'
```

### Device in use

When the measure objective is to identify actual Device use, the Device profile should be used.

<strong style="color:red;">REVIEW NEEDED: should we note this profile is out of scope</strong>
```cql
CQL:
define "CPAP In Use":
  [Device: "CPAP"] CPAPInUse
    where CPAPInUse.status = 'active'
```
