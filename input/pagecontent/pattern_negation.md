Negation in these patterns follows the guidance in [Negation in FHIR](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#negation-in-fhir) from the Using CQL With FHIR IG, realized by the profiles described in [US Quality Core Negation](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/negation.html). This section summarizes how those two topics apply to the patterns on the following pages; refer to them for the underlying rationale and for complete examples.

### Choosing a negation pattern

Before reaching for a negation profile, determine whether the measure intent depends on *why* something did not happen. There are two patterns:

* **Absence of evidence** — the logic only needs to establish that an activity is not present. This is expressed with `not exists` over the *positive* profile; no negation profile is involved.
* **Negation rationale** — the logic requires documentation that the activity did not occur *together with a reason*. Only this case calls for a US Quality Core negation profile.

> NOTE: If a reason is not part of the measure intent, use absence of evidence. Documentation of an event not occurring is only meaningful for clinical reasoning when it is accompanied by a reason.

### Use cases for negation rationale

When a reason is required, negation statements cover three use cases. US Quality Core defines ten negation profiles, each parallel to a positive profile:

| Use case | What is documented | US Quality Core profiles |
|----|----|----|
| **Negation rationale** &mdash; an event did not occur | *I did not administer aspirin for a reason*<br>*I did not give an immunization for a reason* | CommunicationNotDone\*, ImmunizationNotDone, MedicationAdministrationNotDone, MedicationDispenseDeclined, ObservationCancelled, ProcedureNotDone |
| **Prohibited activities** &mdash; an activity was requested *not* to be performed | *I did not order aspirin because the patient is allergic*<br>*I did not order mammography because the patient has had bilateral mastectomies* | DeviceNotRequested, MedicationNotRequested, ServiceNotRequested |
| **Rejected requests** &mdash; a proposal to perform an activity was rejected | *I reject the proposal to order aspirin because the patient is allergic*<br>*I reject the proposal to refer to an ophthalmologist because the patient refuses* | TaskRejected, with `focus` referencing a DeviceRequest, MedicationRequest, or ServiceRequest |
{: .grid}

\* CommunicationNotDone is not part of the conformance expectations of US Quality Core because it contains no USCDI+ Quality flagged data elements.

Each negation profile records at least: what activity did not occur, an explicit indication that it did not occur (`doNotPerform`, or a `status` of `not-done`, `declined`, `cancelled`, or `rejected`), when the clinician recorded the reason, and the reason itself, bound to the [US Quality Core Negation Reason](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/ValueSet-us-quality-core-negation-reason.html) value set. Because the underlying FHIR resources represent these differently, each profile uses its own combination of constraints and extensions &mdash; see [Using US Quality Core Negation Profiles](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/negation.html#using-us-quality-core-negation-profiles).

> NOTE: ObservationCancelled SHOULD be used to represent negation for *all* of the specific observation profiles, including the US Core vital signs, smoking status, sexual orientation, and pregnancy profiles, as well as the US Quality Core observation profiles.

### Extent of negation

Independently of which use case applies, a negation statement may be made at either of two extents:

* **A specific activity** &mdash; the activity element carries a code, drawn from the codes the measure expects.
* **An entire value set** &mdash; the activity element carries the `notDoneValueSet` extension referencing a value set, stating that *none* of its members were performed.

All ten negation profiles support both, so logic that only handles one extent will miss conforming data. Where the terminology can be supplied on the retrieve, the fluent accessors handle both forms; otherwise, filter outside the retrieve using the accessor for the activity element (`medication()`, `code()`, `topic()`, `vaccineCode()`) as shown in the US Quality Core negation topic, or union the two expressions.

> NOTE: The Using CQL With FHIR IG describes this same dimension as [Activity Extent](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#activity-extent) and uses the general-purpose `codeOptions` extension. US Quality Core uses `notDoneValueSet` for the negated case.

> NOTE: The two extents must not contradict each other. An assertion that no medication in a value set was administered should not appear alongside an administration of a member of that same value set.

### Working with doNotPerform

The prohibited-activity profiles constrain `doNotPerform` to a fixed value of `true` with a cardinality of 1..1, so expressions using DeviceNotRequested, MedicationNotRequested, or ServiceNotRequested do not need to test it. Their positive counterparts &mdash; DeviceRequest, MedicationRequest, and ServiceRequest &mdash; fix it to `false` at 0..1, meaning a conforming instance may omit the element entirely.

For that reason, logic that tests `doNotPerform` against an unconstrained request should use the `is not true` predicate rather than an equality comparison, so that a missing element and an explicit `false` are treated alike:

```cql
[MedicationRequest: "Antithrombotic Therapy"] MR
  where MR.doNotPerform is not true
```

See [Missing Information](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#missing-information) for the general treatment of absent values.

### Positive requests and rejected proposals

Because a rejecting Task may be recorded against any request, logic that looks for a positive request must also establish that the request was not rejected:

```cql
define "Antithrombotic Therapy Requested":
  [MedicationRequest: "Antithrombotic Therapy"] MR
    without [USQualityCore.TaskRejected] T
      such that T.focus.references(MR) and T.code ~ FHIRCommon."Fulfill"
    where MR.status = 'active'
      and MR.doNotPerform is not true
```

Conversely, where a measure accepts either a documented prohibition or a rejected proposal, the two expressions are unioned. The pages that follow illustrate both forms for each resource type.
