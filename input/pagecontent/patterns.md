This section provides guidance and best-practice recommendations for authoring CQL queries and logic to retrieve patient information from clinical systems using US Quality Core as the primary information model.

For style and naming conventions, refer to the [Measure Guidance](measure_guidance.html) section of this guide.

For conformance requirements for measure specifications, refer to the [Measure Profile](measure_profile.html) section of this guide.

Feedback on the patterns, guidance or recommendations can be provided by submitting a [New Issue](https://github.com/cqframework/cms-qmd/issues/new) to this repository.

### Model Overview

[HL7 Fast Healthcare Interoperability Resources (FHIR)](https://hl7.org/fhir/R4) is a platform specification for exchanging healthcare data. FHIR defines a core information model that can be profiled for use in a variety of applications across the healthcare industry. These profiles are defined in Implementation Guides that provide constraints on the ways that FHIR resources can be used to support interoperability (i.e. the ability for different computer systems or software to correctly interpret the information being exchanged).

In the United States, the [US Core](https://hl7.org/fhir/us/core/STU6.1/) Implementation Guide defines a floor for that interoperability, enabling a broad range of clinical and administrative use cases. For quality improvement use cases, such as decision support and quality measurement, the [US Quality Core](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/) Implementation Guide extends US Core to support additional information used for quality improvement. For the most part, US Core covers the data required, but some use cases, such as documentation of events that did not occur, require additional profiles.

The information in this guide specifically uses the [v0.5.0](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/) version of US Quality Core, which depends on the [6.1.0](https://hl7.org/fhir/us/core/STU6.1/) version of USCore, both of which are based on the [R4](https://hl7.org/fhir/R4) version 4.0.1 of FHIR.

[Clinical Quality Language(CQL)](https://cql.hl7.org/N1) is a high-level, domain-specific language focused on representing clinical logic and targeted at measure and decision support artifact authors.

### Pattern Overview

See the [Pattern Index](pattern_index.html) for a complete listing of all available data elements and patterns in this guide, as well as the US CQL and Using CQL implementation guides.

For guidance on refactoring QICore-based measures to use US Quality Core, refer to the [US Quality Core Update Process](usqc_update_process.html) page, as well as the [Refactored Index](refactored_index.html).

The following pages provide authoring patterns for each type of information:

1. [Patient](pattern_patient.html) - Representation of patient demographic and basic characteristics
2. [Encounters](pattern_encounters.html) - Encounters between a patient and healthcare providers, typically taking place at a facility or virtually
3. [Observations](pattern_observations.html) - Facts about the patient such as lab results, vital signs, social history, etc.
4. [Conditions](pattern_conditions.html) - Conditions the patient has (or does not have)
5. [Medications](pattern_medications.html) - Information related to medications the patient is prescribed and/or using
6. [Procedures](pattern_procedures.html) - Information related to procedures ordered and/or performed for the patient
7. [Devices](pattern_devices.html) - Information related to devices the patient is using and/or has been prescribed
8. [Allergies](pattern_allergies.html) - Allergies and intolerances the patient has (or does not have)
9. [Immunizations](pattern_immunizations.html) - Information related to immunizations the patient has received or been recommended
10. [Communication](pattern_communication.html) - Information related to communications with or about the patient

### Using CQL with FHIR

Whether logic should make use of a particular element of a profile depends wholly on the intent of the measure or rule. Nonetheless, some general guidelines should be followed to ensure correct expression and evaluation of CQL. The considerations most often encountered in these patterns are summarized here; see [Element Considerations](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#element-considerations) in the Using CQL With FHIR IG for the complete treatment. The guidance in that IG is informative. Where a requirement is normative for quality measures, it is stated in the [Using CQL](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html) topic of the Quality Measure IG, which carries the conformance requirements; those are called out below where they apply.

#### Element cardinality

Every element in a FHIR resource or profile has a cardinality that determines whether and how many values may appear in that element. Cardinality is expressed as a range, typically from 0 or 1 to 1 or `*`. A cardinality of `0..1` means the element is optional, `1..1` means the element is required, `0..*` means it may appear any number of times, and `1..*` means it must appear at least once, but may appear multiple times. Although other cardinalities are possible, those described above are the most common.

> NOTE: Cardinality determines whether and how many values may appear for a given element, but the fact that an element is required (e.g. `1..1`) does not mean that expressions using that profile must reference that element.

#### Must support elements

Elements in FHIR profiles may be marked *must support*, meaning that implementations are required to provide a value for the element if one is present in the system. Expressions should only make use of elements that are marked must support, or that otherwise have a reasonable expectation of being present. The specific meaning of must support is established by each implementation guide &mdash; see the [MustSupport Flag](https://hl7.org/fhir/us/core/STU6.1/must-support.html) topic in US Core and [Must Support](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/must-support.html) in US Quality Core.

#### Modifier elements

Some elements in FHIR profiles are designated as modifier elements, meaning that the value of the element may change the overall meaning of the resource. For example, the `clinicalStatus` element of a Condition is a modifier element because its value determines whether the Condition represents the presence or absence of a condition. As a result, authors must carefully consider, for each modifier element, whether its possible values could affect the intended meaning of the expression.

The `status` element of an event or request is the modifier element most often encountered in these patterns. Where a profile does not constrain `status`, the expression must account for every value it may take. US Quality Core provides value sets for this purpose, such as [Non-Negative Event Status](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/ValueSet-us-quality-core-non-negative-event-status.html) and its per-resource counterparts, which exclude the statuses used by the negation profiles.

Extensions may likewise be modifier extensions, and a resource carrying a modifier extension that is not understood cannot be processed. The `implicitRules` element is a modifier element that applies to every FHIR resource. These checks may be handled by the evaluation environment, or performed in CQL using the `checkModifiers()` function defined in FHIRHelpers.

To summarize,

* **Cardinality** determines whether data will be present at all.
* **Must support** determines whether the element can reasonably be expected to be present.
* **Modifier elements** must always be evaluated for how their possible values might influence the meaning or outcome of an expression.

#### Authoring against the US Quality Core model

US Quality Core publishes [derived ModelInfo](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/modelinfo.html), so profiles are presented as types derived from their US Core and FHIR base definitions:

```cql
    using USQualityCore version '0.5.0'
```

The version is not optional. For quality measures, all CQL SHALL use FHIR-based data models, and the model declaration SHALL include a version &mdash; see [CQL Data Model](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#data-model) in the Quality Measure IG.

This differs from the [profile-informed authoring](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#profile-informed-authoring) approach used by QI-Core, which flattened profiles so that slices and extensions appeared as ordinary elements. Under derived ModelInfo, extension-backed data is reached through fluent functions rather than named elements &mdash; `Patient.race()` rather than `Patient.race`. For the full list of affected elements and the function to use for each, see the Extension Index in the [Refactored Index](refactored_index.html).

> NOTE: The Patterns page published in US Quality Core 0.5.0 describes primitives, extensions, and choice types in terms of profile-informed authoring, which does not match the derived ModelInfo that guide ships. It should not be referenced; use the guidance referred to here instead. That page has been removed for the next ballot publication of US Quality Core, and no further publication of the 0.5.0 branch is expected.

#### Accessing data

Data is accessed with the CQL [Retrieve](https://cql.hl7.org/02-authorsguide.html#retrieve) expression, naming the type to be retrieved and, optionally, a terminology filter:

```cql
    define "All Allergies and Intolerances":
      [USQualityCore.AllergyIntolerance]

    define "Antithrombotics Administered":
      [USQualityCore.MedicationAdministration: "Antithrombotic Therapy"]
```

Under derived ModelInfo, the retrievable type name is the computable name of the profile with the model prefix removed, so the `USQualityCoreMedicationAdministration` profile is retrieved as `MedicationAdministration`. US Quality Core 0.5.0 defines 57 retrievable types on this basis. Qualifying the type with the model name is optional but recommended, both because it makes the source of the type explicit and because some patterns need to reach types the guide does not profile, such as `[USCore.SmokingStatusProfile]`.

As described under [Modifier elements](#modifier-elements), status elements must be considered whenever data is accessed. FHIRCommon provides fluent functions for the common cases, in both a singleton predicate form and a list-filtering form:

```cql
    define "Active Confirmed Allergies and Intolerances":
      "All Allergies and Intolerances".active().confirmed()
```

See [Accessing Data](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#accessing-data) for further discussion.

#### Use of terminologies

FHIR terminology-valued elements are compared in CQL using the equal (`=`), equivalent (`~`), and `in` operators. As a general rule,

* Use the equivalent operator (`~`) when comparing to a direct-reference code.
* Use the `in` operator when comparing to a value set.
* Use the equal operator (`=`) only with code-valued elements that have a required binding.

Note that `contains` has no terminological overload in the current version of CQL and should not be used with terminology-valued elements; use `includesCode()` from [FHIRCommon](https://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) instead.

For quality measures, the first two rules above are backed by conformance requirements rather than style preferences:

* Value set membership testing SHOULD use the CQL terminology membership operator (`in`), rather than computing over the list of codes a value set expands to &mdash; see [Value Set Expansion](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#value-set-expansion).
* String-based membership testing SHOULD NOT be used &mdash; see [String-based Membership Testing](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#string-based-membership-testing). Given a value set named "Administrative Gender", the expression `'female' in "Administrative Gender"` is not conformant, because no code system is associated with the string `'female'`.

Direct-reference codes are declared with the code's logical identifier from the code system. That identifier SHALL NOT be a URI, and SHOULD be a code drawn from the code system &mdash; see [Codes](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#codes):

```cql
    code "Venous foot pump, device (physical object)": '442023007' from "SNOMED CT"
```

#### Further considerations

The following topics in the Using CQL With FHIR IG apply throughout these patterns and are not repeated here:

| Topic | Applies to |
|----|----|
| [Primitives](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#primitives) | Whether a `.value` accessor is required; under derived ModelInfo elements carry FHIR types (`Patient.birthDate` is `FHIR.date`), with FHIRHelpers supplying the conversions |
| [Choices](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#choices) | Elements that may take several types, such as `Condition.onset`; the `toInterval()`, `abatementInterval()`, `prevalenceInterval()`, `earliest()`, and `latest()` helpers in FHIRCommon |
| [Slices](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#slices) | Accessing sliced elements, such as blood pressure components via the `systolic()` and `diastolic()` fluent functions in USCoreCommon |
| [Extensions](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#extensions) | Reading extension values where no fluent accessor is defined; see also the Extension Index in the [Refactored Index](refactored_index.html) |
| [Missing Information](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#missing-information) | Null propagation, the `is true`/`is not true` predicates, and the treatment of `unknown` status codes |
| [Date, Time, and DateTime Values](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#date-time-and-datetime-values) | Being explicit about comparison precision, typically `day of` |
| [Timezone and Timezone Offset Handling](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#timezone-and-timezone-offset-handling) | Day-boundary calculations such as "on hospital day 2" |
| [Time-Valued Quantities](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#time-valued-quantities) | Calendar durations (`year`, `month`) versus UCUM definite durations (`'a'`, `'mo'`) |
| [Use of Terminologies](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#use-of-terminologies) | Comparing `code`, `Coding`, and `CodeableConcept` elements, including multi-cardinality and direct-reference code cases |

### Negation Patterns

Negation in these patterns follows the guidance in [Negation in FHIR](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#negation-in-fhir) from the Using CQL With FHIR IG, realized by the profiles described in [US Quality Core Negation](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/negation.html). This section summarizes how those two topics apply to the patterns on the following pages; refer to them for the underlying rationale and for complete examples.

#### Choosing a negation pattern

Before reaching for a negation profile, determine whether the measure intent depends on *why* something did not happen. There are two patterns:

* **Absence of evidence** — the logic only needs to establish that an activity is not present. This is expressed with `not exists` over the *positive* profile; no negation profile is involved.
* **Negation rationale** — the logic requires documentation that the activity did not occur *together with a reason*. Only this case calls for a US Quality Core negation profile.

> NOTE: If a reason is not part of the measure intent, use absence of evidence. Documentation of an event not occurring is only meaningful for clinical reasoning when it is accompanied by a reason.

#### Use cases for negation rationale

When a reason is required, negation statements cover three use cases. US Quality Core defines ten negation profiles, each parallel to a positive profile:

| Use case | What is documented | US Quality Core profiles |
|----|----|----|
| **Negation rationale** &mdash; an event did not occur | *I did not administer aspirin for a reason*<br>*I did not give an immunization for a reason* | CommunicationNotDone\*, ImmunizationNotDone, MedicationAdministrationNotDone, MedicationDispenseDeclined, ObservationCancelled, ProcedureNotDone |
| **Prohibited activities** &mdash; an activity was requested *not* to be performed | *I did not order aspirin because the patient is allergic*<br>*I did not order mammography because the patient has had bilateral mastectomies* | DeviceNotRequested, MedicationNotRequested, ServiceNotRequested |
| **Rejected requests** &mdash; a proposal to perform an activity was rejected | *I reject the proposal to order aspirin because the patient is allergic*<br>*I reject the proposal to refer to an ophthalmologist because the patient refuses* | TaskRejected, with `focus` referencing a DeviceRequest, MedicationRequest, or ServiceRequest |

\* CommunicationNotDone is not part of the conformance expectations of US Quality Core because it contains no USCDI+ Quality flagged data elements.

Each negation profile records at least: what activity did not occur, an explicit indication that it did not occur (`doNotPerform`, or a `status` of `not-done`, `declined`, `cancelled`, or `rejected`), when the clinician recorded the reason, and the reason itself, bound to the [US Quality Core Negation Reason](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/ValueSet-us-quality-core-negation-reason.html) value set. Because the underlying FHIR resources represent these differently, each profile uses its own combination of constraints and extensions &mdash; see [Using US Quality Core Negation Profiles](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/negation.html#using-us-quality-core-negation-profiles).

> NOTE: ObservationCancelled SHOULD be used to represent negation for *all* of the specific observation profiles, including the US Core vital signs, smoking status, sexual orientation, and pregnancy profiles, as well as the US Quality Core observation profiles.

#### Extent of negation

Independently of which use case applies, a negation statement may be made at either of two extents:

* **A specific activity** &mdash; the activity element carries a code, drawn from the codes the measure expects.
* **An entire value set** &mdash; the activity element carries the `notDoneValueSet` extension referencing a value set, stating that *none* of its members were performed.

All ten negation profiles support both, so logic that only handles one extent will miss conforming data. Where the terminology can be supplied on the retrieve, the fluent accessors handle both forms; otherwise, filter outside the retrieve using the accessor for the activity element (`medication()`, `code()`, `topic()`, `vaccineCode()`) as shown in the US Quality Core negation topic, or union the two expressions.

> NOTE: The Using CQL With FHIR IG describes this same dimension as [Activity Extent](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#activity-extent) and uses the general-purpose `codeOptions` extension. US Quality Core uses `notDoneValueSet` for the negated case.

> NOTE: The two extents must not contradict each other. An assertion that no medication in a value set was administered should not appear alongside an administration of a member of that same value set.

#### Working with doNotPerform

The prohibited-activity profiles constrain `doNotPerform` to a fixed value of `true` with a cardinality of 1..1, so expressions using DeviceNotRequested, MedicationNotRequested, or ServiceNotRequested do not need to test it. Their positive counterparts &mdash; DeviceRequest, MedicationRequest, and ServiceRequest &mdash; fix it to `false` at 0..1, meaning a conforming instance may omit the element entirely.

For that reason, logic that tests `doNotPerform` against an unconstrained request should use the `is not true` predicate rather than an equality comparison, so that a missing element and an explicit `false` are treated alike:

```cql
[MedicationRequest: "Antithrombotic Therapy"] MR
  where MR.doNotPerform is not true
```

See [Missing Information](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#missing-information) for the general treatment of absent values.

#### Positive requests and rejected proposals

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
