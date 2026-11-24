/*
@description: Supplemental data elements for use in digital quality measure specifications in CMS programs

NOTE: This library is not published in this IG, it is included here for convenience. The source of truth for
this library will be the MADiE environment once it fully supports use of QICore STU6-derived.
*/
library SupplementalDataElements version '6.2.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1' called FHIRHelpers
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0' called FHIRCommon
include hl7.fhir.us.cql.USCoreCommon version '2.0.0' called USCommon

codesystem "SNOMEDCT": 'http://snomed.info/sct'

valueset "Ethnicity": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.837'
valueset "Federal Administrative Sex": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1021.121'
valueset "Payer Type": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3591'
valueset "Race": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.836'

code "Male (finding)": '248153007' from "SNOMEDCT" display 'Male (finding)'
code "Female (finding)": '248152002' from "SNOMEDCT" display 'Female (finding)'

context Patient

define "SDE Ethnicity":
  (Patient.ethnicity()) E
    return Tuple {
      codes: { E.ombCategory } union E.detailed,
      display: E.text
    }

define "SDE Payer":
  [USQualityCore.Coverage: type in "Payer Type"] Payer
    return {
      code: Payer.type,
      period: Payer.period
    }

define "SDE Race":
  (Patient.race()) R
    return Tuple {
      codes: R.ombCategory union R.detailed,
      display: R.text
    }

define "SDE Sex":
  case
    when Patient.sex() = '248153007' then "Male (finding)"
    when Patient.sex() = '248152002' then "Female (finding)"
    else null
  end