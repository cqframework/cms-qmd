FHIR defines several medication-related resources, profiled for use in quality improvement artifacts by US Quality Core. For background see the [Medication module](https://hl7.org/fhir/R4/medications-module.html) in the base FHIR specification and the [Medication list guidance](https://hl7.org/fhir/us/core/STU6.1/medication-list.html) in US Core.

[Medication](https://hl7.org/fhir/us/cql/en/patterns-medication.html) in the US CQL implementation guide covers [active medications](https://hl7.org/fhir/us/cql/en/patterns-medication.html#active-medications) and [electronically transmitted prescriptions](https://hl7.org/fhir/us/cql/en/patterns-medication.html#electronically-transmitted-prescriptions). The patterns below are those specific to quality measurement, principally the positive and negated forms of ordering, administering, and dispensing; see the [Pattern Index](pattern_index.html) for the full list.

For MedicationRequest, MedicationAdministration, and MedicationDispense, see also [modifier elements](https://hl7.org/fhir/us/cql/en/patterns-medication.html#modifier-elements), [search parameters](https://hl7.org/fhir/us/cql/en/patterns-medication.html#search-parameters), and [cross-version considerations](https://hl7.org/fhir/us/cql/en/patterns-medication.html#cross-version-considerations) in that guide.

Two considerations apply throughout. `status`, `intent`, and `doNotPerform` are all modifier elements on MedicationRequest, and where a profile does not fix them the expression must account for every value they may take. And each medication profile is characterized by the `medication` element, which may be a code or a reference. The status, intent, and category functions used in the examples below are defined in the `MedicationCommon` library.

### Medication status, intent, and category

FHIRCommon defines status functions for observations, conditions, and allergies, but none for the medication resources, so medication logic has had to test `status` and `intent` with inline code lists. It defines category functions for MedicationRequest only, and only for some of its categories. The `MedicationCommon` library supplies the missing functions, following the same conventions FHIRCommon uses &mdash; an `is` prefixed predicate over a single resource, and an unprefixed form that filters a list:

| Resource | Functions |
|----|----|
| MedicationRequest status | `isActive()`, `isOnHold()`, `isCompleted()`, `isCancelled()`, `isStopped()`, `isDraft()`, `isEnteredInError()`, and the list forms `active()`, `onHold()`, `completed()` |
| MedicationRequest intent | `isOrder()`, `isPlan()`, `isProposal()`, and `isOrderIntent()` for any of the order intents, with the list form `orderIntent()` |
| MedicationRequest category | `hasCategory()`, `isInpatient()`, `isOutpatient()`, `isCommunity()`, `isDischarge()`, and the list forms `inpatient()`, `outpatient()`, `community()`, `discharge()` |
| MedicationRequest selection | `mostRecent()`, the request in a list with the latest `authoredOn` |
| MedicationAdministration status | `isCompleted()`, `isInProgress()`, `isOnHold()`, `isStopped()`, `isNotDone()`, `isEnteredInError()`, and the list form `completed()` |
| MedicationAdministration category | `hasCategory()`, `isInpatient()`, `isOutpatient()`, `isCommunity()`, and the list forms `inpatient()`, `outpatient()`, `community()` |
| MedicationDispense status | `isCompleted()`, `isInProgress()`, `isPreparation()`, `isOnHold()`, `isCancelled()`, `isStopped()`, `isDeclined()`, `isEnteredInError()`, and the list form `completed()` |
{: .grid}

`isOrderIntent()` covers `order`, `original-order`, `reflex-order`, `filler-order`, and `instance-order`, which is the set used by the `Active Medication Orders` expression in USCoreElements; it distinguishes an actual order from a proposal, plan, or option.

The category functions use the [medicationrequest-category](http://terminology.hl7.org/CodeSystem/medicationrequest-category) and [medication-admin-category](http://terminology.hl7.org/CodeSystem/medication-admin-category) code systems respectively. The two are distinct, so the MedicationRequest `inpatient` code does not match a MedicationAdministration category, and MedicationAdministration has no `discharge` category. `MedicationRequest.category` is a list, and a request has a category if any of its categories matches; `MedicationAdministration.category` has at most one value. `mostRecent()` sorts by `authoredOn`, so a request with no `authoredOn` is only returned if none of the requests has one.

> NOTE: MedicationCommon is released in MADiE, so measures can include it directly. Development happens in the [dqm-content-cms-2026](https://github.com/cqframework/dqm-content-cms-2026) repository, and the copy in this guide is a convenience copy. Nothing in it is US-specific, so the intent is to promote the library as a whole to the Using CQL with FHIR implementation guide ([FHIR-58912](https://jira.hl7.org/browse/FHIR-58912)), alongside FHIRCommon, as the home for medication-specific functions.

> NOTE: FHIRCommon 2.0.0 already defines `hasCategory()`, `isCommunity()`, `isDischarge()`, and `mostRecent()` for MedicationRequest. MedicationCommon defines them again, with the same signatures and meaning, so that the category functions for the medication resources are together; the FHIRCommon definitions would be removed as part of the promotion. Until then, a library that includes both resolves these calls to one of the two definitions without reporting an ambiguity, so either can be relied on.

> NOTE: No aggregate helpers are defined for the recurring `active` or `completed` and `in-progress`, `completed` or `on-hold` combinations, because naming them requires agreement on what they mean &mdash; for now the examples below compose the individual predicates.

### Medication ordered

US Quality Core defines the [US Quality Core MedicationRequest](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationrequest.html) profile to represent medication proposals, plans, and orders, as well as self-reported medications.

```cql
define "Antithrombotic Therapy at Discharge":
  [USQualityCore.MedicationRequest: "Antithrombotic Therapy Anticoagulant"] Antithrombotic
    without [USQualityCore.TaskRejected] TaskReject
      such that TaskReject.focus.references(Antithrombotic)
        and TaskReject.code ~ FHIRCommon."Fulfill"
    where (Antithrombotic.isCommunity() or Antithrombotic.isDischarge())
      and (Antithrombotic.isActive() or Antithrombotic.isCompleted())
      and Antithrombotic.isOrder()
```

Here `active` and `completed` identify active or filled prescriptions. The `without` clause is required because a rejected proposal may be recorded against any request; see [Positive requests and rejected proposals](pattern_negation.html#positive-requests-and-rejected-proposals). The profile fixes `doNotPerform` to false where present, so it need not be tested.

### Medication Not Ordered

US Quality Core defines the [US Quality Core Medication Not Requested](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationnotrequested.html) profile to document the reason for not ordering a medication or class of medications. The profile fixes `doNotPerform` to true, so that element need not be tested.

```cql
define "Antithrombotics Prohibited for Reason":
  [USQualityCore.MedicationNotRequested: "Antithrombotic Therapy Anticoagulant"] NoAntithrombotic
    where (NoAntithrombotic.reasonCode in "Medical Reason For Not Providing Treatment"
        or NoAntithrombotic.reasonCode in "Patient Declined")
      and (NoAntithrombotic.isCommunity() or NoAntithrombotic.isDischarge())
      and (NoAntithrombotic.isActive() or NoAntithrombotic.isCompleted())
      and NoAntithrombotic.isOrder()
```

A prohibition is a different statement from the rejection of a proposal, which uses TaskRejected against the positive request:

```cql
define "Antithrombotics Rejected for Reason":
  [USQualityCore.MedicationRequest: "Antithrombotic Therapy Anticoagulant"] Antithrombotic
    with [USQualityCore.TaskRejected] TaskRejected
      such that TaskRejected.focus.references(Antithrombotic)
        and TaskRejected.code ~ FHIRCommon."Fulfill"
        and (TaskRejected.statusReason in "Medical Reason For Not Providing Treatment"
          or TaskRejected.statusReason in "Patient Declined")
    where Antithrombotic.isActive()
```

Where measure intent accepts either, the two are unioned. A measure may extend the same pattern across the other negation profiles:

```cql
define "Exclusion Criteria":
  exists "Antithrombotics Prohibited for Reason"
    or exists "Antithrombotics Rejected for Reason"
    or exists "Antithrombotics Not Administered for Reason"
    or exists "Antithrombotics Not Dispensed for Reason"
```

### Medication administered

US Quality Core defines the [US Quality Core MedicationAdministration](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationadministration.html) profile to represent the administration of a medication to a patient. The profile does not fix `status`, so it must be tested.

```cql
define "Antithrombotic Therapy Administration":
  [USQualityCore.MedicationAdministration: "Antithrombotic Therapy Anticoagulant"] VTEMedication
    where VTEMedication.isCompleted()
      and VTEMedication.isInpatient()
```

`isInpatient()` here is the MedicationAdministration overload, which tests the `inpatient` code from the medication-admin-category code system. FHIRCommon's `"Inpatient"` code is from the medicationrequest-category code system, so comparing an administration's category to it does not match.

### Medication not administered

US Quality Core defines the [US Quality Core MedicationAdministration Not Done](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationadministrationnotdone.html) profile to document the reason an administration did not occur. The profile fixes `status` to `not-done`, so it need not be tested.

```cql
define "Antithrombotic Therapy Not Administered":
  [USQualityCore.MedicationAdministrationNotDone: "Antithrombotic Therapy Anticoagulant"] VTEMedication
    where VTEMedication.isInpatient()
      and (VTEMedication.reasonCode in "Medical Reason For Not Providing Treatment"
        or VTEMedication.reasonCode in "Patient Declined")
```

### Medication dispensed

US Quality Core defines the [US Quality Core MedicationDispense](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationdispense.html) profile to represent the fulfillment of a medication request, in either a hospital or a community pharmacy. The profile does not fix `status`.

```cql
define "Antithrombotic Medication Dispensed":
  [USQualityCore.MedicationDispense: "Antithrombotic Therapy Anticoagulant"] MedicationDispense
    where MedicationDispense.isInProgress()
      or MedicationDispense.isCompleted()
      or MedicationDispense.isOnHold()
```

The `in-progress`, `completed`, and `on-hold` statuses together retrieve any positive dispensing event.

### Medication not dispensed

US Quality Core defines the [US Quality Core MedicationDispense Declined](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-medicationdispensedeclined.html) profile to document the reason a dispense did not occur. The profile fixes `status` to `declined`.

```cql
define "Antithrombotic Medication Not Dispensed":
  [USQualityCore.MedicationDispenseDeclined: "Antithrombotic Therapy Anticoagulant"] MedicationDispense
    where MedicationDispense.statusReason in "Medical Reason For Not Providing Treatment"
      or MedicationDispense.statusReason in "Patient Declined"
```

### Medication in use

Beyond medications ordered at discharge or administered in hospital, a measure may need medications currently in use outside the hospital, including those not prescribed by a provider.

```cql
define "Antithrombotic Therapy Active":
  [USQualityCore.MedicationRequest: "Antithrombotic Therapy Anticoagulant"] Antithrombotic
    where Antithrombotic.isActive()
```

USCoreElements defines an equivalent `Active Medication Orders`, which additionally constrains `intent` to the order intents. Where a measure needs that narrowing, add `and Antithrombotic.isOrderIntent()`.

#### Self-administered OTCs

Over-the-counter medications the patient takes without a prescription are distinguished by category rather than by code.

```cql
define "Cold OTC At Home":
  [USQualityCore.MedicationRequest: "OIA_Cough_Cold_Meds"] CoughCold
    where CoughCold.isCommunity()
      and CoughCold.isActive()
      and CoughCold.isPlan()
```

`isCommunity()` reflects the MedicationRequest category indicating that the setting in which the medication is taken, or expected to be taken, is community.
