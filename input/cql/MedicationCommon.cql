/*
@description: Status and intent functions for the FHIR medication resources.

@comment: FHIRCommon defines status functions for Observation (isResulted, isFinal, isAmended,
isCorrected and their list-valued forms), for Condition and AllergyIntolerance (isActive, isVerified,
isConfirmed and so on), but nothing equivalent for MedicationRequest, MedicationAdministration, or
MedicationDispense. As a result, medication logic repeats inline status tests such as
`status in { 'active', 'completed' }`, which is both verbose and easy to get wrong.

This library supplies the missing functions, following the conventions used in FHIRCommon: an `is`
prefixed predicate that operates on a single resource, and an unprefixed function of the same meaning
that filters a list. Nothing here is US-specific, so the intent is to propose these for inclusion in
FHIRCommon; the library lives in this guide only until that happens.

@comment: Aggregate helpers are deliberately not defined here. Two combinations recur in CMS measure
logic - `{ 'active', 'completed' }` for a MedicationRequest that is in force or was filled, and
`{ 'in-progress', 'completed', 'on-hold' }` for any positive dispensing event - but naming them
requires agreement on what they mean, so for now callers compose the individual predicates, as in
`MR.isActive() or MR.isCompleted()`. Establishing whether those aggregates are worth naming, and what
to call them, is part of what the upstream proposal should settle.
*/
library MedicationCommon version '0.1.0'

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

// Note that the medication status code systems do not share a base: MedicationRequest status and
// intent are defined in the FHIR code system space, while the MedicationAdministration and
// MedicationDispense status code systems are defined in the terminology space.
codesystem "MedicationRequestStatusCodes": 'http://hl7.org/fhir/CodeSystem/medicationrequest-status'
codesystem "MedicationRequestIntentCodes": 'http://hl7.org/fhir/CodeSystem/medicationrequest-intent'
codesystem "MedicationAdministrationStatusCodes": 'http://terminology.hl7.org/CodeSystem/medication-admin-status'
codesystem "MedicationDispenseStatusCodes": 'http://terminology.hl7.org/CodeSystem/medicationdispense-status'

// MedicationRequest status codes
code "medicationrequest-active": 'active' from "MedicationRequestStatusCodes" display 'Active'
code "medicationrequest-on-hold": 'on-hold' from "MedicationRequestStatusCodes" display 'On Hold'
code "medicationrequest-cancelled": 'cancelled' from "MedicationRequestStatusCodes" display 'Cancelled'
code "medicationrequest-completed": 'completed' from "MedicationRequestStatusCodes" display 'Completed'
code "medicationrequest-entered-in-error": 'entered-in-error' from "MedicationRequestStatusCodes" display 'Entered in Error'
code "medicationrequest-stopped": 'stopped' from "MedicationRequestStatusCodes" display 'Stopped'
code "medicationrequest-draft": 'draft' from "MedicationRequestStatusCodes" display 'Draft'
code "medicationrequest-unknown": 'unknown' from "MedicationRequestStatusCodes" display 'Unknown'

// MedicationRequest intent codes
code "medicationrequest-proposal": 'proposal' from "MedicationRequestIntentCodes" display 'Proposal'
code "medicationrequest-plan": 'plan' from "MedicationRequestIntentCodes" display 'Plan'
code "medicationrequest-order": 'order' from "MedicationRequestIntentCodes" display 'Order'
code "medicationrequest-original-order": 'original-order' from "MedicationRequestIntentCodes" display 'Original Order'
code "medicationrequest-reflex-order": 'reflex-order' from "MedicationRequestIntentCodes" display 'Reflex Order'
code "medicationrequest-filler-order": 'filler-order' from "MedicationRequestIntentCodes" display 'Filler Order'
code "medicationrequest-instance-order": 'instance-order' from "MedicationRequestIntentCodes" display 'Instance Order'
code "medicationrequest-option": 'option' from "MedicationRequestIntentCodes" display 'Option'

// MedicationAdministration status codes
code "medicationadministration-in-progress": 'in-progress' from "MedicationAdministrationStatusCodes" display 'In Progress'
code "medicationadministration-not-done": 'not-done' from "MedicationAdministrationStatusCodes" display 'Not Done'
code "medicationadministration-on-hold": 'on-hold' from "MedicationAdministrationStatusCodes" display 'On Hold'
code "medicationadministration-completed": 'completed' from "MedicationAdministrationStatusCodes" display 'Completed'
code "medicationadministration-entered-in-error": 'entered-in-error' from "MedicationAdministrationStatusCodes" display 'Entered in Error'
code "medicationadministration-stopped": 'stopped' from "MedicationAdministrationStatusCodes" display 'Stopped'
code "medicationadministration-unknown": 'unknown' from "MedicationAdministrationStatusCodes" display 'Unknown'

