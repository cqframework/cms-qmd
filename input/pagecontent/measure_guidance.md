{:toc}

{: #CMS-dQM-Authoring-Guidance}
Guidance for measure developers related to CMS dQM development and maintenance will be provided in this section. 

###  CMS FHIR-based CQL Style Guide

This style guide covers how CQL used in CMS dQMs is written. It draws on two sources: the [Using CQL](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html) topic of the Quality Measure IG, which defines the conformance requirements a measure's CQL must meet, and the [Naming Best-Practices](https://hl7.org/fhir/us/cql/en/patterns-overall.html#naming-best-practices) in the US CQL IG, which are informative recommendations for naming declarations in shared libraries.

For guidance on authoring the query logic itself, see the [Patterns](patterns.html) topic. For conformance requirements on how CQL is packaged and referenced from a Measure, see [Measure Profiles](measure_profile.html).

#### Identifier conventions

The Quality Measure IG establishes the following conventions by identifier kind:

| Identifier kind | Convention | Requirement |
|----|----|----|
| [Library-level identifiers](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#library-level-identifiers)<br>(expression, function, and other declaration names) | Descriptive and meaningful; avoid abbreviations; initial case; may include spaces; quoted identifiers where necessary | SHOULD |
| [Data type names](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#data-type-names) | PascalCase, unless the model dictates otherwise | SHALL |
| &nbsp; | No quoted identifiers, unless the name in the model is not a valid identifier without quoting | SHALL NOT |
| [Element names](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#element-names) | camelCase, unless the model dictates otherwise | SHOULD |
| &nbsp; | No quoted identifiers, unless the name in the model is not a valid identifier without quoting | SHALL NOT |
| [Aliases](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#aliases-and-argument-names) | PascalCase; descriptive rather than abbreviated | SHOULD |
| [Argument names](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#aliases-and-argument-names) | camelCase; descriptive rather than abbreviated | SHOULD |
| &nbsp; | No quoted identifiers for aliases or arguments | SHALL NOT |
{: .grid}

An alias should also differ from every other identifier in scope, so that references within the query are unambiguous.

```cql
define "Encounters During Measurement Period":
  "Valid Encounters" QualifyingEncounter
    where QualifyingEncounter.period during "Measurement Period"

define function "ED Stay Time"(encounter Encounter):
  duration in minutes of encounter.period
```

`QualifyingEncounter` is the alias, `encounter` the argument name, `Encounter` the data type name, and `period` the element name.

> NOTE: Because data type names are not quoted, a retrieve is written `[USQualityCore.TaskRejected]` rather than `[USQualityCore."TaskRejected"]`. The type names in US Quality Core are all valid identifiers, so quoting is never required.

#### Naming declarations

Beyond casing and quoting, the name of a declaration should make clear what it returns without the reader having to open it. The US CQL IG recommends:

| Recommendation | Example |
|----|----|
| Say what kind of thing is returned, unless there can be no confusion | `Metformin RxNorm Code`, `Metformin AllergyIntolerances`, `Renal Dialysis Procedures` |
| Use a plural form when a set is returned | `Office Visit Encounters` |
| Use a singular form only for a singleton, and say how it was obtained from the set | `Most Recent Systolic Blood Pressure Quantity` |
| Include the unit when returning a quantity as a primitive | `Patient Age in Days` |
| Say how a list was filtered or processed | `Active Confirmed Conditions` |
| Use `All` when a list is unfiltered apart from its primary code | `All Allergies and Intolerances` |
| Begin non-fluent function names with a verb, to distinguish them from definitions | `GetEncounter`, `ComputeRiskScore`, `MapToInterval` |
{: .grid}

> NOTE: These are informative recommendations rather than conformance requirements, and the list is expected to grow. Feedback is welcome, both on the recommendations themselves and on how they are applied in CMS content.
