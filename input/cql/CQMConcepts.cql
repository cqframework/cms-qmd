/*
@description: Common terminology and accessor declarations for use with clinical quality measures

@comment: In addition to the terminology used across measures, this library supplies accessor functions
for the profile slices that the QICore 6.0.0 model info exposed as named model elements, but that the 
USQualityCore 0.5.0 and USCore 6.1.0-derived model infos do not. See the 
[Slice Index](refactored_index.html#slice-index) for the full inventory. The extension-backed slices 
are covered by FHIRCommon, USCoreCommon, and USQualityCoreCommon; what is drafted here are the value- 
and pattern-discriminated slices that no published library reaches.

Each function is annotated with the library it is being proposed for. The `hasCategory()` overloads and
the DiagnosticReport laboratory predicate are not US-specific and are proposed for FHIRCommon, following
the conventions it already uses for Condition, Observation, and MedicationRequest. The US Core slice
predicates and the Observation component accessors are proposed for USCoreCommon, and the identifier
accessors for USCoreElements, which already reads Coverage and Patient identifiers by type. The `ccn`
and `ein` identifier slices are QI Core additions carried into US Quality Core rather than US Core
content, so those are proposed for USQualityCoreCommon. These definitions live here only until those
proposals are accepted.

Slices discriminated by value set membership rather than by a fixed coding - the `us-core`
category slices on DiagnosticReport and ServiceRequest - have no single meaning to name, so no predicate
is drafted for them. Use the `hasCategory()` overload with the specific code instead. The
`screening-assessment` slices are also value set discriminated, but the value set itself carries the
meaning, so `isScreeningAssessment()` is drafted for those.

NOTE: This library is developed in the dqm-content-cms-2026 repository:
https://github.com/cqframework/dqm-content-cms-2026/blob/main/input/cql/CQMConcepts.cql

NOTE: This library is currently released in MADiE; this is the development copy
https://madie.cms.gov/cql-libraries/6add150147322f9f948a3dce/edit/details
*/
library CQMConcepts version '0.4.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1' called FHIRHelpers
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0' called FHIRCommon
include hl7.fhir.us.cql.USCoreCommon version '2.0.0' called USCoreCommon

valueset "Emergency Department Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.292'
valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307'
valueset "Intensive Care Unit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.206'
valueset "Observation Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1111.143'
valueset "Outpatient Surgery Service": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.38'

// Terminology for the slice accessors below. The discriminator for each slice is given in the
// description of the function that reads it.
// NOTE: Leaving these out for now to avoid the dependency on these value sets
//valueset "US Core Screening Assessment Condition Category": 'http://hl7.org/fhir/us/core/ValueSet/us-core-screening-assessment-condition-category'
//valueset "US Core Screening Assessment Observation Category": 'http://hl7.org/fhir/us/core/ValueSet/us-core-screening-assessment-observation-category'

codesystem "LOINC": 'http://loinc.org'
//codesystem "DiagnosticServiceSectionCodes": 'http://terminology.hl7.org/CodeSystem/v2-0074'

// NOTE: Leaving these out for now to avoid the dependency on these code systems
//codesystem "CoverageClassCodes": 'http://terminology.hl7.org/CodeSystem/coverage-class'
//codesystem "USCoreCarePlanCategoryCodes": 'http://hl7.org/fhir/us/core/CodeSystem/careplan-category'
//code "Coverage Class Group": 'group' from "CoverageClassCodes" display 'Group'
//code "Coverage Class Plan": 'plan' from "CoverageClassCodes" display 'Plan'
//code "Assess and Plan": 'assess-plan' from "USCoreCarePlanCategoryCodes" display 'Assess and Plan'

