/*
@description: Common clinical inference and contextualization logic for use with quality measures.
@comment:

NOTE: This library is currently released in MADiE; this is a documentation copy
https://madie.cms.gov/cql-libraries/6ad8d1c1bf531c0659c86b7a/edit/details

NOTE: Development on this library occurs in the http://github.com/cqframework/dqm-content-cms-2026 
repository; this is a convenience copy only, do not make changes in this library.
*/
library CQMInferences version '0.3.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0'

include CQMElements version '0.3.000' called CQMElements

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

