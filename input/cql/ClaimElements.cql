/*
@description: Claim element expressions that simplify access to the various
aspects of a FHIR Claim resource by flattening the repeating elements into a
more table-like structure. This flattening is done first for the `item` 
element, and then using that as a basis, the flattening is provided for the
`diagnosis` and `procedure` elements.
@comment: Similar element expressions could be defined for the ExplanationOfBenefit
resource to simplify access to the various aspects.
*/
library ClaimElements version '0.3.000-draft'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

include ClaimCommon version '0.3.000-draft' called ClaimCommon

context Patient

/*
@description: Claim items unfolded per encounter
@comment: Note that encounter information is not profiled in CarinBB and is not likely
to be available or specified in the claim information if it is payer-sourced. Preference
should be given to the Claim Item data element, linked to the encounter by date
*/
define "Claim Encounter Item":
  flatten (
    [USQualityCore.Claim] C
      let 
        item: C.item,
        encounter: item.encounter
      where C.isActive()
        and C.isClaim()
      return
        from item I, encounter E
          return {
            claim: C,
            claimId: C.id,
            sequence: I.sequence,
            careTeamSequence: I.careTeamSequence,
            diagnosisSequence: I.diagnosisSequence,
            procedureSequence: I.procedureSequence,
            category: I.category,
            productOrService: I.productOrService,
            modifier: I.modifier,
            programCode: I.programCode,
            serviced: I.serviced.toInterval(),
            location: I.location,
            bodySite: I.bodySite,
            subSite: I.subSite,
            encounter: E
          }
  )

/*
@description: Claim items unfolded
*/
define "Claim Item":
  flatten (
    [USQualityCore.Claim] C 
      where C.isActive()
        and C.isClaim()
      return
        C.item I
          return {
            claim: C,
            claimId: C.id,
            sequence: I.sequence,
            careTeamSequence: I.careTeamSequence,
            diagnosisSequence: I.diagnosisSequence,
            procedureSequence: I.procedureSequence,
            category: I.category,
            productOrService: I.productOrService,
            modifier: I.modifier,
            programCode: I.programCode,
            serviced: I.serviced.toInterval(),
            location: I.location,
            bodySite: I.bodySite,
            subSite: I.subSite,
            encounter: I.encounter
          }
  )

/*
@description: Claim diagnoses unfolded
*/
define "Claim Diagnosis":
  flatten (
    [Claim] C
      where C.isActive()
        and C.isClaim()
      return
        C.diagnosis D
          return {
            claimId: C.id,
            sequence: D.sequence,
            diagnosis: D.diagnosis,
            type: D.type,
            onAdmission: D.onAdmission
          }
  )

/*
@description: Claim item diagnoses unfolded
*/
define "Claim Item Diagnosis":
  flatten (
    "Claim Item" I
      return 
        I.diagnosisSequence DS
          let claimDiagnosis: ("Claim Diagnosis" D where D.claimId = I.claimId and D.sequence = DS).single()
          return {
            claim: I.claim,
            claimId: I.claimId,
            itemSequence: I.sequence,
            category: I.category,
            productOrService: I.productOrService,
            modifier: I.modifier,
            programCode: I.programCode,
            serviced: I.serviced,
            location: I.location,
            bodySite: I.bodySite,
            subSite: I.subSite,
            encounter: I.encounter,
            diagnosisSequence: DS,
            diagnosis: claimDiagnosis.diagnosis,
            diagnosisType: claimDiagnosis.type,
            onAdmission: claimDiagnosis.onAdmission
          }
  )

/*
@description: Claim procedures unfolded
*/
define "Claim Procedure":
  flatten (
    [Claim] C
      where C.isActive()
        and C.isClaim()
      return
        C.procedure P
          return {
            claimId: C.id,
            sequence: P.sequence,
            type: P.type,
            date: P.date,
            procedure: P.procedure
          }
  )

/*
@description: Claim item procedures unfolded
*/
define "Claim Item Procedure":
  flatten (
    "Claim Item" I
      return
        I.procedureSequence PS
          let claimProcedure: ("Claim Procedure" P where P.claimId = I.claimId and P.sequence = PS).single()
          return {
            claim: I.claim,
            claimId: I.claimId,
            itemSequence: I.sequence,
            category: I.category,
            productOrService: I.productOrService,
            modifier: I.modifier,
            programCode: I.programCode,
            serviced: I.serviced,
            location: I.location,
            bodySite: I.bodySite,
            subSite: I.subSite,
            encounter: I.encounter,
            procedureSequence: PS,
            procedureType: claimProcedure.type,
            procedureDate: claimProcedure.date,
            procedure: claimProcedure.procedure
          }
  )