// MedicationDispense status codes
code "medicationdispense-preparation": 'preparation' from "MedicationDispenseStatusCodes" display 'Preparation'
code "medicationdispense-in-progress": 'in-progress' from "MedicationDispenseStatusCodes" display 'In Progress'
code "medicationdispense-cancelled": 'cancelled' from "MedicationDispenseStatusCodes" display 'Cancelled'
code "medicationdispense-on-hold": 'on-hold' from "MedicationDispenseStatusCodes" display 'On Hold'
code "medicationdispense-completed": 'completed' from "MedicationDispenseStatusCodes" display 'Completed'
code "medicationdispense-entered-in-error": 'entered-in-error' from "MedicationDispenseStatusCodes" display 'Entered in Error'
code "medicationdispense-stopped": 'stopped' from "MedicationDispenseStatusCodes" display 'Stopped'
code "medicationdispense-declined": 'declined' from "MedicationDispenseStatusCodes" display 'Declined'
code "medicationdispense-unknown": 'unknown' from "MedicationDispenseStatusCodes" display 'Unknown'

context Patient

/*
 * MedicationRequest status
 */

/*
@description: Returns true if the given medication request has a status of active
*/
define fluent function isActive(medicationRequest FHIR.MedicationRequest):
  medicationRequest.status ~ "medicationrequest-active".code

/*
@description: Returns the medication requests in the given list that have a status of active
*/
define fluent function active(medicationRequests List<FHIR.MedicationRequest>):
  medicationRequests medicationRequest
    where medicationRequest.status ~ "medicationrequest-active".code

/*
@description: Returns true if the given medication request has a status of on-hold
*/
define fluent function isOnHold(medicationRequest FHIR.MedicationRequest):
  medicationRequest.status ~ "medicationrequest-on-hold".code

/*
@description: Returns the medication requests in the given list that have a status of on-hold
*/
define fluent function onHold(medicationRequests List<FHIR.MedicationRequest>):
  medicationRequests medicationRequest
    where medicationRequest.status ~ "medicationrequest-on-hold".code

/*
@description: Returns true if the given medication request has a status of completed
*/
define fluent function isCompleted(medicationRequest FHIR.MedicationRequest):
  medicationRequest.status ~ "medicationrequest-completed".code

/*
@description: Returns the medication requests in the given list that have a status of completed
*/
define fluent function completed(medicationRequests List<FHIR.MedicationRequest>):
  medicationRequests medicationRequest
    where medicationRequest.status ~ "medicationrequest-completed".code

/*
@description: Returns true if the given medication request has a status of cancelled
*/
define fluent function isCancelled(medicationRequest FHIR.MedicationRequest):
  medicationRequest.status ~ "medicationrequest-cancelled".code

/*
@description: Returns true if the given medication request has a status of stopped
*/
define fluent function isStopped(medicationRequest FHIR.MedicationRequest):
  medicationRequest.status ~ "medicationrequest-stopped".code

/*
@description: Returns true if the given medication request has a status of draft
*/
define fluent function isDraft(medicationRequest FHIR.MedicationRequest):
  medicationRequest.status ~ "medicationrequest-draft".code

/*
@description: Returns true if the given medication request has a status of entered-in-error
@comment: A medication request with this status is an erroneous record and should be excluded from
consideration, regardless of measure intent.
*/
define fluent function isEnteredInError(medicationRequest FHIR.MedicationRequest):
  medicationRequest.status ~ "medicationrequest-entered-in-error".code

/*
 * MedicationRequest intent
 */

/*
@description: Returns true if the given medication request has an intent of order
@comment: Note that this tests only the order intent. Use isOrderIntent to test for any of the
order intents.
*/
define fluent function isOrder(medicationRequest FHIR.MedicationRequest):
  medicationRequest.intent ~ "medicationrequest-order".code

/*
@description: Returns true if the given medication request has an intent of plan
*/
define fluent function isPlan(medicationRequest FHIR.MedicationRequest):
  medicationRequest.intent ~ "medicationrequest-plan".code

/*
@description: Returns true if the given medication request has an intent of proposal
*/
define fluent function isProposal(medicationRequest FHIR.MedicationRequest):
  medicationRequest.intent ~ "medicationrequest-proposal".code

