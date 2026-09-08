/*
@description: Status, use, and type functions for the FHIR Claim and ExplanationOfBenefit resources.

@comment: FHIRCommon defines status functions for Observation, Condition, and AllergyIntolerance, but
nothing equivalent for the financial resources. Logic that reaches into claim information therefore
repeats inline tests such as `C.status = 'active' and C.use = 'claim'`, which is both verbose and easy
to get wrong.

This library supplies those functions, following the conventions used in FHIRCommon: an `is` prefixed
predicate that operates on a single resource, and an unprefixed function of the same meaning that
filters a list. With one exception the functions here are universal realm, so the intent is to
propose them for inclusion in FHIRCommon; the library lives in this guide only until that happens.
See MedicationCommon for the equivalent proposal covering the medication resources.

The exception is isInpatient and isOutpatient, which test the CARIN Blue Button institutional claim
subtype and are therefore US Realm specific. They are grouped separately at the end of the library
and would need to be left behind, or rehomed in a US Realm library, if the rest is proposed upstream.

@comment: Element-level access to claim items, diagnoses, procedures, and supporting information is
in the ClaimElements library. This library is only concerned with selecting which Claim or
ExplanationOfBenefit resources should be considered in the first place.

@comment: An aggregate helper for the recurring combination - an active claim, with a use of claim,
of an institutional or professional type - is deliberately not defined here, for the same reason as
in MedicationCommon: naming it requires agreement on what it means. For now callers compose the
predicates, as in `C.isActive() and C.isClaim() and (C.isInstitutional() or C.isProfessional())`.
*/
library ClaimCommon version '0.1.0'

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

// Note that Claim and ExplanationOfBenefit do not share a status code system, though the codes in
// each are the same. The use and type code systems are shared, but do not share a base: use is
// defined in the FHIR code system space, type in the terminology space.
codesystem "ClaimStatusCodes": 'http://hl7.org/fhir/fm-status'
codesystem "ExplanationOfBenefitStatusCodes": 'http://hl7.org/fhir/explanationofbenefit-status'
codesystem "ClaimUseCodes": 'http://hl7.org/fhir/claim-use'
codesystem "ClaimTypeCodes": 'http://terminology.hl7.org/CodeSystem/claim-type'
codesystem "DiagnosisTypeCodes": 'http://terminology.hl7.org/CodeSystem/ex-diagnosistype'
codesystem "ProcedureTypeCodes": 'http://terminology.hl7.org/CodeSystem/ex-procedure-type'

// US Realm: the CARIN Blue Button institutional claim subtype, used to distinguish inpatient from
// outpatient institutional claims, which share a type of institutional.
codesystem "InstitutionalClaimSubTypeCodes": 'http://hl7.org/fhir/us/carin-bb/CodeSystem/C4BBInstitutionalClaimSubType'
// US Realm: the CARIN Blue Button supporting info type codes, used to identify supporting info
// in ExplanationOfBenefit profiles in CARIN Blue Button. Also used on the Claim resource here
codesystem "SupportingInfoTypeCodes": 'http://hl7.org/fhir/us/carin-bb/CodeSystem/C4BBSupportingInfoType'

// Claim status codes
code "claim-active": 'active' from "ClaimStatusCodes" display 'Active'
code "claim-cancelled": 'cancelled' from "ClaimStatusCodes" display 'Cancelled'
code "claim-draft": 'draft' from "ClaimStatusCodes" display 'Draft'
code "claim-entered-in-error": 'entered-in-error' from "ClaimStatusCodes" display 'Entered in Error'

// ExplanationOfBenefit status codes
code "eob-active": 'active' from "ExplanationOfBenefitStatusCodes" display 'Active'
code "eob-cancelled": 'cancelled' from "ExplanationOfBenefitStatusCodes" display 'Cancelled'
code "eob-draft": 'draft' from "ExplanationOfBenefitStatusCodes" display 'Draft'
code "eob-entered-in-error": 'entered-in-error' from "ExplanationOfBenefitStatusCodes" display 'Entered In Error'

// Use codes, shared by Claim and ExplanationOfBenefit
code "use-claim": 'claim' from "ClaimUseCodes" display 'Claim'
code "use-preauthorization": 'preauthorization' from "ClaimUseCodes" display 'Preauthorization'
code "use-predetermination": 'predetermination' from "ClaimUseCodes" display 'Predetermination'

