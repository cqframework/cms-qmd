FHIR defines the [AllergyIntolerance](https://hl7.org/fhir/R4/allergyintolerance.html) resource to represent allergies and intolerances for a patient. US Quality Core defines the [US Quality Core AllergyIntolerance](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-allergyintolerance.html) profile, which derives from US Core AllergyIntolerance, requires `patient`, and adds the `resolutionAge` extension.

Authoring patterns for allergies and intolerances are documented in [AllergyIntolerance](https://hl7.org/fhir/us/cql/en/patterns-allergy.html) in the US CQL implementation guide, covering modifier elements, search parameters, cross-version considerations, onset and abatement, and worked examples for contrast dye, egg, and nut allergies. This page records only what differs for quality measurement; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

> NOTE: Retrieves in the US CQL patterns are written against the US Core model (`[USCore.AllergyIntolerance]`). In CMS dQMs they are written against US Quality Core (`[USQualityCore.AllergyIntolerance]`). The element-level guidance is otherwise the same. The shared definitions in [USCoreElements](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) &mdash; `All Allergies and Intolerances`, `Active Confirmed Allergies and Intolerances`, and their variants &mdash; retrieve US Core-conformant instances, so measures requiring US Quality Core conformance should retrieve against US Quality Core directly.

### Current Allergies

See [Current allergies](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#current-allergies).

Quality measures are evaluated retrospectively, against the data that exists at the time of evaluation rather than during the measurement period. Because `isActive()` tests the *current* `clinicalStatus`, it should not be used to establish that an allergy was active during the measurement period. Use the prevalence interval instead, as described in [Onset, abatement, and prevalence interval](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#onset-abatement-and-prevalence-interval); `prevalenceInterval()` accounts for `resolutionAge` as well as `abatement`.

### No Known Allergies

See [No known allergies](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#no-known-allergies).

USCoreElements distinguishes `No Known Allergies (Confirmed)` from `No Known Allergies (Not Asked)`; a measure asserting that a patient has no known allergies should use the confirmed form. Both definitions test `isActive()`, so the retrospective consideration above applies to them.

### Verified Allergies

See [Clinical and verification status](https://hl7.org/fhir/us/cql/en/patterns-allergy.html#clinical-and-verification-status).

Measure logic should use the verification-status functions defined in [FHIRCommon](https://hl7.org/fhir/uv/cql/Library-FHIRCommon.html) &mdash; `isVerified()` and `verified()`, along with `isConfirmed()`, `isUnconfirmed()`, `isRefuted()`, and their list-valued forms &mdash; rather than re-declaring them locally. QICoreCommon's `verified()` is deprecated in favor of the FHIRCommon function; see the [Refactored Index](refactored_index.html).
