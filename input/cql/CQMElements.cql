/*
@description: Common data elements for use with clinical quality measures
@comment: 

NOTE: This library is developed in the dqm-content-cms-2026 repository:
https://github.com/cqframework/dqm-content-cms-2026/blob/main/input/cql/CQMElements.cql

NOTE: This library is currently released in MADiE; this is the development copy
https://madie.cms.gov/cql-libraries/6add14ea47322f9f948a3dcd/edit/details
*/
library CQMElements version '0.4.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0'

include CQMConcepts version '0.4.000'
include FHIRBuilders version '0.1.000' called Build

context Patient

define "Inpatient Encounter":
  [USQualityCore.Encounter: CQMConcepts."Encounter Inpatient"] EncounterInpatient
    where EncounterInpatient.status = 'finished'

define "Emergency Department Encounter":
  [USQualityCore.Encounter: CQMConcepts."Emergency Department Visit"] EncounterEmergency
    where EncounterEmergency.status = 'finished'

define "Observation Encounter":
  [USQualityCore.Encounter: CQMConcepts."Observation Services"] EncounterObservation
    where EncounterObservation.status = 'finished'

define "Outpatient Surgery Encounter":
  [USQualityCore.Encounter: CQMConcepts."Outpatient Surgery Service"] OutpatientSurgery
    where OutpatientSurgery.status = 'finished'

/*
@description: For a given set of encounters, returns the "hospitalization" encounter for the hospitalization periods represented.
@comment: This function finds the set of hospitalization periods, defined as any set of encounters that occur within an
hour of the end of the previous encounter. For each such period, the "hospitalization" encounter is returned that is the last
encounter in the series of consecutive encounters. All the included encounters are preserved in order as contained
encounters.
*/
define function "Hospitalization Encounters"(encounters List<USQualityCore.Encounter>):
  (collapse ( encounters E return Interval[start of E.period - 1 hour, end of E.period] )) NormalizedPeriod
    let 
      includedEncounters: (
        encounters N
          where N.period during NormalizedPeriod
          sort by start of period
      ),
      hospitalizationEncounter: Last(includedEncounters)
    return USQualityCore.Encounter {
      id: hospitalizationEncounter.id,
      meta: hospitalizationEncounter.meta,
      contained: includedEncounters,
      extension: 
        includedEncounters IE
          return FHIR.Extension {
            url: Build.uri('http://cql.hl7.org/transient/StructureDefinition/includedEncounter'),
            value: FHIR.Reference { reference: Build.string('#' + IE.id) }
          },
      identifier: hospitalizationEncounter.identifier,
      status: hospitalizationEncounter.status,
      statusHistory: hospitalizationEncounter.statusHistory,
      class: hospitalizationEncounter.class,
      classHistory: hospitalizationEncounter.classHistory,
      type: hospitalizationEncounter.type,
      serviceType: hospitalizationEncounter.serviceType,
      priority: hospitalizationEncounter.priority,
      subject: hospitalizationEncounter.subject,
      episodeOfCare: hospitalizationEncounter.episodeOfCare,
      basedOn: hospitalizationEncounter.basedOn,
      participant: hospitalizationEncounter.participant,
      appointment: hospitalizationEncounter.appointment,
      period: hospitalizationEncounter.period,
      length: hospitalizationEncounter.length,
      reasonCode: hospitalizationEncounter.reasonCode,
      reasonReference: hospitalizationEncounter.reasonReference,
      diagnosis: hospitalizationEncounter.diagnosis,
      account: hospitalizationEncounter.account,
      hospitalization: hospitalizationEncounter.hospitalization,
      location: hospitalizationEncounter.location,
      serviceProvider: hospitalizationEncounter.serviceProvider,
      partOf: hospitalizationEncounter.partOf
    }


