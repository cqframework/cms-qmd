This topic provides guidance for organizing logic to maximize the readability, maintainability, and implementability of measure logic. The discussion covers organizing logic into layers, when to declare an expression versus a fluent function, and what kinds of fluent functions are worth providing.

### Logic Layers

Split logic into four layers, each focusing on answering a specific question. This is a separation of concerns that enables each layer to be reviewed and understood by different audiences for different reasons:

| Layer | Answers | Contains | Must not contain |
|---|---|---|---|
| Concepts | What do we mean? | `valueset`, `code`, `codesystem`, accessor functions | Any expression |
| Elements | Which records count? | Retrieves plus status / intent / validity filters | Thresholds, encounters, populations |
| Inferences | What do the records mean? | Clinical classification, correlation, temporal scoping | Population criteria |
| Measure | Who is in which population? | Population criteria, SDEs | Anything else |

#### Concepts Layer

The Concepts layer is focused on identifying and supporting access to the semantics used in artifact logic, i.e. What do we mean? The Concepts layer is identified separately to support:

* Review and maintenance: Keeping the terminology declarations used throughout the logic in a centrally managed location facilitates terminology review and maintenance
* Depencency management: Dependencies can be managed cleanly, always pointing towards terminology, and concepts depends on nothing

##### Common Libraries

This layer also includes accessor functions defined to facilitate accessing elements of FHIR resources that make use of the concepts, as well as facilitating extension and slice element access. When a library includes concepts and accessors, it is often referred to as a `Common` library (e.g. `FHIRCommon`, `USCoreCommon`, `USQualityCoreCommon`). The key aspect of a Common library is that it should not include any data access (i.e. retrieve expressions).

In addition, multiple common libraries may be created to facilitate sharing as appropriate for organizing the logic used in artifacts. For example, logic may be organized around particular topic areas so that logic needed for artifacts related to a particular topic can be shared, without requiring that logic to be shared everywhere. Depending on the size of complexity of a set of artifacts, multiple common libraries can be used to organized and share the logic. In addition, libraries may be refactored as needed when sharing patterns are recognized as the content develops.

#### Elements Layer

The Elements layer is focused on identifying context-independent data elements (i.e. building blocks) of data, answering the question Which records count? These elements are then used to construct inferences and artifact logic by subsequent layers.

The elements layer focuses on data retrieves as well as status, intent, and validity filters. This layer should not be concerned with calculation, inferences, or other logic, its focus is to ensure all and only the data needed for calculation is available, not to establish the calculation itself.

Keeping this layer separate has several advantages:

* Simplifies the expression of downstream logic by allowing it to be expressed independently of status, intent, or validity checks.
* Maximizes re-use of data elements; many different inferences can be performed with the same building blocks
* Facilitates data requirements analysis; by keeping all retrieves in the elements layer, implementers can more easily access, analyze, and understand the data requirements of the logic

##### Configuration Libraries

As a special case of data elements, artifacts may need configuration to support usage in different contexts. For example, a measure may have different exclusion criteria based on the clinical setting in which it is used, or an artifact may have different thresholds for making determinations such as a1C control As well, artifacts may require additional information such as ingredient strengths for medications, or species information for organisms, that is not part of the clinical or administrative record for a patient, but is required to calculate the measure. Configuration libraries can be used to keep these and similar configuration data elements separate from the rest of the data elements used in an artifact.

#### Inferences Layer

The Inferences layer is focused on using the building blocks available in the Elements layer to build up clinical inferences, such as clinical classification, correlation, and establishing temporal relationships. This layer answers the question What do the records mean?

#### Measure Layer

The Measure layer is focused on the actual expressions referenced by the measure, i.e. it is all and only the population, stratifier, and supplemental data criteria.

The population criteria are the measure's contract. If they are readable at a glance, a clinical reviewer can check the measure's *shape* without reading any computation.

Care should be taken to avoid a definition name that includes the logic, such as
`"Encounter with Second Hypertensive Reading SBP Greater than or Equal to 140 OR DBP Greater than or Equal to 90 and Interventions"`.
That name exists because there was no Inferences layer to hold the concept, so
the concept had to live in the identifier. With the inferences layer it becomes
`"Encounter with Stage 2 Reading and Follow Up"`, and the thresholds live in a
named classifier where they can be reviewed on their own.

### Choosing the Layer

The following guidelines can help establish which layer a given expression should live in:

1. If it contains a retrieve, the retrieve should be in an _Element_ declaration
2. If it contains a status, intent, or similar resource-specific validity check, it should be included in the _Element_ declaration
3. If it contains clinical classification logic, or references context such as the measurement period, it should be in an _Inference_ declaration
4. If it contains any of the above constructs, it should _not_ be in a Measure/Criteria definition

### Library Organization

