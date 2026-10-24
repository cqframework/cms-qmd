FHIR defines the [AllergyIntolerance](https://hl7.org/fhir/R4/allergyintolerance.html) resource to represent allergies and intolerances for a patient. US Quality Core defines the [US Quality Core AllergyIntolerance](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-allergyintolerance.html) profile, which derives from US Core AllergyIntolerance, requires `patient`, and adds the `resolutionAge` extension.

Authoring patterns for allergies and intolerances are documented in [AllergyIntolerance](https://hl7.org/fhir/us/cql/en/patterns-allergy.html) in the US CQL implementation guide, covering onset and abatement, along with worked examples for contrast dye, egg, and nut allergies. This page records only what differs for quality measurement; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

For AllergyIntolerance, see also [modifier elements](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#modifier-elements), [search parameters](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#search-parameters), and [cross-version considerations](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#cross-version-considerations) in that guide.

> NOTE: Retrieves in the US CQL patterns are written against the US Core model (`[USCore.AllergyIntolerance]`). In CMS dQMs they are written against US Quality Core (`[USQualityCore.AllergyIntolerance]`). The element-level guidance is otherwise the same. The shared definitions in [USCoreElements](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) &mdash; `All Allergies and Intolerances`, `Active Confirmed Allergies and Intolerances`, and their variants &mdash; retrieve US Core-conformant instances, so measures requiring US Quality Core conformance should retrieve against US Quality Core directly.

> NOTE: In addition, some systems capture "noted", as when the allergy/intolerance was first noted. An extension has been proposed to capture this information: https://jira.hl7.org/browse/FHIR-59668

### Current Allergies

See [Current allergies](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#current-allergies).

Quality measures are evaluated retrospectively, against the data that exists at the time of evaluation rather than during the measurement period. Because `isActive()` tests the *current* `clinicalStatus`, it may not be able to be used to establish that an allergy was active during the measurement period. See [Onset, abatement, and prevalence period](#onset-abatement-and-prevalence-period) below.

### Onset, abatement, and prevalence period

See [Onset, abatement, and prevalence interval](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#onset-abatement-and-prevalence-interval).

`abatementInterval()` and `prevalenceInterval()` are defined in FHIRCommon; they were previously in QICoreCommon. For AllergyIntolerance, `abatementInterval()` accounts for the `resolutionAge` extension as well as `abatement`. `prevalenceInterval()` returns the interval from onset to abatement, closed at the end when the allergy/intolerance is active (a `clinicalStatus` of `active`) and open otherwise. Because `isActive()` tests the [*current* clinicalStatus](#current-allergies), the prevalence interval is the more reliable way to determine historical status when onset and abatement are available.

However, if onset, abatement, or resolution are not available, which is often the case for allergy/intolerance information, measures can fall back to the `assertedDate`, and failing that, the `recordedDate` elements as an approximation of active status (see [Allergy date and relevant period](#allergy-date-and-relevant-period)). Alternatively, for allergy/intolerances that are not expected to abate, the use of `clinicalStatus` and `verificationStatus` directly may be the most reliable indicators.

> KNOWN ISSUE: There is a known issue with the `prevalenceInterval` function for AllergyIntolerance; strongly consider the use of `prevalencePeriod` in CQMConcepts 0.4.000. See [Prevalence Interval Issue](knownissues.html#prevalence-interval-issue).

### Allergy date and relevant period

Similar to the condition resource, given that many systems do not track onset and abatement information for an allergy/intolerance, clinicalStatus may be the most reliable indicator, even for historical purposes (assuming the allergy/intolerance is not expected to abate). However, to support consistent handling and allow for usage of data if it is available, CQMConcepts 0.4.000 defines a `relevantDate()` function for AllergyIntolerance that returns the first available of:

* earliest date of onset
* asserted date
* recorded date

Using this definition of `relevantDate()`, CQMConcepts also defines `relevantPeriod()`, analogous to `prevalencePeriod()`, but starting with the `relevantDate()`, rather than the `onset`. `relevantPeriod()` can be substituted wherever `prevalencePeriod()` is currently used, noting that:

* `prevalencePeriod()` is used when logic should _only_ consider clinically recorded `onset` when determining whether an allergy/intolerance is present
* `relevantPeriod()` is used when logic should _preferentially_ consider clinically recorded `onset`, but fallback to `assertedDate`, and then `recordedDate` as the starting point

```cql
define "Egg Allergy During Measurement Period":
  [USQualityCore.AllergyIntolerance: "Egg Allergen"] EggAllergy
    where EggAllergy.isVerified()
      and EggAllergy.relevantPeriod() overlaps "Measurement Period"
```

Note the following about the boundaries of both functions:

* An allergy/intolerance with no starting date (no onset for `prevalencePeriod()`; no onset, asserted, or recorded date for `relevantPeriod()`) has a closed null starting boundary, so it is treated as present from the beginning of time.
* The ending boundary is determined by `isActive()`, which is false when `clinicalStatus` is missing. An allergy/intolerance with no abatement then has an unknown (open null) ending boundary, so comparisons such as `overlaps "Measurement Period"` may return null rather than true.

### No Known Allergies

See [No known allergies](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#no-known-allergies).

USCoreElements distinguishes `No Known Allergies (Confirmed)` from `No Known Allergies (Not Asked)`; a measure asserting that a patient has no known allergies should use the confirmed form. Both definitions test `isActive()`, so the retrospective consideration above applies to them.

### Verified Allergies

See [Clinical and verification status](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#clinical-and-verification-status).

Measure logic should use the verification-status functions defined in [FHIRCommon](https://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) &mdash; `isVerified()` and `verified()`, along with `isConfirmed()`, `isUnconfirmed()`, `isRefuted()`, and their list-valued forms &mdash; rather than re-declaring them locally. QICoreCommon's `verified()` is deprecated in favor of the FHIRCommon function; see the [Refactored Index](refactored_index.html).