//code "Laboratory Service Section": 'LAB' from "DiagnosticServiceSectionCodes" display 'Laboratory'
code "Oxygen Saturation in Arterial Blood by Pulse Oximetry": '59408-5' from "LOINC" display 'Oxygen saturation in Arterial blood by Pulse oximetry'
code "Oxygen Saturation in Arterial Blood": '2708-6' from "LOINC" display 'Oxygen saturation in Arterial blood'
code "Inhaled Oxygen Flow Rate": '3151-8' from "LOINC" display 'Inhaled oxygen flow rate'
code "Inhaled Oxygen Concentration": '3150-0' from "LOINC" display 'Inhaled oxygen concentration'
code "History of Occupation Industry": '86188-0' from "LOINC" display 'History of Occupation industry'

// Note that the identifier slices below are discriminated by `identifier.system`, which is a uri rather
// than a coded element, so those systems are compared as string literals in the functions themselves
// rather than declared as terminology here.

codesystem "HSLOC": 'https://www.cdc.gov/nhsn/cdaportal/terminology/codesystem/hsloc.html'
codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'
codesystem "RoleCode": 'http://terminology.hl7.org/CodeSystem/v3-RoleCode'

code "EMER": 'EMER' from "ActCode" display 'emergency'
code "Emergency room": 'ER' from "RoleCode" display 'Emergency room'
code "Emergency trauma unit": 'ETU' from "RoleCode" display 'Emergency trauma unit'

context Patient

/*
@description: Returns an interval of date values extracted from the input interval of date-time values
@comment: This function returns an interval constructed using the `date from` extractor on the start
and end values of the input date-time interval. Note that using a precision specifier such as `day of`
as part of a timing phrase is preferred to communicate intent to perform day-level comparison, as well
as for general readability.

An unknown boundary (an open null boundary, for which `start of` or `end of` returns null) stays unknown
in the result. An interval selector always has fixed closedness, so constructing the result with closed
boundaries would turn an unknown boundary into an unbounded one.
*/
define fluent function toDateInterval(period Interval<DateTime>):
  case
    when period is null then null
    when start of period is null and end of period is null then Interval(null as Date, null as Date)
    when start of period is null then Interval(null as Date, date from end of period]
    when end of period is null then Interval[date from start of period, null as Date)
    else Interval[date from start of period, date from end of period]
  end

/*
@description: Calculates the difference in calendar days between the start and end of the given interval.
*/
define fluent function lengthInDays(Value Interval<DateTime> ):
  difference in days between start of Value and end of Value

// Category accessors
//
// FHIRCommon defines hasCategory() for Condition, Observation, and MedicationRequest, but not for
// CarePlan, DiagnosticReport, or ServiceRequest, all three of which slice category in US Core and
// US Quality Core. The overloads below fill that gap, following the FHIRCommon pattern exactly.

/*
@description: Returns true if the given care plan has the given category
@comment: Reads `CarePlan.category`, which US Core slices as `CarePlan.category:AssessPlan`.
Proposed for inclusion in FHIRCommon.
*/
define fluent function hasCategory(carePlan FHIR.CarePlan, category Code):
  exists (carePlan.category C
    where C ~ category
  )

/*
@description: Returns true if the given diagnostic report has the given category
@comment: Reads `DiagnosticReport.category`, which US Core slices as
`DiagnosticReport.category:LaboratorySlice` on the laboratory profile and
`DiagnosticReport.category:us-core` on the note profile. The `us-core` slice is discriminated by
membership in the `us-core-diagnosticreport-category` value set rather than by a fixed coding, so it is
reached with this function and the specific code of interest.
Proposed for inclusion in FHIRCommon.
*/
define fluent function hasCategory(diagnosticReport FHIR.DiagnosticReport, category Code):
  exists (diagnosticReport.category C
    where C ~ category
  )

/*
@description: Returns true if the given service request has the given category
@comment: Reads `ServiceRequest.category`, which US Core slices as `ServiceRequest.category:us-core`.
That slice is discriminated by membership in the `us-core-servicerequest-category` value set rather than
by a fixed coding, so it is reached with this function and the specific code of interest.
Proposed for inclusion in FHIRCommon.
*/
define fluent function hasCategory(serviceRequest FHIR.ServiceRequest, category Code):
  exists (serviceRequest.category C
    where C ~ category
  )

