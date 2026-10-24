US Quality Core defines a [US Quality Core Encounter](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-encounter.html) profile to model any encounter between a patient and any number of providers in any setting, including virtual.

The US CQL implementation guide does not publish an Encounter patterns page, so this page is the primary source for encounter patterns; see the [Pattern Index](pattern_index.html) for the full list of available patterns. The hospitalization functions and expressions referenced below are defined in the CQMElements and CQMInferences libraries; see [Relationship to CQMCommon](#relationship-to-cqmcommon) for the corresponding CQMCommon functions.

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

CQMConcepts (and CQMCommon) defines `lengthInDays()`, which returns the difference in calendar days between the start and end of an interval:

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

### Reason for Visit

Reason for visit is represented with `Encounter.reasonCode` and `Encounter.reasonReference`:

```cql
define "Encounters With Diabetes As Reason For Visit":
  "Completed Encounters" CompletedEncounter
    where CompletedEncounter.reasonCode in "Diabetes"
      or exists (
        [FHIR.Condition: "Diabetes"] DiabetesCondition
          where CompletedEncounter.reasonReference.references(DiabetesCondition)
      )
```

Not all systems populate both `reasonCode` and `reasonReference`, so logic should allow for either. Where the prevalence period or onset of the condition is needed, `reasonReference` is required, because that information lives on the Condition resource rather than the Encounter. The `isReasonForVisit()` function can be used to test whether a given condition is referenced in the `reasonReference` element of the encounter:

```cql
define "Encounters With Diabetes As Reason For Visit":
  "Completed Encounters" CompletedEncounter
    where CompletedEncounter.reasonCode in "Diabetes"
      or exists (
        [FHIR.Condition: "Diabetes"] DiabetesCondition
          where DiabetesCondition.isReasonForVisit(CompletedEncounter)
      )
```

### Evidence of Diagnosis during an Encounter

If measure intent is to establish whether or not a particular diagnosis was active during an encounter, there are at least three possible sources for that information in the clinical record:

* Encounter Diagnoses - Using the `ConditionEncounterDiagnosis` profile linked to the encounter
* Problem Item - Using the `ConditionProblemHealthConcern` profile active (i.e. prevalent) during the encounter
* Reason for Visit - Using the `reasonCode` element of the encounter

The following pattern illustrates searching for all three potential sources:

```cql
define "Encounters With Diabetes":
  "Completed Encounters" CompletedEncounter
    where CompletedEncounter.reasonCode in "Diabetes Diagnosis Codes"
      or exists (
        [USQualityCore.ConditionEncounterDiagnosis: "Diabetes Diagnosis Codes"] DiabetesCondition
          where DiabetesCondition.isReasonForVisit(CompletedEncounter)
            or DiabetesCondition.encounter.references(CompletedEncounter)
      )
      or exists (
        [USQualityCore.ConditionProblemsHealthConcerns: "Diabetes Diagnosis Codes"] DiabetesCondition
          where DiabetesCondition.prevalencePeriod() overlaps CompletedEncounter.period
      )
```

> Note that this approach is explicitly looking for prevalence period in the case of problem list items, versus an encounter link for encounter diagnoses. Both these approaches have the potential to miss some information because neither the explicit encounter link for ConditionEncounterDiagnosis, nor the onset and abatement information for ConditionProblemsHealthConcerns are required. Applications may need to fall back to the asserted and/or recorded date elements of the condition to determine the relationship to the encounter, which can be done by using [relevantPeriod()](pattern_conditions.html#diagnosis-date-and-relevant-period) in place of `prevalencePeriod()`.

Some considerations for evidence of diagnosis during an encounter:

1. **start timing** - How the prevalence interval is related, whether diagnosis should _overlap_ or _start during_ the encounter
2. **status vs prevalence** - Whether to use the _current status_ element as opposed to calculating the _prevalence interval_ for historical consideration, especially for conditions that are unlikely to resolve
3. **verification** - Whether and how stringently to test the verification status of the condition
4. **onset vs asserted vs recorded** - Whether and how to determine the _starting point_ for consideration

In addition, if the measure has access to claim information, consider searching for claim diagnoses as described in the [Billing-related Elements: Evidence of Diagnosis during an Encounter](pattern_billingrelated.html#evidence-of-diagnosis-during-an-encounter) pattern.

> KNOWN ISSUE: The example above uses `prevalencePeriod()` from CQMConcepts 0.4.000, rather than `prevalenceInterval()` from FHIRCommon 2.0.0, because of a known issue with the `prevalenceInterval` function for Condition. See [Prevalence Interval Issue](knownissues.html#prevalence-interval-issue).

### Present on Admission

Present on admission is an indication of whether or not the diagnosis was present when the patient was admitted (as opposed to a condition that developed during the encounter). This is not the same as the _admitting diagnosis_.

In the clinical record, whether or not a given diagnosis is or was present on admission is not always recorded explicitly. It may not be recorded unless that element has direct bearing on treatment (and even then it may not be discretely captured). In a clinical setting, if it is recorded, it is likely captured with a simple boolean flag. Also, whether or not a diagnosis was present on admission may be inferred, for example a congenital condition was obviously present on admission.

With those caveats, within the clinical record, present-on-admission is represented in US Quality Core using the `presentOnAdmission` extension:

```cql
define "Encounter With Asthma Present On Admission":
  [Encounter] E
    where exists (
      E.diagnosis D
        with [FHIR.Condition: "Asthma"] C
          such that D.condition.references(C)
        where D.presentOnAdmission() in "Present On Admission Indicators"
    )
```

> Note that the `Encounter.diagnosis` element is _not_ profiled in the US Core Encounter profile in any version. Encounter diagnoses in US Core use `ConditionEncounterDiagnosis` profile, as well as the `Encounter.reasonCode` and `Encounter.reasonReference` elements to document reason for visit, so this representation is not likely to be available in data sourced from US Core implementations.

For the claim representation, see [Present on Admission](pattern_claim.html#present-on-admission). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Principal Diagnosis

Principal diagnosis is primarily a term used in hospital coding and reporting. However, FHIR also allows the element to be represented using the `diagnosis` element of an Encounter:

```cql
define "Encounter With Principal Diagnosis Of Asthma":
  [Encounter] E
    where exists (
      E.diagnosis D
        with [FHIR.Condition: "Asthma"] C
          such that D.condition.references(C)
        where D.use = FHIRCommon."Billing"
          and D.rank = 1
    )
```

> Note that the `Encounter.diagnosis` element is _not_ profiled in the US Core Encounter profile in any version. Encounter diagnoses in US Core use the  `ConditionEncounterDiagnosis` profile, as well as `reasonCode` and `reasonReference` to document reason for visit, so this representation is not likely to be available in data sourced from US Core implementations.

For the claim representation, see [Principal Diagnosis](pattern_claim.html#principal-diagnosis). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Primary Procedure

Primary procedure is primarily a term used in hospital coding and reporting. However, FHIR also allows the element to be represented using the `diagnosis` element of an Encounter. That is not a copy of the principal diagnosis pattern above: `Encounter.diagnosis.condition` is a reference to either a Condition or a Procedure, so the same element carries both, distinguished by what it points at.

```cql
define "Encounter With Primary Procedure Of Appendectomy":
  [Encounter] E
    where exists (
      E.diagnosis D
        with [FHIR.Procedure: "Appendectomy"] P
          such that D.condition.references(P)
        where D.use = FHIRCommon."Billing"
          and D.rank = 1
    )
```

> Note that the `Encounter.diagnosis` element is _not_ profiled in the US Core Encounter profile in any version. Encounter diagnoses in US Core use the `Encounter.reasonCode` and `Encounter.reasonReference` elements, as well as the  `ConditionEncounterDiagnosis` profile, so this representation is not likely to be available in data sourced from US Core implementations.

For the claim representation, see [Primary Procedure](pattern_claim.html#primary-procedure). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Discharge Disposition

In US Quality Core, discharge disposition on an encounter is represented as a clinical element using the [Clinical Discharge Disposition](https://terminology.hl7.org/7.1.0/en/ValueSet-clinical-discharge-disposition.html) value set.

```cql
define "Encounter With Discharge Disposition To Home":
  [Encounter] E
    where E.hospitalization.dischargeDisposition in "Home Discharge Disposition Codes"
```

> Note that the `dischargeDisposition` element in US Core is profiled to use UB-04 billing codes, whereas the element in US Quality Core is overridden to use clinical discharge disposition codes, with the billing codes used in the claim representation (see below).

For the claim representation see [Discharge Disposition](pattern_claim.html#discharge-disposition). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Admission Source

In FHIR, admission source on an encounter is represented using the `Encounter.hospitalization.admitSource` element, using the [Admit Source](https://terminology.hl7.org/en/ValueSet-encounter-admit-source.html) terminology.

```cql
define "Encounter With Admission From Emergency Department":
  [Encounter] E
    where E.hospitalization.admitSource in "Emergency Department Admission Source Codes"
```

> NOTE: This element is being proposed for inclusion in the US Quality Core Encounter Profile in the 1.0.0 ballot. It is not currently profiled in the 0.5.0 version, though the element can still be referenced in logic because it is not restricted by the profile, it is just not marked as required or must support.

> NOTE: The clinical terminology for this element does not currently have hospice as an admission source. A UTG ticket has been submitted to add hospice to this terminology: https://jira.hl7.org/browse/UP-865 

For the claim representation see [Admission Source](pattern_claim.html#admission-source). See also the [Billing-related Elements](pattern_billingrelated.html) discussion.

### Encounter Priority and Elective Encounters

Although the FHIR Encounter resource does define a "priority" element, it is not profiled as part of the US Quality Core Encounter and is typically not exchanged as part of encounter information in the US Realm. As such, it is not recommended for use in Measure specifications expected to be used in the US Realm. As an alternative, measure specifications typically use value sets to filter on the  `Encounter.type` element with encounter type codes that indicate elective encounters. Other potential sources for this determination include:

* `Encounter.class` - May be used to indicate _emergent_ and _acute_ vs _non-acute_
* `Encounter.hospitalization.admitSource` - May potentially be used to indicate whether the admission was from an emergency department 
* `Procedure.code` - For procedures associated with the encounter to understand the nature of the procedures performed, whether they are urgent, emergent, elective, etc.
* [`ServiceRequest.priority`](pattern_procedures.html#procedcure-priority) - For orders associated with procedures or services performed during the encounter, whether they are routine, urgent, emergent, etc.

### Hospitalization

For hospital encounters, measure logic is often concerned with identifying a set of associated encounters that all occurred together. For example, an emergency department visit, followed by observation, followed by an inpatient admission. Although systems often track these as separate encounters, measure logic is often written from the perspective of a "hospitalization event" that includes all three encounters. The CQMElements and CQMInferences libraries include several functions and expressions that facilitate the consideration of a set of encounters as a "hospitalization event".

#### Encounter Definitions

CQMElements defines the encounters typically considered as part of a hospitalization event. Each is a retrieve by `Encounter.type` using the value set from CQMConcepts, limited to `finished` encounters:

| Definition | Value set |
|---|---|
| `"Inpatient Encounter"` | Encounter Inpatient |
| `"Emergency Department Encounter"` | Emergency Department Visit |
| `"Observation Encounter"` | Observation Services |
| `"Outpatient Surgery Encounter"` | Outpatient Surgery Service |
{: .grid}

CQMInferences adds a `"... During Measurement Period"` variant of each (for example, `"Inpatient Encounter During Measurement Period"`), limited to encounters whose period ends during the day of the `"Measurement Period"`.

#### Hospitalization Encounters

The key function facilitating the treatment of a set of encounters as a hospitalization event is the `"Hospitalization Encounters"` function. The function takes a list of encounters of any type, and:

1. Determines the set of "hospitalization periods" that are represented (i.e. a series of encounters in which each encounter starts no more than 1 hour after the end of the previous encounter, or overlaps it).
2. Returns the _last_ encounter (by start time) in each of these series as the "Hospitalization Encounter" for the series.
3. Each "Hospitalization Encounter" lists the included encounters in the series, accessible via the `includedEncounters()` function.

Note that the "Hospitalization Encounter" keeps the elements of the last encounter, including its `period`, so `Encounter.period` is the period of the last encounter only. Use the `hospitalization()` function (below) for the interval of the hospitalization event as a whole.

The encounters passed to the function determine which encounters are grouped. Every series produces a result, including a series that does not end with an inpatient encounter (for example, an emergency department visit that was not followed by an admission), so logic concerned with inpatient hospitalizations should filter on the type of the result:

```cql
define "Hospitalization Encounter":
  (CQMElements."Hospitalization Encounters"(
    CQMElements."Inpatient Encounter"
      union CQMElements."Observation Encounter"
      union CQMElements."Emergency Department Encounter"
  )) HospitalizationEncounter
    where HospitalizationEncounter.type in CQMConcepts."Encounter Inpatient"
      and HospitalizationEncounter.period ends during day of "Measurement Period"
```

Note that this example groups the encounters first and then applies the measurement period to the result. Using the CQMInferences `"... During Measurement Period"` definitions as input instead applies the measurement period to each encounter before grouping, so an emergency department visit that ends before the start of the measurement period would not be included in a hospitalization whose inpatient encounter ends during it.

For example, to find comfort measures performed at any point during the hospitalization, given the "Hospitalization Encounter":

```cql
define "Comfort Measures Performed":
  [USQualityCore.Procedure: "Comfort Measures"] InterventionPerformed
    where InterventionPerformed.status in { 'completed', 'in-progress' }

define "Encounter With Comfort Measures Performed During Hospitalization":
  "Hospitalization Encounter" HospitalizationEncounter
    with "Comfort Measures Performed" ComfortMeasure
      such that start of ComfortMeasure.performed.toInterval() during HospitalizationEncounter.hospitalization()
```

The remaining functions dealing with hospitalization data elements make use of the computed information returned from the `"Hospitalization Encounters"` function. Except where noted, they expect a "Hospitalization Encounter" (i.e. a USQualityCore.Encounter that has been returned from the `"Hospitalization Encounters"` function) as input; given any other encounter, `includedEncounters()` is empty and these functions return `null` or an empty list.

#### Included Encounters

The `includedEncounters()` function returns the encounters in the hospitalization event, in order by start time, ending with the "Hospitalization Encounter" itself:

```cql
define "Included Encounters":
  "Hospitalization Encounter" HospitalizationEncounter
    return {
      encounterId: HospitalizationEncounter.id,
      includedEncounterIds: (HospitalizationEncounter.includedEncounters()) IncludedEncounter return IncludedEncounter.id
    }
```

#### Emergency Department Visit

The `edVisit()` function takes a "Hospitalization Encounter" and returns the most recent `finished` Emergency Department encounter during the hospitalization event.

Note that the Emergency Department encounter must have been included in the call to `"Hospitalization Encounters"`; otherwise the `edVisit()` function will return `null` because the emergency department visit will not be in the included encounters for the "Hospitalization Encounter".

##### Example: CMS529: Hybrid Hospital-Wide Readmission

```cql
define "SDE Encounter With Oxygen 60 Minutes Or Less Prior To ED Admission Or During ED":
  from
      "Inpatient Encounter" EncounterInpatient,
      "Non Invasive Oxygen Therapy Order" OxygenTherapyOrder
    where OxygenTherapyOrder.authoredOn during EncounterInpatient.edVisit().period
      or OxygenTherapyOrder.authoredOn 60 minutes or less on or before start of EncounterInpatient.edVisit().period
    return {
      EncounterId: EncounterInpatient.id,
      OrderStatus: OxygenTherapyOrder.status,
      OrderTiming: OxygenTherapyOrder.authoredOn
    }

define "Inpatient Encounter":
  (CQMElements."Hospitalization Encounters"(
    CQMElements."Inpatient Encounter"
      union CQMElements."Emergency Department Encounter"
  )) HospitalizationEncounter
    where HospitalizationEncounter.type in CQMConcepts."Encounter Inpatient"
      and HospitalizationEncounter.period ends during day of "Measurement Period"

define "Non Invasive Oxygen Therapy Order":
  ([USQualityCore.ServiceRequest: "Non Invasive Oxygen Therapy by Nasal Cannula or Mask"]
    union [USQualityCore.ServiceRequest: "Non Invasive Oxygen Therapy Device Codes"]
  ) OxygenTherapyOrder
    where OxygenTherapyOrder.status in { 'active', 'completed' }
      and OxygenTherapyOrder.intent = 'order'
```

For comparison, see the [QICore Version](https://github.com/cqframework/dqm-content-qicore-2025/blob/master/input/cql/CMSFHIR529HybridHospitalWideReadmission.cql#L229)

#### Observation and Outpatient Surgery Services

The `observationVisit()` and `outpatientSurgeryVisit()` functions take a "Hospitalization Encounter" and return the most recent `finished` Observation or Outpatient Surgery Services encounter during the hospitalization event, respectively.

As with the `edVisit()` function, the observation and outpatient surgery service encounters must have been included for consideration in the "Hospitalization Encounter" determination; otherwise, these functions will result in `null` because the "Hospitalization Encounter" will not have them in its included encounters list.

```cql
define "Hospitalization With Observation Stay":
  "Hospitalization Encounter" HospitalizationEncounter
    where HospitalizationEncounter.observationVisit() is not null

define "Hospitalization Including Outpatient Surgery":
  (CQMElements."Hospitalization Encounters"(
    CQMElements."Inpatient Encounter"
      union CQMElements."Observation Encounter"
      union CQMElements."Emergency Department Encounter"
      union CQMElements."Outpatient Surgery Encounter"
  )) HospitalizationEncounter
    where HospitalizationEncounter.type in CQMConcepts."Encounter Inpatient"
      and HospitalizationEncounter.period ends during day of "Measurement Period"
```

#### Hospitalization Period and Length Of Stay

The `hospitalization()` function returns the total interval from admission to discharge for the given encounter, from the start of the first included encounter to the end of the last included encounter in the hospitalization event.

The `hospitalizationLengthOfStay()` function returns the length of that interval in days, calculated with the `lengthInDays()` function (i.e. the difference in calendar days between the start and end of the interval):

```cql
define "Hospitalization Over 120 Days":
  "Hospitalization Encounter" HospitalizationEncounter
    where HospitalizationEncounter.hospitalizationLengthOfStay() > 120
```

#### Admission and Discharge Time

The `hospitalAdmissionTime()` and `hospitalDischargeTime()` functions return the beginning and ending of a hospitalization event, respectively. The admission time is the start of `hospitalization()`, i.e. the start of the first included encounter, and the discharge time is the end of the period of the "Hospitalization Encounter" itself.

#### Hospitalization Locations

The `hospitalizationLocations()` function returns all the `location` elements from all included encounters in a hospitalization event. This set is the basis for determining facility- and location-specific elements such as arrival and departure time.

The following functions return the same information as tuples across a list of "Hospitalization Encounters", which is useful when the logic needs to work with the locations directly:

* `"Encounter Location Entries"(encounters)` returns a tuple for each location entry of each hospitalization event, with the `encounterId` of the "Hospitalization Encounter", and the `location` (a reference), `status`, `physicalType`, and `period` of the entry.
* `"Encounter Locations"(encounters, locations)` returns the same tuples, with `location` resolved to the matching Location resource from the given list. Entries that reference a Location not in the list are dropped.
* `"Emergency Department Locations"(encounters, locations)` returns the `"Encounter Locations"` tuples for locations whose type is an emergency room or emergency trauma unit (the `ER` and `ETU` codes from the v3 RoleCode code system).

The `"All Encounter Location Entries"` and `"All Encounter Locations"` definitions apply these functions to the "Hospitalization Encounters" for all of the patient's encounters (and, for `"All Encounter Locations"`, all available Location resources).

```cql
define "Hospitalization Emergency Department Locations":
  CQMElements."Emergency Department Locations"("Hospitalization Encounter", [USQualityCore.Location])

define "First Emergency Department Arrival":
  First(
    "Hospitalization Emergency Department Locations" EDLocation
      sort by start of period
  )
```

#### Arrival and Departure Time

The `hospitalArrivalTime()` and `hospitalDepartureTime()` functions determine the earliest arrival and latest departure times for any location within any included encounter in a hospitalization event. Location entries are ordered by the start of their period, so the arrival time is the start of the first location entry and the departure time is the end of the last.

In addition, the `emergencyDepartmentArrivalTime()` function determines the earliest arrival to an emergency department location within a hospitalization event. This function resolves the location references against the available Location resources, and considers a location to be an emergency department if its type is an emergency room or emergency trauma unit (the `ER` and `ETU` codes from the v3 RoleCode code system), so Location resources must be available to the evaluation.

#### Intensive Care Unit

The `firstInpatientIntensiveCareUnit()` function returns the first location entry of the given encounter whose Location type is in the Intensive Care Unit value set and whose period is during the period of the encounter. Unlike the other functions in this section, it considers only the locations of the given encounter itself, not those of any included encounters, so it can be used with any encounter. Like `emergencyDepartmentArrivalTime()`, it requires Location resources to be available to the evaluation.

```cql
define "Hospitalization With Intensive Care Unit Stay":
  "Hospitalization Encounter" HospitalizationEncounter
    where HospitalizationEncounter.firstInpatientIntensiveCareUnit() is not null
```

#### Normalized Encounters

> NOTE: Normalized encounters are a draft feature being considered to help simplify hospitalization logic. The current best-practice approach is the `"Hospitalization Encounters"` function.

The `"Normalize Encounters"` function determines the same hospitalization periods as `"Hospitalization Encounters"`, but returns a new "normalized" encounter for each one, rather than the last encounter in the series. The normalized encounter has:

* An `id` equal to the `id` of the last included encounter plus `-primary`
* The same `status`, `class`, `type`, and `subject` as the last included encounter
* A `period` that spans from the start of the first included encounter to the end of the last included encounter
* All the locations from the included encounters
* The included encounters, accessible via the `includedEncounters()` function

Because the `period` of a normalized encounter covers the whole hospitalization event, logic can use it directly, rather than through the `hospitalization()` function:

```cql
define "Normalized Hospitalization":
  (CQMElements."Normalize Encounters"(
    CQMElements."Inpatient Encounter"
      union CQMElements."Observation Encounter"
      union CQMElements."Emergency Department Encounter"
  )) NormalizedEncounter
    where NormalizedEncounter.period ends during day of "Measurement Period"
```

#### Relationship to CQMCommon

The CQMCommon library defines functions with the same names that look up the immediately prior encounters themselves, rather than relying on a "Hospitalization Encounter". The CQMElements functions consider any number of consecutive encounters, but only those passed to `"Hospitalization Encounters"`:

| CQMCommon | CQMElements / CQMInferences |
|---|---|
| `"Inpatient Encounter"` (deprecated) | CQMInferences `"Inpatient Encounter During Measurement Period"` |
| `edVisit()` | `edVisit()` |
| `hospitalization()` | `hospitalization()`, with emergency department and inpatient encounters passed to `"Hospitalization Encounters"` |
| `hospitalizationWithObservation()` | `hospitalization()`, with emergency department, observation, and inpatient encounters passed to `"Hospitalization Encounters"` |
| `hospitalizationWithObservationAndOutpatientSurgeryService()` | `hospitalization()`, with outpatient surgery, emergency department, observation, and inpatient encounters passed to `"Hospitalization Encounters"` |
| `hospitalizationLengthOfStay()` | `hospitalizationLengthOfStay()` |
| `hospitalizationWithObservationLengthofStay()` | `hospitalizationLengthOfStay()`, with emergency department, observation, and inpatient encounters passed to `"Hospitalization Encounters"` |
| `hospitalizationLocations()` | `hospitalizationLocations()` |
| `hospitalAdmissionTime()`, `hospitalDischargeTime()` | `hospitalAdmissionTime()`, `hospitalDischargeTime()` |
| `hospitalArrivalTime()`, `hospitalDepartureTime()` | `hospitalArrivalTime()`, `hospitalDepartureTime()` |
| `emergencyDepartmentArrivalTime()` | `emergencyDepartmentArrivalTime()` |
| `firstInpatientIntensiveCareUnit()` | `firstInpatientIntensiveCareUnit()` |
{: .grid}

> NOTE: The CQMCommon `emergencyDepartmentArrivalTime()` tests the Location type against the Emergency Department Visit value set, which contains encounter type codes rather than location type codes. The CQMElements version tests for the `ER` and `ETU` location type codes instead.
