US Quality Core defines a [US Quality Core Encounter](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-encounter.html) profile to model any encounter between a patient and any number of providers in any setting, including virtual.

The US CQL implementation guide does not publish an Encounter patterns page, so this page is the primary source for encounter patterns; see the [Pattern Index](pattern_index.html) for the full list of available patterns. The encounter-specific fluent functions referenced below are defined in the CQMCommon library.

Several [billing-related elements](pattern_billingrelated.html) are represented in the clinical record on the Encounter resource rather than on Condition or Procedure: present on admission, principal diagnosis, and primary procedure on `Encounter.diagnosis`, and discharge disposition on `Encounter.hospitalization`. Those patterns are below; the corresponding claim representations are documented in [Claim](pattern_claim.html).

### Office visit encounters

By default, encounters in US Quality Core are characterized using the `type` element, which is typically bound to a value set. The retrieve limits the result to encounters whose type includes a code from that value set:

```cql
define "Office Visit Encounters":
  [USQualityCore.Encounter: "Office Visit"]
```

### Accessing Encounters with a Direct-reference code

The `type` element is multi-cardinality, so a given Encounter may carry several types. With a value set the retrieve resolves using the `List<Concept>` overload of the [in(ValueSet)](https://cql.hl7.org/09-b-cqlreference.html#in-valueset) operator, but there is no equivalent overload of [Equivalent (~)](https://cql.hl7.org/09-b-cqlreference.html#equivalent) for comparing a list against a direct-reference code.

This is under review and may result in a specification or tooling change (see [Translator Issue 1181](https://github.com/cqframework/clinical_quality_language/issues/1181)). Until then there are two workarounds:

1. Define a value set containing the required code, and retrieve with that value set.
2. Retrieve without a terminology filter and test with an `exists`:

```cql
define "Office Visit Encounters By Code":
  [USQualityCore.Encounter] Visit
    where exists ((Visit.type) VisitType where VisitType ~ "Office Visit Code")
```

The second workaround typically produces an unrestricted data requirement for Encounter, so the first is preferred.

### Encounters by class

The profile also supports characterizing encounters by `class`, which categorizes more broadly than `type` using the [ActEncounterCode](https://terminology.hl7.org/3.1.0/ValueSet-v3-ActEncounterCode.html) value set. Because `class` is single-cardinality, a direct-reference code works in the retrieve:

```cql
define "Virtual Encounters":
  [USQualityCore.Encounter: class ~ USQualityCoreCommon."virtual"]
```

> Although QDM-based eCQMs have historically filtered encounters by type, `class` is a required element in US Core, so the recommendation is to filter by class first unless measure intent requires identifying encounters by type across classes. Additional filtering is often needed, for example to limit encounters by specialty:

```cql
define "Ophthalmology Encounter Codes":
  [USQualityCore.Encounter: class in "Inpatient Encounter Class Code"] InpatientEncounter
    where InpatientEncounter.type in "Ophthalmology Services"
```

### Completed encounters in a period

Encounters usually need filtering on `status` and `period`:

```cql
define "Completed Encounters During The Measurement Period":
  [USQualityCore.Encounter: "Office Visit"] OfficeVisit
    where OfficeVisit.status = 'finished'
      and OfficeVisit.period starts during "Measurement Period"
```

### Encounters with a certain length

CQMCommon defines `lengthInDays()`, which returns the difference in calendar days between the start and end of an interval:

```cql
define "Non Elective Inpatient Encounter Less Than 120 Days":
  [USQualityCore.Encounter: "Non Elective Inpatient Encounter"] NonElectiveEncounter
    where NonElectiveEncounter.period.lengthInDays() <= 120
```

Other durations are calculated directly:

```cql
define "Non-Elective Inpatient Encounter Over 24 Hours":
  [USQualityCore.Encounter: "Non Elective Inpatient Encounter"] NonElectiveEncounter
    where duration in hours of NonElectiveEncounter.period >= 24
```

> NOTE: For an ongoing encounter the end of the period is often absent, which CQL interprets as an ongoing period and which will produce large duration values.

### Hospitalization

For inpatient encounters, measures often need the whole hospitalization, including any immediately preceding emergency department or observation encounter. CQMCommon defines a family of fluent functions over an Encounter for this:

| Function | Returns |
|----|----|
| `hospitalization()` | The admission-to-discharge interval, extended back to the admission of any immediately prior emergency department visit |
| `hospitalizationWithObservation()` | The same, extended back through any immediately prior observation encounter |
| `hospitalizationWithObservationAndOutpatientSurgeryService()` | The same, also including an immediately prior outpatient surgery service |
| `hospitalizationLengthOfStay()` | Length of stay in days over the hospitalization interval |
| `hospitalizationWithObservationLengthofStay()` | Length of stay in days including observation |
| `hospitalizationLocations()` | All locations within the encounter, including those of an immediately prior emergency department visit |
| `edVisit()` | The most recent emergency department visit occurring one hour or less before the encounter, if any |
| `emergencyDepartmentArrivalTime()` | Emergency department arrival time for the encounter |
| `hospitalAdmissionTime()` | Admission time for the encounter, or for an immediately prior emergency department visit |
| `hospitalDischargeTime()` | Discharge time for the encounter |
| `hospitalArrivalTime()` | Earliest arrival time for the encounter, including any prior emergency department visit |
| `hospitalDepartureTime()` | Latest departure time for the encounter, including any prior emergency department visit |
| `firstInpatientIntensiveCareUnit()` | The first intensive care unit location of the encounter, not considering any immediately prior emergency department visit |
{: .grid}

For example, to find comfort measures performed at any point during the hospitalization:

```cql
define "Comfort Measures Performed":
  [USQualityCore.Procedure: "Comfort Measures"] InterventionPerformed
    where InterventionPerformed.status in { 'completed', 'in-progress' }

define "Encounter With Comfort Measures Performed During Hospitalization":
  "Non Elective Inpatient Encounter Less Than 120 Days" NonElectiveEncounter
    with "Comfort Measures Performed" ComfortMeasure
      such that start of ComfortMeasure.performed.toInterval() during NonElectiveEncounter.hospitalizationWithObservation()
```

### Present on Admission

Present on admission is an indication of whether or not the diagnosis was present when the patient was admitted (as opposed to a condition that developed during the encounter). This is not the same as the _admitting diagnosis_.

In the clinical record, whether or not a given diagnosis is or was present on admission is not always recorded explicitly. It may not be recorded unless that element has direct bearing on treatment (and even then it may not be discretely captured). In a clinical setting, if it is recorded, it is likely captured with a simple boolean flag. Also, whether or not a diagnosis was present on admission may be inferred, for example a congenital condition was obviously present on admission.

With those caveats, within the clinical record, present-on-admission is represented in US Quality Core using the `presentOnAdmission` extension:

```cql
define "Encounter With Asthma Present On Admission":
  [Encounter] E
    where exists (
      E.diagnosis D
        where D.condition.getCondition().code in "Asthma"
          and D.presentOnAdmission() in "Present On Admission Indicators"
    )
```

For the claim representation, see [Present on Admission](pattern_claim.html#present-on-admission). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Principal Diagnosis

Principal diagnosis is primarily a term used in hospital coding and reporting. However, FHIR also allows the element to be represented using the `diagnosis` element of an Encounter:

```cql
define "Encounter With Principal Diagnosis Of Asthma":
  [Encounter] E
    where exists (
      E.diagnosis D
        where D.condition.getCondition().code in "Asthma"
          and D.use = FHIRCommon."Billing"
          and D.rank = 1
    )
```

For the claim representation, see [Principal Diagnosis](pattern_claim.html#principal-diagnosis). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Primary Procedure

Primary procedure is primarily a term used in hospital coding and reporting. However, FHIR also allows the element to be represented using the `diagnosis` element of an Encounter. That is not a copy of the principal diagnosis pattern above: `Encounter.diagnosis.condition` is a reference to either a Condition or a Procedure, so the same element carries both, distinguished by what it points at.

```cql
define "Encounter With Primary Procedure Of Appendectomy":
  [Encounter] E
    where exists (
      E.diagnosis D
        where D.condition.getProcedure().code in "Appendectomy"
          and D.use = FHIRCommon."Billing"
          and D.rank = 1
    )
```

For the claim representation, see [Primary Procedure](pattern_claim.html#primary-procedure). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Discharge Disposition

In US Quality Core, discharge disposition on an encounter is represented as a clinical element using the [Clinical Discharge Disposition](https://terminology.hl7.org/7.1.0/en/ValueSet-clinical-discharge-disposition.html) value set.

```cql
define "Encounter With Discharge Disposition To Home":
  [Encounter] E
    where E.hospitalization.dischargeDisposition in "Home Discharge Disposition Codes"
```

For the claim representation see [Discharge Disposition](pattern_claim.html#discharge-disposition). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.
