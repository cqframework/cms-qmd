/*
@description: Common clinical inference and contextualization logic for use with quality measures.
@comment:

NOTE: This library is developed in the dqm-content-cms-2026 repository:
https://github.com/cqframework/dqm-content-cms-2026/blob/main/input/cql/CQMInferences.cql

NOTE: This library is currently released in MADiE; this is the development copy
https://madie.cms.gov/cql-libraries/6add150747322f9f948a3dcf/edit/details
*/
library CQMInferences version '0.4.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0'

include CQMElements version '0.4.000' called CQMElements

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2026-01-01T00:00:00.000Z, @2027-01-01T00:00:00.000Z)

context Patient

define "Inpatient Encounter During Measurement Period":
  CQMElements."Inpatient Encounter" EncounterInpatient
    where EncounterInpatient.period ends during day of "Measurement Period"

define "Emergency Department Encounter During Measurement Period":
  CQMElements."Emergency Department Encounter" EncounterEmergency
    where EncounterEmergency.period ends during day of "Measurement Period"

define "Observation Encounter During Measurement Period":
  CQMElements."Observation Encounter" EncounterObservation
    where EncounterObservation.period ends during day of "Measurement Period"

define "Outpatient Surgery Encounter During Measurement Period":
  CQMElements."Outpatient Surgery Encounter" OutpatientSurgery
    where OutpatientSurgery.period ends during day of "Measurement Period"

