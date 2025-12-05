# Devices

FHIR defines several resources related to the tracking and management of devices used by patients, including [Device](http://hl7.org/fhir/device.html) and [DeviceRequest](http://hl7.org/fhir/devicerequest.html).  It is important to note that the types of devices modelled by these profiles are those that are considered personal use by the patient (examples include frailty devices like canes, glucometers or CPAP machines). In comparison to STU 4.1.1, there are no new device profiles added to STU6 of QI-Core.

## Device ordered
_Reviewed 2025-07-22_

QI-Core defines the [DeviceRequest](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-devicerequest.html) profile to represent proposals, planning, and ordering of devices for a patient. By default, DeviceRequest resources in QICore are characterized by the `code` element, which can be represented as a code or a reference.

```cql
define "Device Indicating Frailty":
  [DeviceRequest: "Frailty Device"] FrailtyDeviceOrder
    where FrailtyDeviceOrder.status in { 'active', 'on-hold', 'completed' }
      and FrailtyDeviceOrder.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
      and not exists (["TaskRejected"] TaskReject where TaskReject.focus.references(FrailtyDeviceOrder) and TaskReject.code ~ "fulfill")
```

> NOTE: Because the DeviceRequest profile does not fix the value of the `status` element, authors must consider all the possible values of the element to ensure the expression matches measure intent. In this case the `active`, `completed` and `on-hold` statuses are used to ensure a positive device order.

> NOTE: Because the DeviceRequest profile fixes the value of the `doNotPerform` element to `false` if it is present, that element does not need to be tested in the expression. However, since real-world applications may not populate the value for doNotPerform unless it is true, the expression should include indication that doNotPerform is not null.

## Device not ordered

1. _Search for patient-use device not ordered for a reason:_  

QI-Core defines the [DeviceNotRequested](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-devicenotrequested.html) profile to represent documentation of the reason for not ordering a particular device, or class of devices. By default, DeviceNotRequested resources in QI-Core are characterized by the `code` element, which can be represented as a code or a reference.

```cql
define "CPAP Prohibited":
  ["DeviceNotRequested": "CPAP"] CPAPProhibited
    where CPAPProhibited.status = 'active'
      and CPAPProhibited.intent = 'order'
```

> NOTE: Because the DeviceNotRequested profile fixes the value of `doNotPerform` to true, this element does not need to be tested in the expression.  

2. _Search for evidence that the proposal to order the patient-use device was rejected:_  

```cql
define "CPAP Order Rejected for Reason":
  ["DeviceRequest": "CPAP"] DeviceOrdered
    with ["TaskRejected": Fulfill] TaskRejected
      such that TaskRejected.focus.references(DeviceOrdered)
        and (TaskRejected.statusReason in "Medical Reason"
          or TaskRejected.statusReason in "Patient Refusal"
        )
    where DeviceOrdered.status = "active"
```

## Device in use

For those cases where measurement is looking to capture the use of a device, the Device profile should be used.

```cql
define "CPAP in use":
  ["Device": "CPAP"] CPAPInUse
    where CPAPInUse.status = 'active'
```