/*
@description: Returns true if the given diagnostic report is a laboratory report
@comment: Tests for the fixed coding `http://terminology.hl7.org/CodeSystem/v2-0074#LAB` that
discriminates `DiagnosticReport.category:LaboratorySlice` in US Core. This is the DiagnosticReport
counterpart of the FHIRCommon `isLaboratory(Observation)` predicate, and the coding is base FHIR
terminology rather than US Core terminology.
Proposed for inclusion in FHIRCommon.

NOTE: Leaving this out for now, submit a CQLIT ticket if this is required for measure logic
*/
//define fluent function isLaboratory(diagnosticReport FHIR.DiagnosticReport):
//  exists (diagnosticReport.category C
//    where C ~ "Laboratory Service Section"
//  )

/*
@description: Returns true if the given care plan is an assessment and plan of treatment
@comment: Tests for the fixed coding
`http://hl7.org/fhir/us/core/CodeSystem/careplan-category#assess-plan` that discriminates
`CarePlan.category:AssessPlan`. The slice is 1..1 in US Core, so every conforming CarePlan satisfies
this predicate; it is defined for logic that reads CarePlan resources that may not be US Core conformant.
Proposed for inclusion in USCoreCommon.

NOTE: Leaving this out for now. If this function is required for measure logic, submit a CQLIT ticket.
*/
//define fluent function isAssessPlan(carePlan FHIR.CarePlan):
//  carePlan.hasCategory("Assess and Plan")

/*
@description: Returns true if the given condition is a screening or assessment condition
@comment: Tests membership in the `us-core-screening-assessment-condition-category` value set, which is
the discriminator for `Condition.category:screening-assessment`. This is the counterpart of the
FHIRCommon `isProblemListItem()` and `isEncounterDiagnosis()` predicates and the USCoreCommon
`isHealthConcern()` predicate, which together cover the remaining Condition category slices.
Proposed for inclusion in USCoreCommon.

NOTE: Leaving this out for now to avoid dependency on US Core value sets. Submit a CQLIT issue if
this function is needed in measure logic.
*/
//define fluent function isScreeningAssessment(condition FHIR.Condition):
//  exists (condition.category C
//    where C in "US Core Screening Assessment Condition Category"
//  )

/*
@description: Returns true if the given observation is a screening or assessment observation
@comment: Tests membership in the `us-core-screening-assessment-observation-category` value set, which is
the discriminator for `Observation.category:screening-assessment`. The other category slice on that
profile, `Observation.category:survey`, is covered by the FHIRCommon `isSurvey()` predicate.
Proposed for inclusion in USCoreCommon.

NOTE: Leaving this out for now to avoid dependency on US Core value sets. Submit a CQLIT issue if
this function is needed in measure logic.
*/
//define fluent function isScreeningAssessment(observation FHIR.Observation):
//  exists (observation.category C
//    where C in "US Core Screening Assessment Observation Category"
//  )

// Observation component and code accessors
//
// USCoreCommon defines systolic() and diastolic() for the blood pressure component slices, but nothing
// equivalent for the pulse oximetry or occupation component slices. The accessors below follow the same
// shape, and are named for the slice they read.

/*
@description: Returns the single inhaled oxygen flow rate component of the given pulse oximetry observation
@comment: Reads `Observation.component:FlowRate`, discriminated by the fixed coding
`http://loinc.org#3151-8`. This function returns `null` if there is no such component, and will throw an
error if there is more than one, matching the behavior of the USCoreCommon `systolic()` and `diastolic()`
functions.
Proposed for inclusion in USCoreCommon.
*/
define fluent function flowRate(pulseOximetry FHIR.Observation):
  singleton from (
    pulseOximetry.component C
      where C.code ~ "Inhaled Oxygen Flow Rate"
  )

