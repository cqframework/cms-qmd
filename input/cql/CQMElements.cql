/*
@description: Common data elements for use with clinical quality measures
*/
library CQMElements version '0.2.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0'

include CQMConcepts version '0.2.000'

context Patient

define "Inpatient Encounter":
  [Encounter: CQMConcepts."Encounter Inpatient"] EncounterInpatient
    where EncounterInpatient.status = 'finished'

