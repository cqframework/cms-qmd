FHIR represents both problem list items and encounter diagnoses with the [Condition](https://hl7.org/fhir/R4/condition.html) resource, distinguished by the `category` element. US Quality Core profiles them separately as [Condition Problems and Health Concerns](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-condition-problems-health-concerns.html) and [Condition Encounter Diagnosis](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-condition-encounter-diagnosis.html).

Authoring patterns for conditions are documented in [Condition](https://hl7.org/fhir/us/cql/en/patterns-condition.html) in the US CQL implementation guide, covering category, active and verified conditions, historical conditions, onset and abatement, and evidence of a diagnosis during an encounter. This page records only what differs for quality measurement; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

For Condition, see also [modifier elements](https://hl7.org/fhir/us/cql/en/patterns-condition.html#modifier-elements), [search parameters](https://hl7.org/fhir/us/cql/en/patterns-condition.html#search-parameters), and [cross-version considerations](https://hl7.org/fhir/us/cql/en/patterns-condition.html#cross-version-considerations) in that guide.

> NOTE: Retrieves in the US CQL patterns are written against the US Core model, and the shared definitions in [USCoreElements](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) &mdash; including `All Conditions`, which unions problem list items, health concerns, and encounter diagnoses &mdash; retrieve US Core-conformant instances. Measures requiring US Quality Core conformance retrieve against US Quality Core directly, and therefore union the two profiles themselves.

### Active conditions

See [Active conditions](https://hl7.org/fhir/us/cql/en/patterns-condition.html#active-conditions) and [Category](https://hl7.org/fhir/us/cql/en/patterns-condition.html#category).

Quality measures are evaluated retrospectively, so `isActive()` &mdash; which tests the *current* `clinicalStatus` &mdash; should not be used to establish that a condition was active during the measurement period. Use [prevalencePeriod()](#onset-abatement-and-prevalence-period) or [relevantPeriod()](#diagnosis-date-and-relevant-period) instead.

The category functions are `isProblemListItem()` and `isEncounterDiagnosis()` in [FHIRCommon](https://hl7.org/fhir/uv/cql/Library-FHIRCommon.html), and `isHealthConcern()` in [USCoreCommon](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html). Where measure intent covers a condition regardless of how it was recorded, the category check may be omitted.

### Verified Conditions

See [Verified conditions](https://hl7.org/fhir/us/cql/en/patterns-condition.html#verified-conditions).

Measure logic should use the verification-status functions defined in FHIRCommon &mdash; `isVerified()` and `verified()`, along with `isConfirmed()`, `isUnconfirmed()`, `isProvisional()`, `isDifferential()`, `isRefuted()`, and their list-valued forms &mdash; rather than re-declaring them locally. QICoreCommon's `verified()` is deprecated in favor of the FHIRCommon function; see the [Refactored Index](refactored_index.html).

### Encounters with a condition

See [Evidence of diagnosis during an encounter](https://hl7.org/fhir/us/cql/en/patterns-condition.html#evidence-of-diagnosis-during-an-encounter).

In addition to encounter diagnoses, an encounter may specify additional information related to diagnoses, including reason for visit. See the [Encounter Patterns](pattern_encounters.html) for more information.

### History of a condition

See [Historical conditions](https://hl7.org/fhir/us/cql/en/patterns-condition.html#historical-conditions).

Because US Quality Core profiles problem list items and encounter diagnoses separately, a history query can reference the underlying FHIR Condition instead of retrieving both:

```cql
define "History Of Diabetes":
  [FHIR.Condition: "Diabetes"] C
    where C.isVerified() // To ensure we are not looking at refuted
```

Where measure intent calls for additional filtering, the category may be used to separate filtering criteria &mdash; `verificationStatus` for problem list items and health concerns, and the status of the associated encounter for encounter diagnoses.

As with evidence of diagnosis during an encounter, considerations for history of a condition include:

1. **start timing** - What the look-back period is and how the timing of the diagnosis relates to it
2. **status vs prevalence** - Whether to use the _current status_ element as opposed to calculating the _prevalence interval_, especially for conditions that are unlikely to resolve
3. **verification** - Whether and how stringently to test the verification status of the condition
4. **onset vs asserted vs recorded** - Whether and how to determine the _starting point_ for consideration (see [Diagnosis date and relevant period](#diagnosis-date-and-relevant-period))

Note also that if a measure has access to claim information, claims may be used to search for history of a condition as well. See [Billing-related Elements: History of a condition](pattern_billingrelated.html#history-of-a-condition) pattern.

### Onset, abatement, and prevalence period

See [Onset, abatement, and prevalence period](https://hl7.org/fhir/us/cql/en/patterns-condition.html#onset-abatement-and-prevalence-period).

`abatementInterval()` and `prevalenceInterval()` are defined in FHIRCommon; they were previously in QICoreCommon. `prevalenceInterval()` returns the interval from onset to abatement, closed at the end when the condition is active (`active`, `recurrence`, or `relapse`) and open otherwise. Prefer it over `clinicalStatus` whenever the question is whether a condition was active during a period.

> KNOWN ISSUE: There is a known issue with the `prevalenceInterval` function for Condition; strongly consider the use of `prevalencePeriod` in CQMConcepts 0.4.000. See [Prevalence Interval Issue](knownissues.html#prevalence-interval-issue).

### Diagnosis date and relevant period

Regarding the date of a diagnosis, the US Core Condition Problem Health Concern profile has the [following language](https://hl7.org/fhir/us/core/STU6.1/StructureDefinition-us-core-condition-problems-health-concerns.html#mandatory-and-must-support-data-elements):

> There is no single element in Condition that represents the date of diagnosis. It may be the assertedDate Extension, Condition.onsetDateTime, or Condition.recordedDate.
> Although all three are marked as Must Support, the server is not required to support all.
>
> * A server SHALL support Condition.recordedDate.
> * A server SHALL support at least one of assertedDate Extension and Condition.onsetDateTime. A server may support both, which means they support all 3 locations.
> * The client application SHALL support all three elements.

To capture this, CQMConcepts 0.4.000 defines a `relevantDate()` function for Condition that returns the first available of:

* earliest date of onset
* asserted date
* recorded date

Because a US Core conformant server supports either onset or asserted date, as well as recorded date, this logic uses whichever of those the server populates. Note that support for an element does not guarantee it is present on any given record, so `relevantDate()` can still be null. The result is not necessarily the clinically-documented onset, but it is a useful approximation, and one that is more likely to yield results across implementations.

Using this definition of `relevantDate()`, CQMConcepts also defines `relevantPeriod()`, analogous to `prevalencePeriod()`, but starting with the `relevantDate()`, rather than the `onset`. `relevantPeriod()` can be substituted wherever `prevalencePeriod()` is currently used, noting that:

* `prevalencePeriod()` is used when logic should _only_ consider clinically recorded `onset` when determining whether a condition is present
* `relevantPeriod()` is used when logic should _preferentially_ consider clinically recorded `onset`, but fallback to `assertedDate`, and then `recordedDate` as the starting point

```cql
define "Diabetes During Measurement Period":
  [USQualityCore.ConditionProblemsHealthConcerns: "Diabetes"] DiabetesCondition
    where DiabetesCondition.isVerified()
      and DiabetesCondition.relevantPeriod() overlaps "Measurement Period"
```

Note the following about the boundaries of both functions:

* A condition with no starting date (no onset for `prevalencePeriod()`; no onset, asserted, or recorded date for `relevantPeriod()`) has a closed null starting boundary, so it is treated as present from the beginning of time.
* The ending boundary is determined by `isActive()`, which is false when `clinicalStatus` is missing. A condition with no abatement then has an unknown (open null) ending boundary, so comparisons such as `overlaps "Measurement Period"` may return null rather than true. This is particularly relevant for encounter diagnoses, which often have no `clinicalStatus`.

### Conditions present on admission and principal diagnoses

Whether a diagnosis was present on admission and/or a principal diagnosis is not an element of the Condition resource itself. Each is a [billing-related element](pattern_billingrelated.html) with more than one representation:

* In the **clinical record** they are represented on the Encounter &mdash; on `Encounter.diagnosis` for present on admission, principal diagnosis, and primary procedure, and on `Encounter.hospitalization` for discharge disposition. These are documented in [Encounters](pattern_encounters.html).
* In **claim information** they are represented on the Claim for provider-submitted claims, and on ExplanationOfBenefit for payer-adjudicated claims, documented in [Claim](pattern_claim.html).

Which representation a measure should use depends on measure intent; see [Billing-related elements](pattern_billingrelated.html) for a discussion of the approaches.
