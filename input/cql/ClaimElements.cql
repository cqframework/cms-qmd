/*
@description: Claim element expressions that simplify access to the various
aspects of a FHIR Claim resource by flattening the repeating elements into a
more table-like structure. This flattening is done first for the `item` 
element, and then using that as a basis, the flattening is provided for the
`diagnosis` and `procedure` elements.
@comment: Similar element expressions could be defined for the ExplanationOfBenefit
resource to simplify access to the various aspects.

The intent is to promote this library to the Using CQL with FHIR IG. In this
guide every retrieve is of US Quality Core claims (`[USQualityCore.Claim]`), and the `isRelatedTo`
function takes a row whose claim is a `USQualityCore.Claim`. As part of the promotion the library would
be generalized to all claims: the US Quality Core and US Core models would be dropped in favor of FHIR
alone, the retrieves would become `[FHIR.Claim]`, and the row types would use `FHIR.Claim`. Nothing in
the logic depends on the US Quality Core profile, so no other change should be needed.

NOTE: This library is currently released in MADiE; this is a documentation copy
https://madie.cms.gov/cql-libraries/6ad8cc29bf531c0659c86b76/edit/details

NOTE: Development on this library occurs in the http://github.com/cqframework/dqm-content-cms-2026 
repository; this is a convenience copy only, do not make changes in this library.
*/
library ClaimElements version '0.4.000'

using USQualityCore version '0.5.0'
using USCore version '6.1.0-derived'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0'

include ClaimCommon version '0.4.000' called ClaimCommon

context Patient

/*
@description: Claim items unfolded per encounter
@comment: Note that encounter information is not profiled in CarinBB and is not likely
to be available or specified in the claim information if it is payer-sourced. Preference
should be given to the Claim Item data element, linked to the encounter by date.
Each item is paired with each of the encounters it references, so an item with no encounter is not
included. The encounters are unfolded in a query nested in the item query: the sources of a
multi-source query are independent, so a query `from C.item I, C.item.encounter E` would pair every
item with every encounter referenced by any of the claim's items.
*/
define "Claim Encounter Item":
  flatten (
    [USQualityCore.Claim] C
      where C.isActive()
        and C.isClaim()
      return flatten (
        (C.item) I
          return
            I.encounter E
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
                serviced: I.serviced.toServicedInterval(),
                location: I.location,
                bodySite: I.bodySite,
                subSite: I.subSite,
                encounter: E
              }
      )
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
            serviced: I.serviced.toServicedInterval(),
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
    [USQualityCore.Claim] C
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
@description: Determines whether the given claim diagnosis is related to the given encounter
@comment: Returns true if the claim item diagnosis references the given encounter, has a serviced
period during the encounter period, or the claim's billable period is during the encounter period.
Returns false only if all three are false. If the relationship can't be established, the result is
null: the reference test is never null, but either date test is null when its interval is missing
(no serviced element, no billable period, or an encounter with no period) or can't be compared at the
precision given (e.g. a serviced date on the day the encounter starts). As with any CQL conditional,
the unknown is propagated rather than treated as false, so `not isRelatedTo(...)` is null in that case.
*/
define fluent function isRelatedTo(
  claimItemDiagnosis Tuple{
    claim USQualityCore.Claim,
    claimId FHIR.id,
    itemSequence FHIR.positiveInt,
    category FHIR.CodeableConcept,
    productOrService FHIR.CodeableConcept,
    modifier List<FHIR.CodeableConcept>,
    programCode List<FHIR.CodeableConcept>,
    serviced Interval<System.DateTime>,
    location Choice<FHIR.Address,FHIR.CodeableConcept,FHIR.Reference>,
    bodySite FHIR.CodeableConcept,
    subSite List<FHIR.CodeableConcept>,
    encounter List<FHIR.Reference>,
    diagnosisSequence FHIR.positiveInt,
    diagnosis Choice<FHIR.CodeableConcept,FHIR.Reference>,
    diagnosisType List<FHIR.CodeableConcept>,
    onAdmission FHIR.CodeableConcept
  }, 
  encounter FHIR.Encounter
):
  claimItemDiagnosis.encounter.references(encounter)
    or claimItemDiagnosis.serviced during encounter.period
    or claimItemDiagnosis.claim.billablePeriod during encounter.period

/*
@description: Claim procedures unfolded
*/
define "Claim Procedure":
  flatten (
    [USQualityCore.Claim] C
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
