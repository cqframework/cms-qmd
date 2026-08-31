FHIR represents devices intended for personal use by a patient &mdash; canes, glucometers, CPAP machines &mdash; with the [Device](https://hl7.org/fhir/R4/device.html) and [DeviceRequest](https://hl7.org/fhir/R4/devicerequest.html) resources. Devices used by clinicians, or managed as facility resources such as infusion pumps and wheelchairs, are not represented with the patient-use device profiles: an order for a service performed with such a device is a [ServiceRequest](pattern_procedures.html#procedure-ordered), and its availability is a [non-patient observation](pattern_observations.html#observations-non-patient).

The US CQL implementation guide does not publish a Device patterns page, so this page is the primary source for device patterns; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

### Device ordered

US Quality Core defines the [US Quality Core DeviceRequest](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-devicerequest.html) profile to represent the proposal, planning, or ordering of a device for a patient, characterized by `code`, which may be a code or a reference.

```cql
define "Device Indicating Frailty":
  [USQualityCore.DeviceRequest: "Frailty Device"] FrailtyDeviceOrder
    without [USQualityCore.TaskRejected] TaskReject
      such that TaskReject.focus.references(FrailtyDeviceOrder)
        and TaskReject.code ~ FHIRCommon."Fulfill"
    where FrailtyDeviceOrder.status in { 'active', 'on-hold', 'completed' }
      and FrailtyDeviceOrder.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
```

The profile does not fix `status`, so the expression must account for every value relevant to measure intent; `active`, `on-hold`, and `completed` together identify a positive device order. The profile does fix `doNotPerform` to false where present, but systems commonly omit the element unless it is true, so logic testing it against an unconstrained request should use `doNotPerform is not true` &mdash; see [Working with doNotPerform](patterns.html#working-with-donotperform).

### Device not ordered

US Quality Core defines the [US Quality Core Device Not Requested](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-devicenotrequested.html) profile to document the reason a device, or class of devices, was not ordered. The profile fixes `doNotPerform` to true, so it need not be tested. See [Negation Patterns](patterns.html#negation-patterns).

```cql
define "CPAP Prohibited":
  [USQualityCore.DeviceNotRequested: "CPAP"] CPAPProhibited
    where CPAPProhibited.status = 'active'
      and CPAPProhibited.intent = 'order'
```

A prohibition is a different statement from the rejection of a proposal, which uses TaskRejected against the positive request:

```cql
define "CPAP Order Rejected for Reason":
  [USQualityCore.DeviceRequest: "CPAP"] DeviceOrdered
    with [USQualityCore.TaskRejected] TaskRejected
      such that TaskRejected.focus.references(DeviceOrdered)
        and TaskRejected.code ~ FHIRCommon."Fulfill"
        and (TaskRejected.statusReason in "Medical Reason For Not Providing Treatment"
          or TaskRejected.statusReason in "Patient Declined")
    where DeviceOrdered.status = 'active'
```

### Device in use

Where measure intent is that a device is actually in use rather than ordered, the Device profile is used:

```cql
define "CPAP In Use":
  [USQualityCore.Device: "CPAP"] CPAPInUse
    where CPAPInUse.status = 'active'
```

> NOTE: The US Quality Core Device and DeviceUseStatement profiles are both marked with an asterisk in the [US Quality Core profile list](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/profiles.html), meaning they are not part of that guide's conformance expectations. DeviceRequest and Device Not Requested, used above, are in scope.