/*
@description: Returns the single inhaled oxygen concentration component of the given pulse oximetry observation
@comment: Reads `Observation.component:Concentration`, discriminated by the fixed coding
`http://loinc.org#3150-0`. This function returns `null` if there is no such component, and will throw an
error if there is more than one.
Proposed for inclusion in USCoreCommon.
*/
define fluent function concentration(pulseOximetry FHIR.Observation):
  singleton from (
    pulseOximetry.component C
      where C.code ~ "Inhaled Oxygen Concentration"
  )

/*
@description: Returns the single industry component of the given occupation observation
@comment: Reads `Observation.component:industry`, discriminated by the fixed coding
`http://loinc.org#86188-0`. This function returns `null` if there is no such component, and will throw an
error if there is more than one.
Proposed for inclusion in USCoreCommon.
*/
define fluent function industry(occupation FHIR.Observation):
  singleton from (
    occupation.component C
      where C.code ~ "History of Occupation Industry"
  )

/*
@description: Returns true if the given observation is a pulse oximetry observation
@comment: The US Core pulse oximetry profile slices `Observation.code.coding` twice, requiring both
`http://loinc.org#59408-5` (the PulseOx slice) and `http://loinc.org#2708-6` (the O2Sat slice) to be
present. Neither slice is an accessor - together they identify the observation - so this predicate is
drafted in place of the two element accessors the QICore model info exposed.
Proposed for inclusion in USCoreCommon.
*/
define fluent function isPulseOximetry(observation FHIR.Observation):
  exists (observation.code.coding C
    where C ~ "Oxygen Saturation in Arterial Blood by Pulse Oximetry"
  )
    and exists (observation.code.coding C
      where C ~ "Oxygen Saturation in Arterial Blood"
    )

// Identifier and coverage class accessors
//
// USCoreElements reads Coverage and Patient identifiers by type with memberID(), policyNumber(), and
// medicalRecordNumber(), but nothing reads the identifier slices on Organization and Practitioner, which
// are discriminated by system, or the class slices on Coverage.

/*
@description: Returns the group identifier of the given coverage
@comment: Reads `Coverage.class:group`, discriminated by the fixed coding
`http://terminology.hl7.org/CodeSystem/coverage-class#group` on `Coverage.class.type`. The slice is
0..1, so this returns a single value or `null`.
Proposed for inclusion in USCoreElements.

NOTE: Leaving this out for now. If this function is required for measure logic, submit a CQLIT ticket.
*/
//define fluent function groupNumber(coverage FHIR.Coverage):
//  singleton from (
//    coverage."class" C
//      where C.type ~ "Coverage Class Group"
//  ).value

/*
@description: Returns the plan identifier of the given coverage
@comment: Reads `Coverage.class:plan`, discriminated by the fixed coding
`http://terminology.hl7.org/CodeSystem/coverage-class#plan` on `Coverage.class.type`. The slice is
0..1, so this returns a single value or `null`. Note that this is distinct from the USCoreElements
`policyNumber()` function, which reads `Coverage.identifier` by type rather than `Coverage.class`.
Proposed for inclusion in USCoreElements.

NOTE: Leaving this out for now. If this function is required for measure logic, submit a CQLIT ticket.
*/
//define fluent function planNumber(coverage FHIR.Coverage):
//  singleton from (
//    coverage."class" C
//      where C.type ~ "Coverage Class Plan"
//  ).value

/*
@description: Returns the National Provider Identifiers of the given organization
@comment: Reads `Organization.identifier:NPI`, discriminated by the identifier system
`http://hl7.org/fhir/sid/us-npi`. The slice is 0..*, so this returns a list.
Proposed for inclusion in USCoreElements.
*/
define fluent function npi(organization FHIR.Organization):
  organization.identifier I
    where I.system = 'http://hl7.org/fhir/sid/us-npi'
    return I.value

/*
@description: Returns the CLIA numbers of the given organization
@comment: Reads `Organization.identifier:CLIA`, discriminated by the identifier system
`urn:oid:2.16.840.1.113883.4.7`. The slice is 0..*, so this returns a list.
Proposed for inclusion in USCoreElements.
*/
define fluent function clia(organization FHIR.Organization):
  organization.identifier I
    where I.system = 'urn:oid:2.16.840.1.113883.4.7'
    return I.value

