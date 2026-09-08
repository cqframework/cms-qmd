library ClaimElements version '0.1.0'

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

include ClaimCommon version '0.1.0' called ClaimCommon

context Patient

/*
@description: Claim items unfolded per encounter
@comment: Note that encounter information is not profiled in CarinBB and is not likely
to be available or specified in the claim information if it is payer-sourced. Preference
should be given to the Claim Item data element, linked to the encounter by date
*/
define "Claim Encounter Item":
  flatten (
    [Claim] C
      let 
        item: C.item,
        encounter: item.encounter
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
            serviced: I.serviced,
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
    [Claim] C 
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
            serviced: I.serviced,
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
            procedureSequence: PS,
            procedureType: claimProcedure.type,
            procedureDate: claimProcedure.date,
            procedure: claimProcedure.procedure
          }
  )
