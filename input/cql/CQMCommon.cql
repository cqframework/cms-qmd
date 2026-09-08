/*
@description: Common Functions for use in quality measures
*/
library CQMCommon version '5.1.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1' called FHIRHelpers
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0' called FHIRCommon
include hl7.fhir.us.cql.USCoreCommon version '2.0.0-ballot' called USCoreCommon
include hl7.fhir.us.cql.USCoreElements version '2.0.0-ballot' called USCoreElements

valueset "Emergency Department Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.292'
valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307'
valueset "Intensive Care Unit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.206'
valueset "Observation Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1111.143'
valueset "Outpatient Surgery Service": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.38'
valueset "Present on Admission or Clinically Undetermined": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1147.197'

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2026-01-01T00:00:00.000Z, @2027-01-01T00:00:00.000Z)

context Patient

define "Inpatient Encounter":
  [Encounter: "Encounter Inpatient"] EncounterInpatient
    where EncounterInpatient.status = 'finished'
      and EncounterInpatient.period ends during day of "Measurement Period"

/*
@description: Returns an interval of date values extracted from the input interval of date-time values
@comment: This function returns an interval constructed using the `date from` extractor on the start
and end values of the input date-time interval. Note that using a precision specifier such as `day of`
as part of a timing phrase is preferred to communicate intent to perform day-level comparison, as well
as for general readability.
*/
define fluent function toDateInterval(period Interval<DateTime>):
  Interval[date from start of period, date from end of period]

/*
@description: Calculates the difference in calendar days between the start and end of the given interval.
*/
define fluent function lengthInDays(Value Interval<DateTime> ):
  difference in days between start of Value and end of Value

/*
@description: Returns the most recent emergency department visit, if any, that occurs 1 hour or less prior to the given encounter.
*/
define fluent function edVisit(TheEncounter Encounter ):
  Last(
    [Encounter: "Emergency Department Visit"] EDVisit
      where EDVisit.status = 'finished'
        and EDVisit.period ends 1 hour or less on or before start of TheEncounter.period
      sort by end of period
    )

/*
@description: Hospitalization returns the total interval for admission to discharge for the given encounter, or for the admission of any immediately prior emergency department visit to the discharge of the given encounter.
*/
define fluent function hospitalization(TheEncounter Encounter ):
  (TheEncounter."edVisit"()) X
    return
        if X is null then TheEncounter.period
        else Interval[start of X.period, end of TheEncounter.period]

/*
@description: Returns list of all locations within an encounter, including locations for immediately prior ED visit.
*/
define fluent function hospitalizationLocations(TheEncounter Encounter ):
  ( TheEncounter."edVisit"()) EDEncounter
    return
        if EDEncounter is null then TheEncounter.location
        else flatten { EDEncounter.location, TheEncounter.location }

/*
@description: Returns the length of stay in days (i.e. the number of days between admission and discharge) for the given encounter, or from the admission of any immediately prior emergency department visit to the discharge of the encounter
*/
define fluent function hospitalizationLengthOfStay(TheEncounter Encounter ):
   TheEncounter."hospitalization"()."lengthInDays"()

/*
@description: Returns admission time for an encounter or for immediately prior emergency department visit.
*/
define fluent function hospitalAdmissionTime(TheEncounter Encounter ):
  start of (TheEncounter."hospitalization"())

/*
@description: Hospital Discharge Time returns the discharge time for an encounter
*/
define fluent function hospitalDischargeTime(TheEncounter Encounter ):
  end of TheEncounter.period

/*
@description: Returns earliest arrival time for an encounter including any prior ED visit.
*/
define fluent function hospitalArrivalTime(TheEncounter Encounter ):
  start of First(
  	    (TheEncounter."hospitalizationLocations"()) HospitalLocation
  			sort by start of period
  	).period

/*
@description: Returns the latest departure time for encounter including any prior ED visit.
*/
define fluent function hospitalDepartureTime(TheEncounter Encounter):
	end of Last(
	    (TheEncounter."hospitalizationLocations"()) HospitalLocation
			sort by start of period
	).period

/*
@description: Returns the emergency department arrival time for the encounter.
*/
define fluent function emergencyDepartmentArrivalTime(TheEncounter Encounter):
	start of (
	    singleton from (
	        ( (TheEncounter."hospitalizationLocations"()) ) HospitalLocation
				where HospitalLocation.location.getLocation().type in "Emergency Department Visit"
		)
	).period

