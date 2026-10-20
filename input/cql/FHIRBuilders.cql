/*
@description: Builder functions to help construct FHIR values and resources in
expressions in CQL.
@comment:

NOTE: This library is currently released in MADiE; this is a documentation copy
https://madie.cms.gov/cql-libraries/6ad7ddacbf531c0659c86b71/edit/details

NOTE: Development on this library occurs in the http://github.com/cqframework/dqm-content-cms-2026 
repository; this is a convenience copy only, do not make changes in this library.
*/
library FHIRBuilders version '0.1.000'

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0'

// The primitive builders are named for the FHIR type they build (e.g. string()), and the complex type
// builders likewise (e.g. Period(), Coding()). Each single-argument builder other than Quantity() also has
// a fluent form named toFHIR... (e.g. toFHIRString(), toFHIRCoding()).
// The fluent forms can't be named toString(), toBoolean(), ... because those are FHIRPath functions, and a
// fluent call with one of those names resolves to the system conversion operator rather than to a library
// function. The toFHIR prefix is used for every fluent form, including those without a conflict.
//
// Every builder returns null for a null input. The String-valued builders also return null for an empty
// string, since FHIR does not allow empty string values, and string() also returns null for a
// whitespace-only string.

define function base64Binary(value String):
  if value is not null and value != '' then
    FHIR.base64Binary { value: value }
  else
    null

define fluent function toFHIRBase64Binary(value String):
  if value is not null and value != '' then
    FHIR.base64Binary { value: value }
  else
    null

define function boolean(value Boolean):
  if value is not null then
    FHIR.boolean { value: value }
  else
    null

define fluent function toFHIRBoolean(value Boolean):
  if value is not null then
    FHIR.boolean { value: value }
  else
    null

define function canonical(value String):
  if value is not null and value != '' then
    FHIR.canonical { value: value }
  else
    null

define fluent function toFHIRCanonical(value String):
  if value is not null and value != '' then
    FHIR.canonical { value: value }
  else
    null
  
define function code(value String):
  if value is not null and value != '' then
    FHIR.code { value: value }
  else
    null

define fluent function toFHIRCode(value String):
  if value is not null and value != '' then
    FHIR.code { value: value }
  else
    null

define function date(value Date):
  if value is not null then
    FHIR.date { value: value }
  else
    null

define fluent function toFHIRDate(value Date):
  if value is not null then
    FHIR.date { value: value }
  else
    null

define function dateTime(value DateTime):
  if value is not null then
    FHIR.dateTime { value: value }
  else
    null

define fluent function toFHIRDateTime(value DateTime):
  if value is not null then
    FHIR.dateTime { value: value }
  else
    null

define function decimal(value Decimal):
  if value is not null then
    FHIR.decimal { value: value }
  else
    null

define fluent function toFHIRDecimal(value Decimal):
  if value is not null then
    FHIR.decimal { value: value }
  else
    null

define function id(value String):
  if value is not null and value != '' then
    FHIR.id { value: value }
  else
    null

define fluent function toFHIRId(value String):
  if value is not null and value != '' then
    FHIR.id { value: value }
  else
    null

define function instant(value DateTime):
  if value is not null then
    FHIR.instant { value: value }
  else
    null

define fluent function toFHIRInstant(value DateTime):
  if value is not null then
    FHIR.instant { value: value }
  else
    null

define function integer(value Integer):
  if value is not null then
    FHIR.integer { value: value }
  else
    null

define fluent function toFHIRInteger(value Integer):
  if value is not null then
    FHIR.integer { value: value }
  else
    null

define function string(value String):
  if value is not null and not Matches(value, '\\s*') then
    FHIR.string { value: value }
  else
    null

define fluent function toFHIRString(value String):
  if value is not null and not Matches(value, '\\s*') then
    FHIR.string { value: value }
  else
    null

define function time(value Time):
  if value is not null then
    FHIR.time { value: value }
  else
    null

