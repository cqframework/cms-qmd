FHIR defines several immunization-related resources for tracking a patient's immunization information, including [Immunization](https://hl7.org/fhir/R4/immunization.html) and [ImmunizationRecommendation](https://hl7.org/fhir/R4/immunizationrecommendation.html).

The US CQL implementation guide does not publish an Immunization patterns page, so this page is the primary source for immunization patterns; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

> NOTE: The Immunization resources represent immunization information as recorded in an Immunization Information System. For immunizations administered as part of clinical workflow, use the [medication](pattern_medications.html#medication-administered) resources instead.

> NOTE: The US Quality Core ImmunizationEvaluation and ImmunizationRecommendation profiles are marked with an asterisk in the [US Quality Core profile list](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/profiles.html), meaning they are not part of that guide's conformance expectations. Immunization and Immunization Not Done, used below, are in scope.

### Immunization performed

US Quality Core defines the [US Quality Core Immunization](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-immunization.html) profile to represent an immunization administered to a patient, characterized by the `vaccineCode` element, which identifies the specific vaccine product using standardized terminology.

```cql
define "Polio Immunizations":
  [USQualityCore.Immunization: "Inactivated Polio Vaccine (IPV)"] PolioVaccination
    where PolioVaccination.status = 'completed'
```

The profile does not fix `status`, so the expression must account for every value relevant to measure intent.

### Immunization not performed

US Quality Core defines the [US Quality Core Immunization Not Done](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-immunizationnotdone.html) profile to document the reason an immunization was *not* administered, also characterized by `vaccineCode`. The profile fixes `status` to `not-done`, so that element need not be tested. See [Negation Patterns](pattern_negation.html).

```cql
define "Reason for No Polio Immunization":
  [USQualityCore.ImmunizationNotDone: "Inactivated Polio Vaccine (IPV)"] PolioVaccination
    where PolioVaccination.statusReason in "Medical Reason For Not Providing Treatment"
      or PolioVaccination.statusReason in "Patient Declined"
```

Where the statement is that no vaccine in a value set was administered, rather than that one specific vaccine was not, the value set is carried on the `vaccineCode` element through the `notDoneValueSet` extension. `vaccineCode()` in USQualityCoreCommon returns the negated activity extent in either form; see [Extent of negation](pattern_negation.html#extent-of-negation).
