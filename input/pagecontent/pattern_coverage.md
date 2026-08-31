FHIR uses the [Coverage](https://hl7.org/fhir/R4/coverage.html) resource to represent a patient's insurance or payment agreement. US Quality Core defines a [US Quality Core Coverage](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-coverage.html) profile derived from US Core Coverage.

[Coverage](https://hl7.org/fhir/us/cql/en/patterns-coverage.html) in the US CQL implementation guide covers [member or subscriber ID](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#member-or-subscriber-id). This page records only what differs for quality measurement; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

For this resource, see also [modifier elements](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#modifier-elements), [search parameters](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#search-parameters), and [cross-version considerations](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#cross-version-considerations) in that guide.

### Coverage status

`status` is the only modifier element on Coverage, and neither the US Core nor the US Quality Core profile fixes it, so an expression must account for the values it may take. For most measure intent that means restricting to active coverage:

```cql
define "Active Coverage":
  [USQualityCore.Coverage] C
    where C.status = 'active'
```

### Member or subscriber ID

See [Member or subscriber ID](https://hl7.org/fhir/us/cql/en/patterns-coverage.html#member-or-subscriber-id).

The US Core Coverage profile slices `identifier` for the member ID, and USCoreElements provides `memberID()` for it along with `policyNumber()` for the subscriber ID. The profile also carries an invariant requiring either the member ID slice or `subscriberId` to be present, so logic reading one should be prepared for the other.

### Payer

Measures that report payer as a supplemental data element take it from Coverage. `SDE Payer` in the SupplementalDataElements library retrieves coverages whose `type` is in a payer type value set and returns the type and period:

```cql
define "SDE Payer":
  [USQualityCore.Coverage: type in "Payer Type"] Payer
    return {
      code: Payer.type,
      period: Payer.period
    }
```

Use the shared definition rather than reading Coverage directly, so that payer is represented consistently across measures; see the [Refactored Index](refactored_index.html) for its current version.

> NOTE: `SDE Payer` does not filter on `status`. Where measure intent requires the coverage to have been active, that test has to be added.
