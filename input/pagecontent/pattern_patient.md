# Patient 
_Reviewed 2024-06-18_

QI-Core defines a [QICore Patient](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-patient.html) profile that extends the USCore patient.

## Patient age

Patient information includes the birth date, and CQL provides a built-in function to calculate the age of a patient, either current age (i.e. _as of_ now), or _as of_ a particular date. In quality improvement artifacts, age is typically calculated as of a particular date such as the start of the measurement period:

```cql
define "Patient Age Between 50 and 75":
  AgeInYearsAt(date from start of "Measurement Period") between 50 and 75
```

> NOTE: The [AgeInYearsAt](https://cql.hl7.org/09-b-cqlreference.html#ageat) function in CQL uses the data model (QICore in this case) to understand how to access the patient's birth date information.
> NOTE: CQL supports age calculation functions using both Date and DateTime values. In both cases the function is shorthand for a date/datetime duration calculation. If the DateTime overloads are used, note that the timezone offset is considered and there may be edge cases that result in unexpected results, depending on how large the timezone offset is from the execution timestamp. To avoid these edge cases, best practice is to use the date from extractor as shown in the above pattern to ensure the Date calculation is used.

## Patient race and ethnicity

US Core defines extensions for representing the race and ethnicity of a patient using the CDC's race and ethnicity codes. When authoring using QI-Core, these extensions can be accessed directly on the patient using the "slice name" of the extension:

```cql
define "Patient Race Includes Alaska Native":
  Patient P
    where exists (P.race.ombCategory C where C ~ "American Indian or Alaska Native")
      and exists (P.race.detailed C where C ~ "Alaska Native")
```

> NOTE: CQL uses the data model (QI-Core in this case) to understand how to access patient information using the `Patient` definition. This definition is available in `Patient` contexts.