/*
@description: Returns true if the given medication request has any of the order intents, i.e. order,
original-order, reflex-order, filler-order, or instance-order
@comment: This is the intent set used by the Active Medication Orders expression in the USCoreElements
library, and distinguishes an actual order from a proposal, plan, or option.
*/
define fluent function isOrderIntent(medicationRequest FHIR.MedicationRequest):
  medicationRequest.intent ~ "medicationrequest-order".code
    or medicationRequest.intent ~ "medicationrequest-original-order".code
    or medicationRequest.intent ~ "medicationrequest-reflex-order".code
    or medicationRequest.intent ~ "medicationrequest-filler-order".code
    or medicationRequest.intent ~ "medicationrequest-instance-order".code

/*
@description: Returns the medication requests in the given list that have any of the order intents
*/
define fluent function orderIntent(medicationRequests List<FHIR.MedicationRequest>):
  medicationRequests medicationRequest
    where medicationRequest.isOrderIntent()

/*
 * MedicationAdministration status
 */

/*
@description: Returns true if the given medication administration has a status of completed
*/
define fluent function isCompleted(medicationAdministration FHIR.MedicationAdministration):
  medicationAdministration.status ~ "medicationadministration-completed".code

/*
@description: Returns the medication administrations in the given list that have a status of completed
*/
define fluent function completed(medicationAdministrations List<FHIR.MedicationAdministration>):
  medicationAdministrations medicationAdministration
    where medicationAdministration.status ~ "medicationadministration-completed".code

/*
@description: Returns true if the given medication administration has a status of in-progress
*/
define fluent function isInProgress(medicationAdministration FHIR.MedicationAdministration):
  medicationAdministration.status ~ "medicationadministration-in-progress".code

/*
@description: Returns true if the given medication administration has a status of on-hold
*/
define fluent function isOnHold(medicationAdministration FHIR.MedicationAdministration):
  medicationAdministration.status ~ "medicationadministration-on-hold".code

/*
@description: Returns true if the given medication administration has a status of stopped
*/
define fluent function isStopped(medicationAdministration FHIR.MedicationAdministration):
  medicationAdministration.status ~ "medicationadministration-stopped".code

/*
@description: Returns true if the given medication administration has a status of not-done
@comment: The MedicationAdministration Not Done profile fixes status to not-done, so logic using that
profile does not need this function. It is provided for use with unprofiled administrations.
*/
define fluent function isNotDone(medicationAdministration FHIR.MedicationAdministration):
  medicationAdministration.status ~ "medicationadministration-not-done".code

/*
@description: Returns true if the given medication administration has a status of entered-in-error
*/
define fluent function isEnteredInError(medicationAdministration FHIR.MedicationAdministration):
  medicationAdministration.status ~ "medicationadministration-entered-in-error".code

/*
 * MedicationDispense status
 */

/*
@description: Returns true if the given medication dispense has a status of completed
*/
define fluent function isCompleted(medicationDispense FHIR.MedicationDispense):
  medicationDispense.status ~ "medicationdispense-completed".code

/*
@description: Returns the medication dispenses in the given list that have a status of completed
*/
define fluent function completed(medicationDispenses List<FHIR.MedicationDispense>):
  medicationDispenses medicationDispense
    where medicationDispense.status ~ "medicationdispense-completed".code

/*
@description: Returns true if the given medication dispense has a status of in-progress
*/
define fluent function isInProgress(medicationDispense FHIR.MedicationDispense):
  medicationDispense.status ~ "medicationdispense-in-progress".code

/*
@description: Returns true if the given medication dispense has a status of preparation
*/
define fluent function isPreparation(medicationDispense FHIR.MedicationDispense):
  medicationDispense.status ~ "medicationdispense-preparation".code

/*
@description: Returns true if the given medication dispense has a status of on-hold
*/
define fluent function isOnHold(medicationDispense FHIR.MedicationDispense):
  medicationDispense.status ~ "medicationdispense-on-hold".code

/*
@description: Returns true if the given medication dispense has a status of cancelled
*/
define fluent function isCancelled(medicationDispense FHIR.MedicationDispense):
  medicationDispense.status ~ "medicationdispense-cancelled".code

/*
@description: Returns true if the given medication dispense has a status of stopped
*/
define fluent function isStopped(medicationDispense FHIR.MedicationDispense):
  medicationDispense.status ~ "medicationdispense-stopped".code

/*
@description: Returns true if the given medication dispense has a status of declined
@comment: The MedicationDispense Declined profile fixes status to declined, so logic using that
profile does not need this function. It is provided for use with unprofiled dispenses.
*/
define fluent function isDeclined(medicationDispense FHIR.MedicationDispense):
  medicationDispense.status ~ "medicationdispense-declined".code

/*
@description: Returns true if the given medication dispense has a status of entered-in-error
*/
define fluent function isEnteredInError(medicationDispense FHIR.MedicationDispense):
  medicationDispense.status ~ "medicationdispense-entered-in-error".code