Although these layers provide a natural way to organize artifact logic into libraries, it is not necessarily required; logic can still be separated into layers within the same library.

When this is done, it can be helpful to group expressions from different layers into the same area of the library source.

The important aspect of the layering is to ensure that references to declarations are in the right direction. Higher layers always reference lower layers, never the other way around:

```
Concepts
    ^
  Elements
      ^
    Inferences
        ^
      Criteria
```

### Fluent Function Guidance

Guidance and best-practices for when and how to define fluent functions

#### Expression Declaration versus Fluent Function

Default to an **expression declaration**. Reach for a function only when you
need parameterization.

**Declare an expression when** the thing has a single meaning in this measure:
a retrieve, a filtered set, a named clinical concept. Expressions are cached
per evaluation, they appear in data requirements, and they are addressable from
the measure resource. `"Blood Pressure Screening Encounters"` is an expression
because there is exactly one such set.

**Declare a function when** the same shape is needed against different inputs.
`lastBloodPressureDuring(encounter)` is a function because it is evaluated once
per encounter. Note that this is the *only* reason: a function taking no
meaningful parameter is an expression that has lost its caching.

**Make it fluent when** the first parameter is the semantic subject and the
call reads as a phrase about it: `Reading.isStage2()`, `Orders.wasOrdered()`.
Do not make it fluent when the first parameter is a modifier — `Without(kind, X)`
and `BeforeStartOf(len, anchor)` read backwards as fluent calls, so they stay
ordinary functions.

#### The Admission Test for a Fluent Function

> **Can CQL already express this?** If yes, do not write the function.

A helper that re-implements a language feature is not a convenience; it is a second, weaker way to say the same thing.

**Worked example: temporal relations fail the test.** CQL's timing syntax is a
generative grammar — relation x precision x offset x boundary — composing into
hundreds of expressible relationships. Any fixed set of named predicates
enumerates a fraction of it, freezing one precision and one boundary each:

```cql
Reading.isSameDay(Enc)                                    // one point

Reading.relevantInterval() same day as Enc.relevantInterval()
Reading.relevantInterval() ends 1 year or less before or on
  start of Enc.relevantInterval()                         // no function exists
```

**The evidence.** Not one fluent function in FHIRCommon wraps a timing phrase.
Every temporal helper it ships is an interval *accessor*: `toInterval`,
`prevalenceInterval`, `abatementInterval`, `earliest`, `latest`. That is a
deliberate stance, not an oversight.

**Status and code rules pass the test.** CQL has no syntax for "status and
intent together indicate an order", so `isOrdered()` is appropriate as a fluent function.

#### What to Provide Instead: Accessors

When a pattern fails the admission test, ask what the helper was *actually*
doing. For temporal predicates the answer was never the relation — it was the
resource-specific question of which element carries the time and how its choice
type is normalized.

Instead, provide one accessor per resource type, and let the CQL timing phrase do the comparison:

```cql
define fluent function relevantInterval(O Observation): O.effective.toInterval()
define fluent function relevantInterval(P Procedure):   P.performed.toInterval()
define fluent function relevantInterval(E Encounter):   E.period.toInterval()
define fluent function authorDateTime(S ServiceRequest): S.authoredOn
```

Two accessors, not one. Relevant time and authoring time are different facts —
QDM has drawn this distinction all along as `relevantPeriod` / `relevantDatetime`
versus `authorDatetime`. A ServiceRequest's `authoredOn` is when the order was
written, which is not when anything happened to the patient.

**Accessors also make hidden decisions visible.** Comparing an event to an
encounter interval-to-interval, but a request's authoring instant to the
*start* of the encounter, is a real semantic difference. Inside an
`isSameDay()` helper it is invisible. Written as
`authorDateTime() same day as start of relevantInterval()` it is legible at the
call site, where a reviewer can agree or disagree with it.

#### Item Level, List Level, or Both

FHIRCommon's convention, and the right default:

```cql
condition.isVerified()          // item -> Boolean   ("is" prefix signals Boolean)
conditions.verified()           // list -> List      (bare verb signals filter)
```

Let the **item form carry the logic** and derive the list form from it.
FHIRCommon itself duplicates the predicate between `verified` and `isVerified`;
do not copy that.

```cql
define fluent function isVerified(condition Condition): /* the logic */

define fluent function verified(conditions List<Condition>):
  conditions C where C.isVerified()
```

The item form is the important half. A Boolean predicate composes anywhere —
`where`, `such that`, `return`, `sort`. A list filter can only ever be a
pipeline stage. Correlating a record with a specific encounter requires
`such that Order.isSameDay(Enc)`, and the absence of item-level predicates is a
large part of why a list-only library cannot express encounter-scoped measures
at all.

The ecosystem leans item-level: FHIRCommon 62 item to 26 list, USCoreElements
25 to 1.