/*
@description: Returns the NAIC codes of the given organization
@comment: Reads `Organization.identifier:NAIC`, discriminated by the identifier system
`urn:oid:2.16.840.1.113883.6.300`. The slice is 0..*, so this returns a list.
Proposed for inclusion in USCoreElements.
*/
define fluent function naic(organization FHIR.Organization):
  organization.identifier I
    where I.system = 'urn:oid:2.16.840.1.113883.6.300'
    return I.value

/*
@description: Returns the National Provider Identifiers of the given practitioner
@comment: Reads `Practitioner.identifier:NPI`, discriminated by the identifier system
`http://hl7.org/fhir/sid/us-npi`. The slice is 0..*, so this returns a list.
Proposed for inclusion in USCoreElements.
*/
define fluent function npi(practitioner FHIR.Practitioner):
  practitioner.identifier I
    where I.system = 'http://hl7.org/fhir/sid/us-npi'
    return I.value

/*
@description: Returns the CMS Certification Number of the given organization
@comment: Reads `Organization.identifier:ccn`, discriminated by the identifier system
`http://terminology.hl7.org/NamingSystem/CMSCertificationNumber`. The slice is 0..1, so this returns a
single value or `null`. This slice is a QI Core addition carried into US Quality Core rather than
US Core content.
Proposed for inclusion in USQualityCoreCommon.
*/
define fluent function ccn(organization FHIR.Organization):
  singleton from (
    organization.identifier I
      where I.system = 'http://terminology.hl7.org/NamingSystem/CMSCertificationNumber'
  ).value

/*
@description: Returns the Employer Identification Number of the given organization
@comment: Reads `Organization.identifier:ein`, discriminated by the identifier system
`urn:oid:2.16.840.1.113883.4.4`. The slice is 0..1, so this returns a single value or `null`. This slice
is a QI Core addition carried into US Quality Core rather than US Core content.
Proposed for inclusion in USQualityCoreCommon.
*/
define fluent function ein(organization FHIR.Organization):
  singleton from (
    organization.identifier I
      where I.system = 'urn:oid:2.16.840.1.113883.4.4'
  ).value

/*
@description: Returns the Employer Identification Number of the given practitioner
@comment: Reads `Practitioner.identifier:ein`, discriminated by the identifier system
`urn:oid:2.16.840.1.113883.4.4`. The slice is 0..1, so this returns a single value or `null`. Note that
US Quality Core slices only EIN here; there is no general Tax Identifier Number system, and no SSN,
PTIN, or ITIN slice is declared.
Proposed for inclusion in USQualityCoreCommon.
*/
define fluent function ein(practitioner FHIR.Practitioner):
  singleton from (
    practitioner.identifier I
      where I.system = 'urn:oid:2.16.840.1.113883.4.4'
  ).value

/*
@description: Returns true if the given condition is referenced as a reason for the given encounter
@comment: This function is a candidate for promotion to FHIRCommon.
*/
define fluent function isReasonForVisit(condition FHIR.Condition, encounter FHIR.Encounter):
  encounter.reasonReference.references(condition)

/*
@description: Returns a DateTime interval from start to end, with active (i.e. ongoing) semantics 
as determined by the active parameter.
@comment: The interval returned will be closed unless isActive is false and the end date is null.
These semantics ensure that an unknown ending boundary is preserved. Note that this is not possible
to represent in FHIR so conversion of an interval with an unknown ending boundary (i.e. null and 
open) to a FHIR.Period should raise an error, not silently fail.

As well, if isActive is true, the end date is ignored, as an "active" period is one that is ongoing.

NOTE: This function is being promoted to FHIRCommon in 3.0.0
*/
define function Period(start System.DateTime, end System.DateTime, isActive System.Boolean):
  if isActive or end is not null then
    Interval[start, if isActive then null else end]
  else
    Interval[start, end)