// US Realm: institutional claim subtype codes
code "subtype-inpatient": 'inpatient' from "InstitutionalClaimSubTypeCodes" display 'Inpatient'
code "subtype-outpatient": 'outpatient' from "InstitutionalClaimSubTypeCodes" display 'Outpatient'

// Diagnosis type codes
code "diagnosistype-principal": 'principal' from "DiagnosisTypeCodes" display 'Principal Diagnosis'
code "diagnosistype-admitting": 'admitting' from "DiagnosisTypeCodes" display 'Admitting Diagnosis'
code "diagnosistype-discharge": 'discharge' from "DiagnosisTypeCodes" display 'Discharge Diagnosis'

// Procedure type codes. Note that there is no principal procedure code; the code identifying the
// procedure chiefly responsible for the encounter is primary.
code "proceduretype-primary": 'primary' from "ProcedureTypeCodes" display 'Primary procedure'
code "proceduretype-secondary": 'secondary' from "ProcedureTypeCodes" display 'Secondary procedure'

// US Realm: Supporting information type codes, from the CARIN Blue Button code system
code "discharge-status": 'discharge-status' from "SupportingInfoTypeCodes" display 'Discharge Status'
code "pointoforigin": 'pointoforigin' from "SupportingInfoTypeCodes" display 'Point Of Origin'

// Type codes, shared by Claim and ExplanationOfBenefit
code "type-institutional": 'institutional' from "ClaimTypeCodes" display 'Institutional'
code "type-oral": 'oral' from "ClaimTypeCodes" display 'Oral'
code "type-pharmacy": 'pharmacy' from "ClaimTypeCodes" display 'Pharmacy'
code "type-professional": 'professional' from "ClaimTypeCodes" display 'Professional'
code "type-vision": 'vision' from "ClaimTypeCodes" display 'Vision'

context Patient

/*
 * Claim status
 */

/*
@description: Returns true if the given claim has a status of active
*/
define fluent function isActive(claim FHIR.Claim):
  claim.status ~ "claim-active".code

/*
@description: Returns the claims in the given list that have a status of active
*/
define fluent function active(claims List<FHIR.Claim>):
  claims claim
    where claim.status ~ "claim-active".code

/*
@description: Returns true if the given claim has a status of cancelled
*/
define fluent function isCancelled(claim FHIR.Claim):
  claim.status ~ "claim-cancelled".code

/*
@description: Returns true if the given claim has a status of draft
@comment: A draft claim has not been submitted and should generally not be considered by measure logic.
*/
define fluent function isDraft(claim FHIR.Claim):
  claim.status ~ "claim-draft".code

/*
@description: Returns true if the given claim has a status of entered-in-error
@comment: A claim with this status is an erroneous record and should be excluded from consideration,
regardless of measure intent.
*/
define fluent function isEnteredInError(claim FHIR.Claim):
  claim.status ~ "claim-entered-in-error".code

/*
 * Claim use
 */

/*
@description: Returns true if the given claim has a use of claim, i.e. it is a request for adjudication
rather than a preauthorization or predetermination
*/
define fluent function isClaim(claim FHIR.Claim):
  claim.use ~ "use-claim".code

/*
@description: Returns the claims in the given list that have a use of claim
*/
define fluent function claims(claimList List<FHIR.Claim>):
  claimList claim
    where claim.use ~ "use-claim".code

/*
@description: Returns true if the given claim has a use of preauthorization
*/
define fluent function isPreauthorization(claim FHIR.Claim):
  claim.use ~ "use-preauthorization".code

/*
@description: Returns true if the given claim has a use of predetermination
*/
define fluent function isPredetermination(claim FHIR.Claim):
  claim.use ~ "use-predetermination".code

/*
 * Claim type
 */

/*
@description: Returns true if the given claim has a type of institutional
*/
define fluent function isInstitutional(claim FHIR.Claim):
  claim.type ~ "type-institutional"

/*
@description: Returns the claims in the given list that have a type of institutional
*/
define fluent function institutional(claims List<FHIR.Claim>):
  claims claim
    where claim.type ~ "type-institutional"

/*
@description: Returns true if the given claim has a type of professional
*/
define fluent function isProfessional(claim FHIR.Claim):
  claim.type ~ "type-professional"

