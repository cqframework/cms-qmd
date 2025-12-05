# Encounters
_Reviewed 2024-06-18 - Updates to be made and reviewed again with group based on discussions_

QI-Core defines an [Encounter](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-encounter.html) profile to model any encounter between a patient and any number of providers in any setting, including virtual.

> NOTE: For background information on accessing clinical information with CQL, see the [Retrieve](https://cql.hl7.org/02-authorsguide.html#retrieve) topic in the CQL specification.

## Office visit encounters


By default, encounters in QI-Core are characterized by the `type` element, which is typically associated with a value set to limit the set of encounters returned to those that a code in the given value set. For example:

```cql
define "Office Visit Encounters":
  [Encounter: "Office Visit"]
```
## Accessing Encounters with a Direct-reference code


The type element of Encounters is plural meaning that a given Encounter may have multiple types associated with it. When using value sets such as the "Office Visit" example above, the retrieve resolves using the List<Concept> overload of the [in(ValueSet)](https://cql.hl7.org/09-b-cqlreference.html#in-valueset) operator in CQL. However, when attempting to use a direct-reference code, there is no overload of the [Equivalent (~)](https://cql.hl7.org/09-b-cqlreference.html#equivalent) operator to support the comparison.

This issue is being reviewed and may result in a specification or tooling change to support this use case (see [Translator Issue 1181](https://github.com/cqframework/clinical_quality_language/issues/1181)). However, at this time there are two possible workarounds:

1. Define a value set containing the required code and use that value set to perform the retrieve
2. Use an equivalent where clause with an exists to retrieve the expected results, as shown in the below example:

```cql
define "Office Visit Encounters By Code":
  [Encounter] E
    where exists ((E.type) T where T ~ "Office Visit Code")
```

Note that this latter workaround will typically result in an unrestricted data requirement for Encounters. For this reason, best-practice is to use the first workaround.

## Encounters by class


The QI-Core profile also supports characterizing encounters by the `class` element, which is used to categorize encounters more broadly than the `type` element, using the [ActEncounterCode](https://terminology.hl7.org/3.1.0/ValueSet-v3-ActEncounterCode.html) value set. For example:

```cql
define "Virtual Encounters":
  [Encounter: class ~ QICoreCommon."virtual"]
```

> Note that although QDM-based eCQMs have typically used a type-based approach to filtering encounters, because `class` is a required element in USCore, we propose using class to filter encounters first, unless measure intent needs to search for encounters by type across classes. Additional filtering may be required beyond the class to limit encounters based on specialty, for example:

```cql
define "Ophthalmology Encounter Codes":
  [Encounter: class in "Inpatient Encounter Classes"] InpatientEncounter
    where InpatientEncounter.type in "Ophthalmology Encounter Codes"
```

## Completed encounters in a period

Encounters often need to be filtered based on `status` and `period`, for example:

```cql
define "Completed Encounters During the Measurement Period":
  [Encounter: "Office Visit"] OfficeVisit
    where OfficeVisit.status = 'finished'
      and OfficeVisit.period during "Measurement Period"
```

## Encounters with a certain length

The CQMCommon library defines a `lengthInDays()` function that calculates the difference in days between the start and end of a period. For example, to filter encounters by the duration of stay:

```cql
define "Non-Elective Inpatient Encounter Less Than 120 Days":
  ["Encounter": "Non-Elective Inpatient Encounter"] NonElectiveEncounter
    where NonElectiveEncounter.period.lengthInDays() <= 120
```

Other durations can also be calculated, for example:

```cql
define "Non-Elective Inpatient Encounter Over 24 Hours":
  ["Encounter": "Non-Elective Inpatient Encounter"] NonElectiveEncounter
    where duration in hours of NonElectiveEncounter.period >= 24
```

> NOTE: For ongoing encounters, the end of the period is often not specified, which will typically be interpreted in CQL as an ongoing period, resulting in large duration values.

## Hospitalization

For inpatient encounters, measures and rules often need to consider total hospitalization period, including any immediately prior emergency department and/or observation status encounters. To facilitate this, the CQMCommon library defines a `hospitalizationWithObservation()` function that returns the total duration from admission to the emergency department or observation to the end of the inpatient encounter. For example:

```cql
define "Comfort Measures Performed":
  ["Procedure": "Comfort Measures"] InterventionPerformed
    where InterventionPerformed.status in { 'completed', 'in-progress' }

define "Encounter with Comfort Measures Performed during Hospitalization":
  "Non-Elective Inpatient Encounter Less Than 120 Days" Encounter
    with "Comfort Measures Performed" ComfortMeasure
      such that start of ComfortMeasure.performed.toInterval() during Encounter.hospitalizationWithObservation()
```