/*
@description: Returns an interval representing the normalized prevalence period of a given Condition resource.
@comment: Uses the toInterval and abatementInterval functions to determine the widest potential interval from
onset to abatement as specified in the given Condition.

NOTE: The prevalenceInterval function in FHIRCommon 2.0.0 has a known issue (https://jira.hl7.org/browse/FHIR-59708). 
This function addresses that issue. The correction to prevalenceInterval is being added to FHIRCommon 3.0.0.
*/
define fluent function prevalencePeriod(condition FHIR.Condition):
  Period(
    start of condition.onset.toInterval(),
    end of condition.abatementInterval(),
    condition.isActive()
  )

/*
@description: Relevant date for a condition, either the onset, asserted date, or recorded date, whichever is available
@comment: This function returns the _relevant date_ for a given condition, which is determined by the first available date of:

* earliest onset date
* asserted date
* recorded date

NOTE: This function is being promoted to FHIRCommon in 3.0.0
*/
define fluent function relevantDate(condition FHIR.Condition):
  Coalesce(
    start of condition.onset.toInterval(),
    condition.assertedDate(),
    condition.recordedDate
  )

/*
@description: Returns the relevant period for a condition, from relevant date through abatement
@comment: This function returns a date time interval from the condition relevant date (as determined
using the `relevantDate()` function) through the end of the condition abatement interval (as 
determined using the `abatementInterval()` function). The resulting interval will have an open
ending boundary only if the condition is not active (as determined by the `isActive()` function)
and the abatement end date is null.

NOTE: This function is being promoted to FHIRCommon in 3.0.0
*/
define fluent function relevantPeriod(condition FHIR.Condition):
  Period(
    condition.relevantDate(),
    end of condition.abatementInterval(),
    condition.isActive()
  )

/*
@description: Returns an interval representing the normalized prevalence period of a given AllergyIntolerance resource.
@comment: Uses the toInterval and abatementInterval functions to determine the widest potential interval from
onset to abatement as specified in the given AllergyIntolerance.

NOTE: The prevalenceInterval function in FHIRCommon 2.0.0 has a known issue (https://jira.hl7.org/browse/FHIR-59708). 
This function addresses that issue. The correction to prevalenceInterval is being added to FHIRCommon 3.0.0.
*/
define fluent function prevalencePeriod(allergyIntolerance FHIR.AllergyIntolerance):
  Period(
    start of allergyIntolerance.onset.toInterval(),
    end of allergyIntolerance.abatementInterval(),
    allergyIntolerance.isActive()
  )

/*
@description: Relevant date for an allergy/intolerance, either the onset, asserted date, or recorded date, whichever is available
@comment: This function returns the _relevant date_ for a given allergy/intolerance, which is determined by the first available date of:

* earliest onset date
* asserted date
* recorded date

NOTE: This function is being promoted to FHIRCommon in 3.0.0
*/
define fluent function relevantDate(allergyIntolerance FHIR.AllergyIntolerance):
  Coalesce(
    start of allergyIntolerance.onset.toInterval(),
    allergyIntolerance.assertedDate(),
    allergyIntolerance.recordedDate
  )

/*
@description: Returns the relevant period for an allergy/intolerance, from relevant date through abatement
@comment: This function returns a date time interval from the allergy/intolerance relevant date (as determined
using the `relevantDate()` function) through the end of the allergy/intolerance abatement interval (as 
determined using the `abatementInterval()` function). The resulting interval will have an open
ending boundary only if the allergy/intolerance is not active (as determined by the `isActive()` function)
and the abatement end date is null.

NOTE: This function is being promoted to FHIRCommon in 3.0.0
*/
define fluent function relevantPeriod(allergyIntolerance FHIR.AllergyIntolerance):
  Period(
    allergyIntolerance.relevantDate(),
    end of allergyIntolerance.abatementInterval(),
    allergyIntolerance.isActive()
  )

