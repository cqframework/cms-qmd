FHIR defines several resources to represent the proposal, planning, ordering, and performance of services and procedures for a patient.

[Service](https://hl7.org/fhir/us/cql/en/patterns-service.html) in the US CQL implementation guide covers modifier elements, search parameters, cross-version considerations, [requested services](https://hl7.org/fhir/us/cql/en/patterns-service.html#requested-services), [procedures performed](https://hl7.org/fhir/us/cql/en/patterns-service.html#procedures-performed), [imaging procedures](https://hl7.org/fhir/us/cql/en/patterns-service.html#imaging-procedures), and [mammography](https://hl7.org/fhir/us/cql/en/patterns-service.html#mammography). The patterns below add the US Quality Core profiles and the negated forms; see the [Pattern Index](pattern_index.html) for the full list.

Neither the Procedure nor the ServiceRequest profile fixes `status`, so expressions must account for every value relevant to measure intent.

### Procedure performed

See [Procedures performed](https://hl7.org/fhir/us/cql/en/patterns-service.html#procedures-performed).

Measures use the [US Quality Core Procedure](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-procedure.html) profile, characterized by `code`.

```cql
define "Intermittent Pneumatic Compression Devices Applied":
  [USQualityCore.Procedure: "Application of Intermittent Pneumatic Compression Devices"] DeviceApplied
    where DeviceApplied.status = 'completed'
```

### Procedure not done

US Quality Core defines the [US Quality Core Procedure Not Done](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-procedurenotdone.html) profile to document the reason a procedure, or class of procedures, was not performed. The profile fixes `status` to `not-done`, so it need not be tested. See [Negation Patterns](pattern_negation.html).

```cql
define "Intermittent Pneumatic Compression Devices Not Applied":
  [USQualityCore.ProcedureNotDone: "Application of Intermittent Pneumatic Compression Devices"] DeviceNotApplied
    where DeviceNotApplied.statusReason in "Medical Reason For Not Providing Treatment"
      or DeviceNotApplied.statusReason in "Patient Declined"
```

### Procedure ordered

See [Requested services](https://hl7.org/fhir/us/cql/en/patterns-service.html#requested-services).

Measures use the [US Quality Core ServiceRequest](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-servicerequest.html) profile, characterized by `code`.

```cql
define "Intermittent Pneumatic Compression Devices Ordered":
  [USQualityCore.ServiceRequest: "Application of Intermittent Pneumatic Compression Devices"] DeviceOrdered
    without [USQualityCore.TaskRejected] TaskReject
      such that TaskReject.focus.references(DeviceOrdered)
        and TaskReject.code ~ FHIRCommon."Fulfill"
    where DeviceOrdered.status in { 'active', 'completed', 'on-hold' }
```

ServiceRequest is the right profile for a service performed on the patient, including the use of a non-patient device such as an intermittent pneumatic compression device. An order for a device the patient themselves uses is a DeviceRequest; see [Devices](pattern_devices.html).

The profile fixes `doNotPerform` to false where present, but systems commonly omit the element unless it is true, so logic testing it against an unconstrained request should use `doNotPerform is not true` rather than an equality comparison &mdash; see [Working with doNotPerform](pattern_negation.html#working-with-donotperform).

### Procedure not ordered

US Quality Core defines the [US Quality Core Service Not Requested](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-servicenotrequested.html) profile to document the reason a service, or class of services, was not ordered. The profile fixes `doNotPerform` to true.

```cql
define "Intermittent Pneumatic Compression Devices Prohibited":
  [USQualityCore.ServiceNotRequested: "Application of Intermittent Pneumatic Compression Devices"] DeviceProhibited
    where (DeviceProhibited.reasonRefused in "Medical Reason For Not Providing Treatment"
        or DeviceProhibited.reasonRefused in "Patient Declined")
      and DeviceProhibited.status in { 'active', 'completed', 'on-hold' }
```

A prohibition is a different statement from the rejection of a proposal, which uses TaskRejected against the positive request:

```cql
define "Intermittent Pneumatic Compression Devices Order Rejected for Reason":
  [USQualityCore.ServiceRequest: "Application of Intermittent Pneumatic Compression Devices"] DeviceOrdered
    with [USQualityCore.TaskRejected] TaskRejected
      such that TaskRejected.focus.references(DeviceOrdered)
        and TaskRejected.code ~ FHIRCommon."Fulfill"
        and (TaskRejected.statusReason in "Medical Reason For Not Providing Treatment"
          or TaskRejected.statusReason in "Patient Declined")
    where DeviceOrdered.status = 'active'
```

### Imaging Procedures

See [Imaging procedures](https://hl7.org/fhir/us/cql/en/patterns-service.html#imaging-procedures), which describes how an imaging procedure may be spread across ServiceRequest, Procedure, ImagingStudy, DiagnosticReport, Observation, Claim, and ExplanationOfBenefit, and why not every resource is present for every procedure.

For measures, the practical question is how far to look. If intent is only that the scan was performed, the order and the procedure may suffice:

```cql
define "CT Scan Order Completed":
  [USQualityCore.ServiceRequest: "Abdominal or Pelvic CT Scan with Contrast"] SR
    where SR.intent = 'order'
      and SR.status = 'completed'

define "CT Scan Procedure Performed":
  [USQualityCore.Procedure: "Abdominal or Pelvic CT Scan with Contrast"] ScanAbdPelvic
    where ScanAbdPelvic.status = 'completed'

define "CT Scan Performed":
  exists "CT Scan Order Completed"
    or exists "CT Scan Procedure Performed"
```

If intent is that the scan was also resulted, the diagnostic report is the next level of evidence:

```cql
define "CT Scan Diagnostic Report":
  [USQualityCore.DiagnosticReportNote: "Abdominal or Pelvic CT Scan with Contrast"] ReportNote
    where ReportNote.status in { 'final', 'amended', 'corrected', 'appended' }
```

An imaging study may be checked as well, related to the order or procedure by `procedureCode`, `procedureReference`, or `basedOn`:

```cql
define "CT Scan Imaging Study":
  [USQualityCore.ImagingStudy] IS
    where exists (IS.procedureCode C where C in "CT Scan Procedure Codes")
      or exists ("CT Scan Procedure Performed" P
        where IS.procedureReference.references(P)
      )
```

Measurements taken during the scan are represented as observations; see [Clinical Result](pattern_observations.html#clinical-result).

> NOTE: The US Quality Core ImagingStudy profile is marked with an asterisk in the [US Quality Core profile list](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/profiles.html), meaning it is not part of that guide's conformance expectations.

> NOTE: This topic summarizes discussion with the Orders &amp; Observations Work Group in this [FHIR Zulip chat](https://chat.fhir.org/#narrow/channel/179256-Orders-and-Observation-WG/topic/How.20to.20represent.20CT-Scan.3F/with/541254708). That discussion also suggests [ChargeItem](https://hl7.org/fhir/R4/chargeitem.html) may be useful as evidence that something was done, which needs follow-up.
