# Encounters

QI-Core defines an [Encounter](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-encounter.html) profile to model any encounter between a patient and any number of providers in any setting, including virtual.

> NOTE: For background information on accessing clinical information with CQL, see the [Retrieve](https://cql.hl7.org/02-authorsguide.html#retrieve) topic in the CQL specification.

## Office visit encounters


By default, encounters in QI-Core are characterized using the `type` element, which is typically bound to a value set. This value set limits the encounters returned to those whose type includes a code from the specified value set. For example:

```cql
CQL:
define "Office Visit Encounters":
  [Encounter: "Office Visit"]
```
## Accessing Encounters with a Direct-reference code


The type element of Encounters is plural meaning that a given Encounter may have multiple types associated with it. When using value sets such as the "Office Visit" example above, the retrieve resolves using the List<Concept> overload of the [in(ValueSet)](https://cql.hl7.org/09-b-cqlreference.html#in-valueset) operator in CQL. However, when attempting to use a direct-reference code, there is no overload of the [Equivalent (~)](https://cql.hl7.org/09-b-cqlreference.html#equivalent) operator to support the comparison.

This issue is being reviewed and may result in a specification or tooling change to support this use case (see [Translator Issue 1181](https://github.com/cqframework/clinical_quality_language/issues/1181)). However, at this time there are two possible workarounds:

1. Define a value set containing the required code and use that value set to perform the retrieve
2. Use an equivalent where clause with an exists to retrieve the expected results, as shown in the below example:

```cql
CQL:
define "Office Visit Encounters By Code":
  [Encounter] Visit
    where exists ((Visit.type) VisitType where VisitType ~ "Office Visit Code")
```

Note that this latter workaround will typically result in an unrestricted data requirement for Encounters. For this reason, best-practice is to use the first workaround.

## Encounters by class


The QI-Core profile also supports characterizing encounters using the `class` element. This element categorizes encounters more broadly than the `type` element, using the [ActEncounterCode](https://terminology.hl7.org/3.1.0/ValueSet-v3-ActEncounterCode.html) value set. For example:

```cql
CQL:
define "Virtual Encounters":
  [Encounter: class ~ QICoreCommon."virtual"]
```

> Although QDM-based eCQMs have historically used a type-based approach to filtering encounters, `class` is a required element in USCore. Therefore, the recommendation is to filter by class first, unless the measure intent requires identifying encounters by type across classes. In many cases, additional filtering may be necessary. For example to limit encounters based on specialty:

```cql
CQL:
define "Ophthalmology Encounter Codes":
  [Encounter: class in "Inpatient Encounter Class Code"] InpatientEncounter
    where InpatientEncounter.type in "Ophthalmology Services"
```

## Completed encounters in a period

Encounters often need to be filtered based on `status` and `period`, for example:

```cql
CQL:
define "Completed Encounters During The Measurement Period":
  [Encounter: "Office Visit"] OfficeVisit
    where OfficeVisit.status = 'finished'
      and OfficeVisit.period starts during "Measurement Period"
```

## Encounters with a certain length

The CQMCommon library defines a `lengthInDays()` fluent function that calculates the difference in days between the start and end of a period. For example, to filter encounters by the duration of stay:

```cql
CQL:
define "Non-Elective Inpatient Encounter Less Than 120 Days":
  [Encounter: "Non-Elective Inpatient Encounter"] NonElectiveEncounter
    where NonElectiveEncounter.period.lengthInDays() <= 120
```

Other durations can also be calculated, for example:

```cql
CQL:
define "Non-Elective Inpatient Encounter Over 24 Hours":
  [Encounter: "Non-Elective Inpatient Encounter"] NonElectiveEncounter
    where duration in hours of NonElectiveEncounter.period >= 24
```

> NOTE: For ongoing encounters, the end of the period is often not specified, which will typically be interpreted in CQL as an ongoing period, resulting in large duration values.

## Hospitalization

For inpatient encounters, measures and rules often need to consider the entire hospitalization period, including any immediately preceding emergency department and/or observation status encounters. To support this, the CQMCommon library provides a `hospitalizationWithObservation()` fluent function that returns the total duration beginning with the earliest associated emergency department or observation encounter to the conclusion of the inpatient encounter. For example:

```cql
CQL:
define "Comfort Measures Performed":
  [Procedure: "Comfort Measures"] InterventionPerformed
    where InterventionPerformed.status in { 'completed', 'in-progress' }

define "Encounter With Comfort Measures Performed During Hospitalization":
  "Non-Elective Inpatient Encounter Less Than 120 Days" NonElectiveEncounter
    with "Comfort Measures Performed" ComfortMeasure
      such that start of ComfortMeasure.performed.toInterval() during NonElectiveEncounter.hospitalizationWithObservation()
```
