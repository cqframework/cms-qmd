# Immunizations

FHIR defines several immunization-related resources to track and manage the immunization information for a patient, including [Immunization](http://hl7.org/fhir/immunization.html) and [ImmunizationRecommendation](http://hl7.org/fhir/immunizationrecommendation.html).  In comparison to STU 4.1.1, there are no new immunization profiles added to STU6 of QI-Core.

> NOTE: The Immunization resources are reflective of immunization information as recorded
in an Immunization Information System. For immunizations as part of clinical workflow, the 
medication resources should be used.

## Immunization performed

QI-Core defines the [Immunization](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-immunization.html) profile to represent immunization information for a patient. By default, Immunization resources in QI-Core are characterized by the `vaccineCode` element.

```cql
define "Polio Immunizations":
  ["Immunization": "Inactivated Polio Vaccine (IPV)"] PolioVaccination
    where PolioVaccination.status = 'completed'
```

> NOTE: Because the Immunization profile does not fix the value of the `status` element, authors must consider all the possible values for the element to ensure the expression meets measure intent.

## Immunization not performed

QI-Core defines the [ImmunizationNotDone](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-immunizationnotdone.html) profile to represent documentation of the reason an immunization was not performed. By default, ImmunizationNotDone resources in QI-Core are characterized by the `vaccineCode` element.

```cql
define "Reason for No Polio Immunization":
  ["ImmunizationNotDone": "Inactivated Polio Vaccine (IPV)"] PolioVaccination
    where PolioVaccination.statusReason in "Medical Reason"
      or PolioVaccination.statusReason in "Patient Refusal"
```

> NOTE: Because the ImmunizationNotDone profile fixes the value of the `status` element to `not-done`, this element does not need to be tested in the expression.