/*
@description: For a given set of encounters, returns normalized encounters that encompass the hospitalization periods represented.
@comment: This function finds the set of hospitalization periods, defined as any set of encounters that occur within an hour of the 
end of the previous encounter. For each such period, a "normalized" encounter is return that starts at the beginning of the first
encounter during the interval, and ends at the end of the last encounter during the interval. All the included encounters are preserved 
in order as contained encounters.

The normalized encounter has:
* An `id` equal to the last included encounter plus the `-primary`
* The same status, class, type, and subject as the last included encounter
* A period that spans from the start of the first included encounter to the end of the last included encounter
* All the locations from the included encounters

NOTE: Normalized encounters are a draft feature being considered to help simplify hospitalization logic. The current best-practice 
approach is the "Hospitalization Encounters" function.
*/
define function "Normalize Encounters"(encounters List<USQualityCore.Encounter>):
  (collapse ( encounters E return Interval[start of E.period - 1 hour, end of E.period] )) NormalizedPeriod
    let 
      includedEncounters: (
        encounters N
          where N.period during NormalizedPeriod
          sort by start of period
      ),
      primaryEncounter: Last(includedEncounters)
    return USQualityCore.Encounter {
      id: Build.id(primaryEncounter.id + '-primary'),
      status: primaryEncounter.status,
      // statusHistory?
      class: primaryEncounter.class, // TODO: Map to class based on encounter type if not present?
      // classHistory?
      type: primaryEncounter.type, // Include types from all includedEncounters?
      subject: primaryEncounter.subject,
      // participant?
      period: Build.Period(Interval[start of First(includedEncounters).period, end of primaryEncounter.period]),
      // length: ? Sum of included durations?
      // reasonCode: ? All included reasonCode?
      // reasonReference: ? Challenging, because of the reference
      // diagnosis (condition, use, rank): ?
      // hospitalization (origin, admitSource, dischargeDisposition)
      location: flatten ( includedEncounters IE return all IE.location ),
      contained: includedEncounters,
      extension: 
        includedEncounters IE
          return FHIR.Extension {
            url: Build.uri('http://cql.hl7.org/transient/StructureDefinition/includedEncounter'),
            value: FHIR.Reference { reference: Build.string('#' + IE.id) }
          }
    }

define fluent function includedEncounters(encounter USQualityCore.Encounter):
  (encounter.exts('http://cql.hl7.org/transient/StructureDefinition/includedEncounter')) E
    return singleton from (
      encounter.contained C
        where C is FHIR.Encounter
          and '#' + C.id = (E.value as FHIR.Reference).reference
        return C as USQualityCore.Encounter
    )

define "All Encounter Location Entries":
  "Encounter Location Entries"("Hospitalization Encounters"([USQualityCore.Encounter]))

define function "Encounter Location Entries"(encounters List<USQualityCore.Encounter>):
  flatten (
    encounters E
      return 
        (E.hospitalizationLocations()) EL
          return {
            encounterId: E.id,
            location: EL.location,
            status: EL.status,
            physicalType: EL.physicalType,
            period: EL.period
          }
  )

define "All Encounter Locations":
  "Encounter Locations"(
    "Hospitalization Encounters"([USQualityCore.Encounter]),
    [USQualityCore.Location]
  )

define function "Encounter Locations"(encounters List<USQualityCore.Encounter>, locations List<USQualityCore.Location>):
  from
      ("Encounter Location Entries"(encounters)) EL,
      locations L
    where EL.location.references(L)
    return {
      encounterId: EL.encounterId,
      location: L,
      status: EL.status,
      physicalType: EL.physicalType,
      period: EL.period
    }

define function "Emergency Department Locations"(encounters List<USQualityCore.Encounter>, locations List<USQualityCore.Location>):
  ("Encounter Locations"(encounters, locations)) EL
    where EL.location.type.includesCode(CQMConcepts."Emergency room") 
      or EL.location.type.includesCode(CQMConcepts."Emergency trauma unit")

