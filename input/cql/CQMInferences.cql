/*
@description: Common clinical inference and contextualization logic for use with quality measures.
*/
library CQMInferences version '0.1.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0'

include CQMElements version '0.1.000' called CQMElements

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2026-01-01T00:00:00.000Z, @2027-01-01T00:00:00.000Z)

context Patient

define "Inpatient Encounter During Measurement Period":
  CQMElements."Inpatient Encounter" EncounterInpatient
    where EncounterInpatient.period ends during day of "Measurement Period"