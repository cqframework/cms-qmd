FHIR represents both problem list items and encounter diagnoses with the [Condition](https://hl7.org/fhir/R4/condition.html) resource, distinguished by the `category` element. US Quality Core profiles them separately as [Condition Problems and Health Concerns](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-condition-problems-health-concerns.html) and [Condition Encounter Diagnosis](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-condition-encounter-diagnosis.html).

Authoring patterns for conditions are documented in [Condition](https://hl7.org/fhir/us/cql/en/patterns-condition.html) in the US CQL implementation guide, covering category, active and verified conditions, historical conditions, onset and abatement, and evidence of a diagnosis during an encounter. This page records only what differs for quality measurement; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

For Condition, see also [modifier elements](https://hl7.org/fhir/us/cql/en/patterns-condition.html#modifier-elements), [search parameters](https://hl7.org/fhir/us/cql/en/patterns-condition.html#search-parameters), and [cross-version considerations](https://hl7.org/fhir/us/cql/en/patterns-condition.html#cross-version-considerations) in that guide.

> NOTE: Retrieves in the US CQL patterns are written against the US Core model, and the shared definitions in [USCoreElements](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) &mdash; including `All Conditions`, which unions problem list items, health concerns, and encounter diagnoses &mdash; retrieve US Core-conformant instances. Measures requiring US Quality Core conformance retrieve against US Quality Core directly, and therefore union the two profiles themselves.

### Active conditions

See [Active conditions](https://hl7.org/fhir/us/cql/en/patterns-condition.html#active-conditions) and [Category](https://hl7.org/fhir/us/cql/en/patterns-condition.html#category).

Quality measures are evaluated retrospectively, so `isActive()` &mdash; which tests the *current* `clinicalStatus` &mdash; should not be used to establish that a condition was active during the measurement period. Use [prevalenceInterval()](#onset-abatement-and-prevalence-period) instead.

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

Note also that if a measure has access to claim information, claims may be used to search for history of a condition as well. See [Claim Patterns](pattern_claim.html) for more information.

### Onset, abatement, and prevalence period

See [Onset, abatement, and prevalence period](https://hl7.org/fhir/us/cql/en/patterns-condition.html#onset-abatement-and-prevalence-period).

`abatementInterval()` and `prevalenceInterval()` are defined in FHIRCommon; they were previously in QICoreCommon. `prevalenceInterval()` returns the interval from onset to abatement, closed at the end when the condition is active (`active`, `recurrence`, or `relapse`) and open otherwise. Prefer it over `clinicalStatus` whenever the question is whether a condition was active during a period.

### Conditions present on admission and principal diagnoses

Whether a diagnosis was present on admission and/or a principal diagnosis is not an element of the Condition resource itself. Each is a [billing-related element](pattern_billingrelated.html) with more than one representation:

* In the **clinical record** they are represented on the Encounter &mdash; on `Encounter.diagnosis` for present on admission, principal diagnosis, and primary procedure, and on `Encounter.hospitalization` for discharge disposition. These are documented in [Encounters](pattern_encounters.html).
* In **claim information** they are represented on the Claim for provider-submitted claims, and on ExplanationOfBenefit for payer-adjudicated claims, documented in [Claim](pattern_claim.html).

Which representation a measure should use depends on measure intent; see [Billing-related elements](pattern_billingrelated.html) for a discussion of the approaches.