/*
@description: Returns the claims in the given list that have a type of professional
*/
define fluent function professional(claims List<FHIR.Claim>):
  claims claim
    where claim.type ~ "type-professional"

/*
@description: Returns true if the given claim has a type of pharmacy
*/
define fluent function isPharmacy(claim FHIR.Claim):
  claim.type ~ "type-pharmacy"

/*
@description: Returns true if the given claim has a type of oral
*/
define fluent function isOral(claim FHIR.Claim):
  claim.type ~ "type-oral"

/*
@description: Returns true if the given claim has a type of vision
*/
define fluent function isVision(claim FHIR.Claim):
  claim.type ~ "type-vision"

/*
 * ExplanationOfBenefit status
 */

/*
@description: Returns true if the given explanation of benefit has a status of active
*/
define fluent function isActive(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.status ~ "eob-active".code

/*
@description: Returns the explanations of benefit in the given list that have a status of active
*/
define fluent function active(explanationsOfBenefit List<FHIR.ExplanationOfBenefit>):
  explanationsOfBenefit explanationOfBenefit
    where explanationOfBenefit.status ~ "eob-active".code

/*
@description: Returns true if the given explanation of benefit has a status of cancelled
*/
define fluent function isCancelled(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.status ~ "eob-cancelled".code

/*
@description: Returns true if the given explanation of benefit has a status of draft
*/
define fluent function isDraft(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.status ~ "eob-draft".code

/*
@description: Returns true if the given explanation of benefit has a status of entered-in-error
*/
define fluent function isEnteredInError(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.status ~ "eob-entered-in-error".code

/*
 * ExplanationOfBenefit use
 */

/*
@description: Returns true if the given explanation of benefit has a use of claim
*/
define fluent function isClaim(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.use ~ "use-claim".code

/*
@description: Returns the explanations of benefit in the given list that have a use of claim
*/
define fluent function claims(explanationOfBenefitList List<FHIR.ExplanationOfBenefit>):
  explanationOfBenefitList explanationOfBenefit
    where explanationOfBenefit.use ~ "use-claim".code

/*
@description: Returns true if the given explanation of benefit has a use of preauthorization
*/
define fluent function isPreauthorization(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.use ~ "use-preauthorization".code

/*
@description: Returns true if the given explanation of benefit has a use of predetermination
*/
define fluent function isPredetermination(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.use ~ "use-predetermination".code

/*
 * ExplanationOfBenefit type
 */

/*
@description: Returns true if the given explanation of benefit has a type of institutional
*/
define fluent function isInstitutional(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.type ~ "type-institutional"

/*
@description: Returns the explanations of benefit in the given list that have a type of institutional
*/
define fluent function institutional(explanationsOfBenefit List<FHIR.ExplanationOfBenefit>):
  explanationsOfBenefit explanationOfBenefit
    where explanationOfBenefit.type ~ "type-institutional"

/*
@description: Returns true if the given explanation of benefit has a type of professional
*/
define fluent function isProfessional(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.type ~ "type-professional"

/*
@description: Returns the explanations of benefit in the given list that have a type of professional
*/
define fluent function professional(explanationsOfBenefit List<FHIR.ExplanationOfBenefit>):
  explanationsOfBenefit explanationOfBenefit
    where explanationOfBenefit.type ~ "type-professional"

/*
@description: Returns true if the given explanation of benefit has a type of pharmacy
*/
define fluent function isPharmacy(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.type ~ "type-pharmacy"

/*
@description: Returns true if the given explanation of benefit has a type of oral
*/
define fluent function isOral(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.type ~ "type-oral"

/*
@description: Returns true if the given explanation of benefit has a type of vision
*/
define fluent function isVision(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.type ~ "type-vision"

/*
 * Claim supporting information
 */

/*
@description: Returns the discharge status for the given claim
@comment: Discharge status is carried in supportingInfo rather than as a dedicated element. Note that
supportingInfo is at the root of the Claim while encounter linking happens at the item level, so a
claim covering more than one encounter cannot attribute a discharge status to a particular one.
*/
define fluent function dischargeStatus(claim FHIR.Claim):
  (claim.supportingInfo SI where SI.category ~ "discharge-status").single().code

/*
@description: Returns the point of origin for the given claim
@comment: As with discharge status, point of origin is carried in supportingInfo at the root of the Claim.
*/
define fluent function pointOfOrigin(claim FHIR.Claim):
  (claim.supportingInfo SI where SI.category ~ "pointoforigin").single().code

/*
 * Claim diagnosis and procedure type
 */

/*
@description: Returns true if the given claim diagnosis type identifies a principal diagnosis
@comment: Claim.diagnosis.type is a list, so this tests for the presence of the principal diagnosis
code rather than comparing the element directly.
*/
define fluent function isPrincipalDiagnosis(diagnosisType List<FHIR.CodeableConcept>):
  exists (diagnosisType T where T ~ "diagnosistype-principal")

/*
@description: Returns true if the given claim diagnosis type identifies an admitting diagnosis
*/
define fluent function isAdmittingDiagnosis(diagnosisType List<FHIR.CodeableConcept>):
  exists (diagnosisType T where T ~ "diagnosistype-admitting")

/*
@description: Returns true if the given claim procedure type identifies a primary procedure
@comment: Claim.procedure.type is a list, so this tests for the presence of the primary procedure
code rather than comparing the element directly.
*/
define fluent function isPrimaryProcedure(procedureType List<FHIR.CodeableConcept>):
  exists (procedureType T where T ~ "proceduretype-primary")

/*
@description: Returns true if the given claim procedure type identifies a secondary procedure
*/
define fluent function isSecondaryProcedure(procedureType List<FHIR.CodeableConcept>):
  exists (procedureType T where T ~ "proceduretype-secondary")

/*
 * Institutional claim subtype (US Realm)
 *
 * The functions in this section are specific to the US Realm. Unlike the rest of this library, they
 * depend on a CARIN Blue Button code system rather than a universal-realm one, and would not be
 * carried into FHIRCommon as they stand.
 */

/*
@description: Returns true if the given claim is an inpatient institutional claim
@comment: US Realm. Inpatient and outpatient institutional claims share a type of institutional and are
distinguished by subType, using the CARIN Blue Button institutional claim subtype codes. Use
isInstitutional for the universal-realm test that covers both.
*/
define fluent function isInpatient(claim FHIR.Claim):
  claim.subType ~ "subtype-inpatient"

/*
@description: Returns the claims in the given list that are inpatient institutional claims
@comment: US Realm. See isInpatient.
*/
define fluent function inpatient(claimList List<FHIR.Claim>):
  claimList claim
    where claim.subType ~ "subtype-inpatient"

/*
@description: Returns true if the given claim is an outpatient institutional claim
@comment: US Realm. See isInpatient.
*/
define fluent function isOutpatient(claim FHIR.Claim):
  claim.subType ~ "subtype-outpatient"

/*
@description: Returns the claims in the given list that are outpatient institutional claims
@comment: US Realm. See isInpatient.
*/
define fluent function outpatient(claimList List<FHIR.Claim>):
  claimList claim
    where claim.subType ~ "subtype-outpatient"

/*
@description: Returns true if the given explanation of benefit is an inpatient institutional claim
@comment: US Realm. The CARIN Blue Button Inpatient Institutional profile fixes subType to inpatient.
*/
define fluent function isInpatient(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.subType ~ "subtype-inpatient"

/*
@description: Returns the explanations of benefit in the given list that are inpatient institutional claims
@comment: US Realm. See isInpatient.
*/
define fluent function inpatient(explanationOfBenefitList List<FHIR.ExplanationOfBenefit>):
  explanationOfBenefitList explanationOfBenefit
    where explanationOfBenefit.subType ~ "subtype-inpatient"

/*
@description: Returns true if the given explanation of benefit is an outpatient institutional claim
@comment: US Realm. The CARIN Blue Button Outpatient Institutional profile fixes subType to outpatient.
*/
define fluent function isOutpatient(explanationOfBenefit FHIR.ExplanationOfBenefit):
  explanationOfBenefit.subType ~ "subtype-outpatient"

/*
@description: Returns the explanations of benefit in the given list that are outpatient institutional claims
@comment: US Realm. See isInpatient.
*/
define fluent function outpatient(explanationOfBenefitList List<FHIR.ExplanationOfBenefit>):
  explanationOfBenefitList explanationOfBenefit
    where explanationOfBenefit.subType ~ "subtype-outpatient"
