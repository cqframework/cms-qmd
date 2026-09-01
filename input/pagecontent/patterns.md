This section provides guidance and best-practice recommendations for authoring Clinical Quality Language (CQL) queries and logic to retrieve patient information from clinical systems using US Quality Core as the primary information model. [Clinical Quality Language(CQL)](https://cql.hl7.org/N1) is a high-level, domain-specific language focused on representing clinical logic and targeted at measure and decision support artifact authors.

For style and naming conventions used in measure logic, refer to the [Measure Guidance](measure_guidance.html) section of this guide.

For conformance requirements for measure specifications and logic, refer to the [Measure Profile](measure_profile.html) section of this guide.

Feedback on the patterns, guidance, or recommendations can be provided by submitting a [New Issue](https://github.com/cqframework/cms-qmd/issues/new) to this repository.

### Model Overview

[HL7 Fast Healthcare Interoperability Resources (FHIR)](https://hl7.org/fhir/R4) is a platform specification for exchanging healthcare data. FHIR defines a core information model that can be profiled for use in a variety of applications across the healthcare industry. These profiles are defined in Implementation Guides that provide constraints on the ways that FHIR resources can be used to support interoperability (i.e. the ability for different computer systems or software to correctly interpret the information being exchanged).

In the United States, the [US Core](https://hl7.org/fhir/us/core/STU6.1/) Implementation Guide defines a floor for that interoperability, enabling a broad range of clinical and administrative use cases. For quality improvement use cases, such as decision support and quality measurement, the [US Quality Core](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/) Implementation Guide extends US Core to support additional information used for quality improvement. For the most part, US Core covers the data required, but some use cases, such as documentation of events that did not occur, require additional profiles.

The information in this guide specifically uses the [v0.5.0](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/) version of US Quality Core, which depends on the [6.1.0](https://hl7.org/fhir/us/core/STU6.1/) version of USCore, both of which are based on the [R4](https://hl7.org/fhir/R4) version 4.0.1 of FHIR.

For guidance on authoring CQL against FHIR generally, and US Core and US Quality Core specifically &mdash; element considerations, accessing data, use of terminologies, and similar considerations &mdash; see the [FHIR Patterns](pattern_fhir.html) topic in this guide, containing the topics listed below.

| Pattern | Description |
|----|----|
| [Element cardinality](pattern_fhir.html#element-cardinality) | What cardinality does and does not tell an author about whether an element will be present. |
| [Must support elements](pattern_fhir.html#must-support-elements) | Restricting logic to elements an implementation is required to provide when it has them. |
| [Modifier elements](pattern_fhir.html#modifier-elements) | Elements whose value changes the meaning of the resource, including modifier extensions and `implicitRules`. |
| [Authoring against the US Quality Core model](pattern_fhir.html#authoring-against-the-us-quality-core-model) | Derived ModelInfo, the required version on the `using` declaration, and why extensions are reached through fluent functions. |
| [Accessing data](pattern_fhir.html#accessing-data) | The retrieve expression, model-qualified type names, and the status functions to apply when accessing a resource. |
| [Use of terminologies](pattern_fhir.html#use-of-terminologies) | When to use `=`, `~`, and `in`, the prohibition on string-based membership testing, and direct-reference code requirements. |
| [Primitives](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#primitives) | Whether a `.value` accessor is required; under derived ModelInfo elements carry FHIR types, with FHIRHelpers supplying the conversions. |
| [Choices](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#choices) | Elements that may take several types, such as `Condition.onset`, and the FHIRCommon interval helpers over them. |
| [Slices](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#slices) | Accessing sliced elements, such as blood pressure components through `systolic()` and `diastolic()`. |
| [Extensions](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#extensions) | Reading extension values where no fluent accessor is defined; see also the Extension Index in the [Refactored Index](refactored_index.html). |
| [Missing Information](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#missing-information) | Null propagation, the `is true` and `is not true` predicates, and the treatment of `unknown` status codes. |
| [Date, Time, and DateTime Values](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#date-time-and-datetime-values) | Being explicit about comparison precision, typically `day of`. |
| [Timezone and Timezone Offset Handling](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#timezone-and-timezone-offset-handling) | Day-boundary calculations such as "on hospital day 2". |
| [Time-Valued Quantities](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/patterns.html#time-valued-quantities) | Calendar durations (`year`, `month`) versus UCUM definite durations (`'a'`, `'mo'`). |
| [Overall Patterns](https://hl7.org/fhir/us/cql/en/patterns-overall.html) | The US CQL treatment of the same element considerations, plus its naming best-practices for shared library declarations. |
request. |
{: .grid}

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
11. [Claim](pattern_claim.html) - Billing information, including present on admission, principal diagnosis, and primary procedure
12. [Billing-related elements](pattern_billingrelated.html) - Choosing between the clinical, claim, and adjudicated representations of those elements
13. [Coverage](pattern_coverage.html) - Insurance coverage information, including payer for supplemental data reporting

Documentation of events that did not occur follows a distinct set of patterns that apply across all of the above; see [Negation Patterns](pattern_negation.html), containing the topics listed below:

| Pattern | Description |
|----|----|
| [Choosing a negation pattern](pattern_negation.html#choosing-a-negation-pattern) | Absence of evidence versus negation rationale, and when a negation profile is not the right choice. |
| [Use cases for negation rationale](pattern_negation.html#use-cases-for-negation-rationale) | The three use cases and the ten US Quality Core negation profiles that realize them. |
| [Extent of negation](pattern_negation.html#extent-of-negation) | Negating a specific activity versus an entire value set, through the `notDoneValueSet` extension. |
| [Working with doNotPerform](pattern_negation.html#working-with-donotperform) | Why `is not true` rather than an equality comparison, given the profiles that fix the element. |
| [Positive requests and rejected proposals](pattern_negation.html#positive-requests-and-rejected-proposals) | Excluding requests that carry a rejecting Task when looking for a positive 
{: .grid}