define fluent function toFHIRTime(value Time):
  if value is not null then
    FHIR.time { value: value }
  else
    null

define function uri(value String):
  if value is not null and value != '' then
    FHIR.uri { value: value }
  else
    null

define fluent function toFHIRUri(value String):
  if value is not null and value != '' then
    FHIR.uri { value: value }
  else
    null

define function url(value String):
  if value is not null and value != '' then
    FHIR.url { value: value }
  else
    null

define fluent function toFHIRUrl(value String):
  if value is not null and value != '' then
    FHIR.url { value: value }
  else
    null

// WARNING: xhtml() and toFHIRXhtml() compile, but with a non-null value they currently fail at runtime in
// the CQL engine used by the VS Code extension ("Could not resolve data provider for package
// 'org.hl7.fhir.utilities.xhtml'"), which aborts the whole evaluation. Avoid them until that is fixed.
define function xhtml(value String):
  if value is not null and value != '' then
    FHIR.xhtml { value: value }
  else
    null

define fluent function toFHIRXhtml(value String):
  if value is not null and value != '' then
    FHIR.xhtml { value: value }
  else
    null

// A null boundary gives no start or end element. The raw boundary is tested because start of and end of
// return the minimum or maximum DateTime for a closed null boundary, not null.
define function Period(value Interval<DateTime>):
  if value is not null then
    FHIR.Period {
      start: if value.low is null then null else dateTime(start of value),
      end: if value.high is null then null else dateTime(end of value)
    }
  else
    null

define fluent function toFHIRPeriod(value Interval<DateTime>):
  if value is not null then
    FHIR.Period {
      start: if value.low is null then null else dateTime(start of value),
      end: if value.high is null then null else dateTime(end of value)
    }
  else
    null

define function getSystem(unit String):
  if unit in {
    'year',
    'years',
    'month',
    'months',
    'day',
    'days',
    'hour',
    'hours',
    'minute',
    'minutes',
    'second',
    'seconds',
    'millisecond',
    'milliseconds'
  } then
    uri('http://hl7.org/fhirpath/CodeSystem/calendar-units')
  else
    uri('http://unitsofmeasure.org')

define function Quantity(value System.Quantity):
  if value is not null then
    FHIR.Quantity { value: decimal(value.value), code: code(value.unit), unit: string(value.unit), system: getSystem(value.unit) }
  else
    null

define function Coding(value System.Code):
  if value is not null then
    FHIR.Coding {
      system: uri(value.system),
      version: string(value.version),
      code: code(value.code),
      display: string(value.display)
    }
  else
    null

define fluent function toFHIRCoding(value System.Code):
  if value is not null then
    FHIR.Coding {
      system: uri(value.system),
      version: string(value.version),
      code: code(value.code),
      display: string(value.display)
    }
  else
    null

define function CodeableConcept(value System.Concept):
  if value is not null then
    FHIR.CodeableConcept {
      coding: (value.codes C return Coding(C)),
      text: string(value.display)
    }
  else
    null

define fluent function toFHIRCodeableConcept(value System.Concept):
  if value is not null then
    FHIR.CodeableConcept {
      coding: (value.codes C return Coding(C)),
      text: string(value.display)
    }
  else
    null

define function CodeableConcept(value System.Code):
  if value is not null then
    FHIR.CodeableConcept { coding: { Coding(value) } }
  else
    null

define fluent function toFHIRCodeableConcept(value System.Code):
  if value is not null then
    FHIR.CodeableConcept { coding: { Coding(value) } }
  else
    null

// An identifier needs a system or a value; with neither, the result is null
define function Identifier(system String, value String):
  if system is not null or value is not null then
    FHIR.Identifier { system: uri(system), value: string(value) }
  else
    null

define function Reference(value String):
  if string(value) is not null then
    FHIR.Reference { reference: string(value) }
  else
    null

define fluent function toFHIRReference(value String):
  if string(value) is not null then
    FHIR.Reference { reference: string(value) }
  else
    null