/*
@description: Hospitalization with Observation and Outpatient Surgery Service returns the total interval from the start of any immediately prior emergency department visit, outpatient surgery visit or observation visit to the discharge of the given encounter.
*/
define fluent function hospitalizationWithObservationAndOutpatientSurgeryService(TheEncounter "Encounter" ):
  TheEncounter Visit
	  let ObsVisit: Last([Encounter: "Observation Services"] LastObs
		  	where LastObs.status = 'finished'
          and LastObs.period ends 1 hour or less on or before start of Visit.period
			  sort by	end of period
    	),
    	VisitStart: Coalesce(start of ObsVisit.period, start of Visit.period),
    	EDVisit: Last([Encounter: "Emergency Department Visit"] LastED
			  where LastED.status = 'finished'
          and LastED.period ends 1 hour or less on or before VisitStart
			  sort by	end of period
    	),
    	VisitStartWithED: Coalesce(start of EDVisit.period, VisitStart),
    	OutpatientSurgeryVisit: Last([Encounter: "Outpatient Surgery Service"] LastSurgeryOP
			  where LastSurgeryOP.period ends 1 hour or less on or before VisitStartWithED
			  sort by	end of period
    	)
  	return Interval[Coalesce(start of OutpatientSurgeryVisit.period, VisitStartWithED), end of Visit.period]

/*
@description: Hospitalization with Observation returns the total interval from the start of any immediately prior emergency department visit through the observation visit to the discharge of the given encounter
*/
define fluent function hospitalizationWithObservation(TheEncounter Encounter ):
  TheEncounter Visit
  		let ObsVisit: Last([Encounter: "Observation Services"] LastObs
  				where LastObs.status = 'finished'
            and LastObs.period ends 1 hour or less on or before start of Visit.period
  				sort by end of period
  			),
  			VisitStart: Coalesce(start of ObsVisit.period, start of Visit.period),
  			EDVisit: Last([Encounter: "Emergency Department Visit"] LastED
  				where LastED.status = 'finished'
            and LastED.period ends 1 hour or less on or before VisitStart
  				sort by end of period
  			)
  		return Interval[Coalesce(start of EDVisit.period, VisitStart), end of Visit.period]

/*
@description: Hospitalization with Observation Length of Stay returns the length in days from the start of any immediately prior emergency department visit through the observation visit to the discharge of the given encounter
*/
define fluent function hospitalizationWithObservationLengthofStay(TheEncounter "Encounter" ):
  ((TheEncounter."hospitalizationWithObservation"()."lengthInDays"()))

/*
@description: First Inpatient Intensive Care Unit returns the first intensive care unit for the given encounter, without considering any immediately prior emergency department visit.
*/
define fluent function firstInpatientIntensiveCareUnit(Encounter Encounter ):
  First((Encounter.location)HospitalLocation
  			where HospitalLocation.location.getLocation().type in "Intensive Care Unit"
  				and HospitalLocation.period during Encounter.period
  			sort by start of period
  	)

/*  
@description: Returns the Condition resources referenced by the diagnosis element of the Encounter  
*/
define fluent function encounterDiagnosis(Encounter Encounter ):
  Encounter.reasonReference D
    return singleton from (([ConditionEncounterDiagnosis] union [ConditionProblemsHealthConcerns]) C where D.references(C.id))


/*
@description: Returns the Condition resource for the given reference
*/
define fluent function getCondition(reference Reference):
  singleton from (([ConditionEncounterDiagnosis] union [ConditionProblemsHealthConcerns]) C where reference.references(C.id))

/*
@description: Returns the Location resource specified by the given reference.
*/
define fluent function getLocation(reference Reference):
  singleton from (
    [Location] L where reference.references(L)
  )

/*
@description: Returns the Procedure resource specified by the given reference.
@comment: Claim.procedure.procedure and Encounter.diagnosis.condition may both reference a Procedure,
so a procedure counterpart to getCondition is needed to resolve them.
*/
define fluent function getProcedure(reference Reference):
  singleton from (
    [Procedure] P where reference.references(P)
  )

/*
@description: Returns the medication code for the given MedicationRequest
*/
define fluent function getMedicationCode(request Choice<MedicationAdministration, MedicationRequest>):
  if request.medication is FHIR.CodeableConcept then
  	  request.medication as FHIR.CodeableConcept
  	else
  	  (singleton from ([Medication] M where request.medication.references(M))).code
  	  
    
