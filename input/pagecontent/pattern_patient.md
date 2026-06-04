# Patient 

QI-Core defines a [QICore Patient](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-patient.html) profile that extends the USCore patient.

## Patient age

Patient information includes the birth date, and CQL provides a built-in function to calculate the patient's age, either the current age (i.e. _as of_ now), or _as of_ a specified date. In quality improvement artifacts, age is typically calculated as of a specific date such as the start of the measurement period:

```cql
CQL:
define "Patient Age Between 50 and 75":
  AgeInYearsAt(date from start of "Measurement Period") between 50 and 75
```

> NOTES: 
The CQL function [AgeInYearsAt](https://cql.hl7.org/09-b-cqlreference.html#ageat) uses the underlying data model (QI-Core in this case) to determine how to access the patient's birth date.

CQL supports age calculation functions thta accept either Date or DateTime values. In both cases the function is shorthand for a date/datetime duration calculation. When usng the DateTime overloads, the timezone offset is taken into account, which can introduce edge cases particularly when the timezone offset differs significantly from the execution timestamp. To avoid these issues, best practice is to use the Date rather than the DateTime. 

## Patient race and ethnicity

US Core defines extensions for representing a patient's race and ethnicity using CDC's race and ethnicity codes. When authoring using QI-Core, these extensions can be accessed directly on the Patient resource using the "slice name" of the extension. For example:

```cql
CQL:
define "Patient Race Includes Alaska Native":
  Patient Patients
    where exists (Patients.race.ombCategory Category where Category ~ "American Indian or Alaska Native")
      and exists (Patients.race.detailed RaceDetails where RaceDetails ~ "Alaska Native")
```

> NOTE: CQL uses the underlying data model (QI-Core in this case) to determine how to access patient information through the `Patient` definition. This definition is available in the `Patient` contexts.
