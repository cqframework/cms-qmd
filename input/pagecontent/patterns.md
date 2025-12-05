This page provides discussion and best-practice recommendations for authoring patterns for accessing patient information in FHIR and CQL. For general conventions and guidance regarding the use of FHIR and CQL, refer to the [Using CQL](https://hl7.org/fhir/us/cqfmeasures/using-cql.html) topic in the Quality Measure IG.

Feedback on the patterns and discussion here can be provided by submitting a [New Issue](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/issues/new/choose) to this repository.

## QI-Core Information Model Overview

[HL7 Fast Healthcare Interoperability Resources (FHIR)](https://hl7.org/fhir/R4) is a platform specification for exchanging healthcare data. FHIR defines a core information model that can be profiled for use in a variety of applications across the healthcare industry. These profiles are defined in Implementation Guides that provide constraints on the ways that FHIR resources can be used in to support interoperability (i.e. the ability of both sides of an interaction to correctly interpret the information being exchanged).

In the United States, the [US Core](https://hl7.org/fhir/us/core/STU6.1/) Implementation Guide defines a floor for that interoperability, enabling a broad range of clinical and administrative use cases. For quality improvement use cases, such as decision support and quality measurement, the [QI Core](https://hl7.org/fhir/us/qicore/STU6/) Implementation Guide extends US Core to support additional information used for quality improvement. For the most part, US Core covers the data required, but some use cases, such as documentation of events that did not occur, require additional profiles.

[Clinical Quality Language(CQL)](https://cql.hl7.org/N1) is high-level, domain-specific language focused on clinical quality and targeted at measure and decision support artifact authors.

To simplify the expression of logic in quality improvement artifacts, CQL can be authored directly against the information model defined by the QI Core profiles. In the simplest terms, that information model provides:

1. [Patient](pattern_patient.html) - Representation of patient demographic and basic characteristics
2. [Encounters](pattern_encounters.html) - Encounters between a patient and healthcare providers, typically taking place at a facility or virtually
3. [Observations](pattern_observations.html) - Facts about the patient such as lab results, vital signs, social history, etc.
4. [Conditions](pattern_conditions.html) - Conditions the patient has (or does not have)
5. [Medications](pattern_medications.html) - Information related to medications the patient is prescribed and/or using
6. [Procedures](pattern_procedures.html) - Information related to procedures ordered and/or performed for the patient
7. [Devices](pattern_devices.html) - Information related to devices the patient is using and/or has been prescribed
8. [Allergies](pattern_allergies.html) - Allergies and intolerances the patient has (or does not have)
9. [Immunizations](pattern_immunizations.html) - Information related to immunizations the patient has received or been recommended
10. [Communication](pattern_communication.html) - Information related to communications with or about the patient

> NOTE: The information in this page specifically uses the [6.0.0](https://hl7.org/fhir/us/qicore/STU6/) version of QI-Core, which depends on the [6.1.0](https://hl7.org/fhir/us/core/STU6.1.0) version of USCore, and both of which are based on the [R4](https://hl7.org/fhir/R4) version 4.0.1 of FHIR.

The following sections provide specific examples of best practices for accessing information in each of these high-level areas.

### Changes to expressing something that didn't happen for a reason
These patterns address three use cases for indicating something did not happen for a reason:

1. **Events not done for a reason**  
     a.&nbsp;&nbsp; *I don't administer aspirin for a reason (e.g., MedicationAdministrationNotDone)*  
     b.&nbsp;&nbsp; *I don't give an immunization for a reason (e.g., ImmunizationNotDone)*  
    Used with: CommunicationNotDone, ImmunizationNotDone, MedicationAdministrationNotDone, MedicationDispenseDeclined, ProcedureNotDone  
2. **Requests not to do something for a reason**  
     a.&nbsp;&nbsp; *I don't order aspirin because the patient is allergic (e.g., MedicationRequest)*  
     b.&nbsp;&nbsp; *I don't order mammography because the patient has had bilateral mastectomies (e.g., ServiceRequest)*  
    Used with: DeviceNotRequested, MedicationNotRequested, ServiceNotRequested  

    Note that each of these profiles includes the element doNotPerform which is a boolean element fixed to true (i.e., a request not to perform the request).  The converse, positive instances for these profiles are DeviceRequest, MedicationRequest, and ServiceRequest, respectively.  
  
    Each of these positive instances also include the doNotPerform Boolean element fixed to false. The doNotPerform element does not appear in the respective patterns since the profiles fix the value.  The CQL expression resulting from use of the positive instances includes a doNotPerform = false or null, because a system may not populate a value for doNotPerfom unless it is true.

3. **Rejection of proposals to do something (not expressly covered by previous documentation)**  
     a.&nbsp;&nbsp; *I reject the proposal to order aspirin because the patient is allergic (e.g., TaskRejected, focus = MedicationRequest)*  
     b.&nbsp;&nbsp; *I reject the proposal to request/order a referral to an ophthalmologist because the patient refuses (e.g., Task Rejected, focus = ServiceRequest)*  
    Used with: TaskRejected with focus = DeviceRequest, MedicationRequest, or ServiceRequest
****

### Using CQL with FHIR
As an aside, whether expressions in general should use the various elements of a profile depends entirely on measure or rule intent. However, there are some general guidelines that should be followed to ensure correct expression and evaluation of CQL.

To begin with, all elements in FHIR profiles have a cardinality that determines whether and how many values may appear in that element. Cardinality is expressed as a range, typically from 0 or 1 to 1 or *. A cardinality of 0..1 means the element is optional. A cardinality of 1..1 means the element is required. A cardinality of 0..* means the element may appear any number of times, and a cardinality of 1..* means the element must appear at least once, but may appear multiple times. Although other cardinalities are possible, those described above are the most common.

NOTE: Cardinality determines whether and how many values may appear for a given element, but the fact that an element is specified as required (e.g. 1..1) does not mean that expressions using that profile must use that element.

In addition, elements in FHIR profiles may have "(QI-Core)" prepended to the element's short description found in the Description & Constraints column of the Key Elements Table. To ensure expression logic can be evaluated correctly, expressions must only use elements that are marked "(QI-Core)". For a complete discussion of this aspect, refer to the [MustSupport Flag](https://hl7.org/fhir/us/qicore/STU6/#mustsupport-flag) topic in the QI-Core Implementation Guide.

And finally, elements in FHIR profiles may be marked as modifier elements, meaning that the value of the element may change the overall meaning of the resource. For example, the clinicalStatus element of a Condition is a modifier element because the value determines whether the Condition overall represents the presence or absence of a condition. As a result, for each modifier element, authors must carefully consider whether each possible value would impact the intent of the expression.

To summarize, cardinality determines whether data will be present at all, "(QI-Core)" determines whether the element can be used in an expression, and modifier elements must always be considered to determine the impact of possible values of the element on the result of the expression. End of aside.

### Use of Terminologies

FHIR supports various types of terminology-valued elements, including:

* [code](http://hl7.org/fhir/datatypes.html#code)
* [Coding](http://hl7.org/fhir/datatypes.html#Coding)
* [CodeableConcept](http://hl7.org/fhir/datatypes.html#CodeableConcept)

Within CQL, references to terminology code systems, value sets, codes, and concepts are directly supported, and all such usages are declared within CQL libraries, as described in the [Terminology](https://cql.hl7.org/02-authorsguide.html#terminology) section of the CQL Author's Guide.

When referencing terminology-valued elements within CQL, the following comparison operations are supported:

* [Equal (=)](https://cql.hl7.org/09-b-cqlreference.html#equal-3)
* [Equivalent (~)](https://cql.hl7.org/09-b-cqlreference.html#equivalent-3)
* [In (in)](https://cql.hl7.org/09-b-cqlreference.html#in-valueset)

As a general rule, the equivalent (~) operator should be used whenever the terminology being compared is a direct-reference code, and the in operator should be used whenever the terminology being compared is a value set. The equal (=) operator should only be used with code-valued elements that have a required binding.

#### code
In FHIR, code-valued elements are most often used with required bindings, meaning that the only values that can appear are established by the specification. Because of this, basic string comparison can be used, for example:

    where Encounter.status = 'finished'

NOTE: The comparison here is to the code value, not the display

NOTE: Note also that there are edge-cases where the string-valued elements may contain terminology values. For more detail on this case, refer to the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/using-cql.html#code-systems)

#### CodeableConcept
Most terminology-valued elements in FHIR are CodeableConcepts. If the terminology being compared is a value set (e.g. valueset "Inpatient Encounter"), use the in operator:

    where Encounter.type in "Inpatient Encounter"
Note that the in operator works whether the element is single cardinality or multi-cardinality.

If the terminology being compared is a direct-reference code (e.g. code "Blood Pressure"), use the ~ operator:

    where Observation.code ~ "Blood Pressure"
Note that this comparison only works if the element is single-cardinality. For multi-cardinality elements with direct-reference code comparison (e.g. code "Right Breast"), each CodeableConcept must be tested using the ~ operator, so an exists is used:

    where exists (Condition.bodySite S where S ~ "Right Breast")
#### Coding
Some terminology-valued elements in FHIR use the Coding type specifically. The same comparison patterns are used for elements of this type. For value sets (e.g. valueset "Inpatient Class"), use in:

    where Encounter.class in "Inpatient Class"
And for direct-reference codes (e.g. code "Inpatient"), use ~:

    where Encounter.class ~ "Inpatient"
