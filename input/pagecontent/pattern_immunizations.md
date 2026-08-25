FHIR defines several immunization-related resources to track and manage the immunization information for a patient, including [Immunization](http://hl7.org/fhir/immunization.html) and [ImmunizationRecommendation](http://hl7.org/fhir/immunizationrecommendation.html).  

> NOTE: The Immunization resources represent information immunization information as recorded in an Immunization Information System. For immunizations administered as part of clinical workflow, the medication resources should be used.

### Immunization performed

US Quality Core defines the [US Quality Core Immunization](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-immunization.html) profile to represent immunization information for a patient. By default, Immunization resources in US Quality Core are characterized by the `vaccineCode` element.

```cql
CQL:
define "Polio Immunizations":
  [Immunization: "Inactivated Polio Vaccine (IPV)"] PolioVaccination
    where PolioVaccination.status = 'completed'
```

> NOTE: The Immunization profile does not fix the value of the `status` element, so authors must consider all the possible values for the element to ensure the expression meets measure intent.

### Immunization not performed

US Quality Core defines the [US Quality Core Immunization Not Done](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-immunizationnotdone.html) profile to represent a vaccination that has been performed. Immunization resources are characterized by the vaccineCode element which identifies the specific vaccine product administered using standardized terminology. This ensures consistent interpretation and supports interoperability across systems. 

```cql
CQL:
define "Reason for No Polio Immunization":
 [ImmunizationNotDone: "Inactivated Polio Vaccine (IPV)"] PolioVaccination
   where PolioVaccination.statusReason in "Medical Reason For Not Providing Treatment"
    or PolioVaccination.statusReason in "Patient Declined"
```

> NOTE: Because the ImmunizationNotDone profile fixes the value of the `status` element to `not-done`, this element does not need to be tested in the expression.