/*
@description: Returns the most recent emergency department visit, if any, that occurs 
1 hour or less prior to the given encounter.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function edVisit(encounter USQualityCore.Encounter ):
  Last(
    (encounter.includedEncounters()) IncludedEncounter
      where IncludedEncounter.type in CQMConcepts."Emergency Department Visit"
        and IncludedEncounter.status = 'finished'
  )

/*
@description: Returns the most recent emergency department visit, if any, that occurs 
1 hour or less prior to the given encounter.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function observationVisit(encounter USQualityCore.Encounter ):
  Last(
    (encounter.includedEncounters()) IncludedEncounter
      where IncludedEncounter.type in CQMConcepts."Observation Services"
        and IncludedEncounter.status = 'finished'
  )

/*
@description: Returns the most recent emergency department visit, if any, that occurs 
1 hour or less prior to the given encounter.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function outpatientSurgeryVisit(encounter USQualityCore.Encounter ):
  Last(
    (encounter.includedEncounters()) IncludedEncounter
      where IncludedEncounter.type in CQMConcepts."Outpatient Surgery Service"
        and IncludedEncounter.status = 'finished'
  )

/*
@description: Hospitalization returns the total interval for admission to discharge 
for the given encounter, including any immediately prior encounters.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function hospitalization(encounter USQualityCore.Encounter):
  encounter X
    let encounters: X.includedEncounters()
    return Interval[start of First(encounters).period, end of Last(encounters).period]

/*
@description: Returns list of all locations within an encounter, including locations 
for immediately prior encounters.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function hospitalizationLocations(encounter USQualityCore.Encounter):
  flatten ((encounter.includedEncounters()) IE return all IE.location)

/*
@description: Returns the length of stay in days (i.e. the number of days between 
admission and discharge) for the given encounter, or from the admission of any 
immediately prior encounters, to the discharge of the encounter
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function hospitalizationLengthOfStay(encounter USQualityCore.Encounter):
   encounter.hospitalization().lengthInDays()

/*
@description: Returns admission time for an encounter or for immediately prior encounters.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function hospitalAdmissionTime(encounter USQualityCore.Encounter):
  start of (encounter."hospitalization"())

/*
@description: Hospital Discharge Time returns the discharge time for an encounter
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function hospitalDischargeTime(encounter USQualityCore.Encounter):
  end of encounter.period

/*
@description: Returns earliest arrival time for an encounter including any prior ED visit.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function hospitalArrivalTime(encounter USQualityCore.Encounter):
  start of First(
    (encounter.hospitalizationLocations()) HospitalLocation
			sort by start of period
	).period

/*
@description: Returns the latest departure time for encounter including any prior ED visit.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.
*/
define fluent function hospitalDepartureTime(encounter USQualityCore.Encounter):
	end of Last(
    (encounter.hospitalizationLocations()) HospitalLocation
      sort by start of period
	).period

/*
@description: Returns the emergency department arrival time for the encounter.
@comment: This function is expected to be used on Encounter resources returned from the 
Hospitalization Encounters function, so that the included encounters have been computed.

Alternatively, this can be determined by accessing the first location returned from
the "Emergency Department Locations" function, sorted by location period.
*/
define fluent function emergencyDepartmentArrivalTime(encounter USQualityCore.Encounter):
  start of (
    First(
      (encounter.hospitalizationLocations()) HospitalLocation
			  with [Location] Location
			    such that HospitalLocation.location.references(Location)
				  and (
            Location.type.includesCode(CQMConcepts."Emergency room")
              or Location.type.includesCode(CQMConcepts."Emergency trauma unit")
          )
        sort by start of period
		)
	).period

/*
@description: First Inpatient Intensive Care Unit returns the first intensive care unit for the given encounter, without considering any immediately prior encounters.
*/
define fluent function firstInpatientIntensiveCareUnit(encounter USQualityCore.Encounter):
  First(
    encounter.location HospitalLocation
      with [Location] Location 
        such that HospitalLocation.location.references(Location) 
          and Location.type in CQMConcepts."Intensive Care Unit"
      where HospitalLocation.period during encounter.period
      sort by start of period
  )
