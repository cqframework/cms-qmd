US Quality Core defines a [US Quality Core Patient](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-patient.html) profile that extends the US Core Patient profile.

The [Patient](https://hl7.org/fhir/us/cql/en/patterns-patient.html) patterns page in the US CQL implementation guide covers **name**, **birth date**, **age**, **gender**, **sex**, **race and ethnicity**, and **deceased**. This page records only what differs for quality measurement; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

### Patient age

See [Patient age](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-age).

Where decision support applications typically ask for a patient's age as of today, a quality measure calculates it as of a specific date &mdash; usually the start of the measurement period:

```cql
define "Patient Age Between 50 and 75":
  Patient.ageInYearsAt(date from start of "Measurement Period") between 50 and 75
```

CQL supports age calculations over both Date and DateTime values. The DateTime overloads take the timezone offset into account, which can produce unexpected results when the offset differs significantly from the execution timestamp, so best practice is to apply the `date from` extractor to the *as of* value as above. The `ageInYearsAt()` and related functions in [USCoreElements](https://hl7.org/fhir/us/cql/Library-USCoreElements.html) apply that extractor already, so logic using them does not need to.

### Patient race and ethnicity

See [Patient race and ethnicity](https://hl7.org/fhir/us/cql/en/patterns-patient.html#patient-race-and-ethnicity).

US Core defines extensions for representing a patient's race and ethnicity using the CDC's race and ethnicity codes. Under the derived ModelInfo used by US Quality Core, these are reached through the `race()` and `ethnicity()` fluent functions in [USCoreCommon](https://hl7.org/fhir/us/cql/Library-USCoreCommon.html):

```cql
define "Patient Race Includes Alaska Native":
  Patient P
    where exists (P.race().ombCategory Category where Category ~ "American Indian or Alaska Native")
      and exists (P.race().detailed RaceDetail where RaceDetail ~ "Alaska Native")
```

`race()` and `ethnicity()` each return a tuple of `ombCategory`, `detailed`, and `text`. Note that `race().ombCategory` is a list while `ethnicity().ombCategory` is a single Coding, following the extension definitions. For the full list of extension-backed elements and their accessors, see the [Extension Index](refactored_index.html#extension-index).

> NOTE: CQL uses the underlying data model to determine how to access patient information through the `Patient` definition, which is available in Patient context. A retrieve is not required.

Measures that report race and ethnicity as supplemental data elements use the SupplementalDataElements library rather than accessing the extensions directly; see the [Library Index](refactored_index.html#library-index) for its current version and the fluent functions it now uses.
