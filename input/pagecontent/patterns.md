This page provides guidance and best-practice recommendations for authoring QI-Core- and CQL-based query patterns used to retrieve patient information from clinical information systems. For general conventions and guidance regarding the use of FHIR and CQL, refer to the [Using CQL](https://hl7.org/fhir/us/cqfmeasures/using-cql.html) topic in the Quality Measure IG.

Feedback on the patterns, guidance or recommendations can be provided by submitting a [New Issue](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/issues/new/choose) to this repository.

## QI-Core Information Model Overview

[HL7 Fast Healthcare Interoperability Resources (FHIR)](https://hl7.org/fhir/R4) is a platform specification for exchanging healthcare data. FHIR defines a core information model that can be profiled for use in a variety of applications across the healthcare industry. These profiles are defined in Implementation Guides that provide constraints on the ways that FHIR resources can be used to support interoperability (i.e. the ability for different computer systems or software to correctly interpret the information being exchanged).

In the United States, the [US Core](https://hl7.org/fhir/us/core/STU6.1/) Implementation Guide defines a floor for that interoperability, enabling a broad range of clinical and administrative use cases. For quality improvement use cases, such as decision support and quality measurement, the [QI-Core](https://hl7.org/fhir/us/qicore/STU6/) Implementation Guide extends US Core to support additional information used for quality improvement. For the most part, US Core covers the data required, but some use cases, such as documentation of events that did not occur, require additional profiles.

[Clinical Quality Language(CQL)](https://cql.hl7.org/N1) is high-level, domain-specific language focused on clinical quality and targeted at measure and decision support artifact authors.

To simplify the expression of logic in quality improvement artifacts, CQL can be authored directly against the information model defined by the QI-Core profiles. In the simplest terms, that information model provides:

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

The following sections provide specific examples of best practices for querying information in each of these high-level areas.

### Use Cases for Negation Patterns
These patterns address three use cases for indicating a reason that something did not occur:

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
As an aside, the decision to reference particular elements of a profile depend wholly on the intent of the measure or rule. Nonetheless, general guidelines should be followed to ensure correct expression and evaluation of CQL.

To begin with, every element in a FHIR profile is assigned a cardinality that defines the minimum and maximum number of times an element can appear in a resource. Cardinality is expressed as a range, typically beginning with 0 or 1 and ending with 1 or *. For example, a cardinality of 0..1 means the element is optional, 1..1 means one occurance is required, 0..* indicates that it may appear any number of times, and 1..* means the element must appear at least once, but may appear multiple times. Although other cardinalities are possible, those described above are the most common.

NOTE: Cardinality determines whether and how many values may appear for a given element, but a required cardinality (e.g. 1..1) does not imply that expressions using that profile must reference that element.

In addition, elements in FHIR profiles may have "(QI-Core)" prepended to the element's short description in the Description & Constraints column of the Key Elements Table. To ensure that expression logic can be evaluated correctly, expressions should reference those elements marked "(QI-Core)". For a complete discussion of this requirement, refer to the [MustSupport Flag](https://hl7.org/fhir/us/qicore/STU6/#mustsupport-flag) topic in the QI-Core Implementation Guide.

Finally, some elements in FHIR profiles are designed as modifier elements, meaning that the value of the element may change the overall meaning of the resource. For example, the clinicalStatus element of a Condition is a modifier element because its value determines whether the Condition represents the presence or absence of a condition. As a result, authors must carefully consider for each modifier element, whether itd possible value(s) could affect the intended meaning of the expression.

To summarize, 
* Cardinality determines whether data will be present at all. 
* Modifier elements must always be evaluated for how their possible values might influence the meaning or outcome of an expression. 

### Use of Terminologies

FHIR supports several types of terminology-valued elements, including:

* [code](http://hl7.org/fhir/datatypes.html#code)
* [Coding](http://hl7.org/fhir/datatypes.html#Coding)
* [CodeableConcept](http://hl7.org/fhir/datatypes.html#CodeableConcept)

Within CQL, references to code systems, value sets, codes, and concepts are directly supported, and usages are declared within CQL libraries, as described in the [Terminology](https://cql.hl7.org/02-authorsguide.html#terminology) section of the CQL Author's Guide.

When referencing terminology-valued elements in CQL, the following comparison operations are supported:

* [Equal (=)](https://cql.hl7.org/09-b-cqlreference.html#equal-3)
* [Equivalent (~)](https://cql.hl7.org/09-b-cqlreference.html#equivalent-3)
* [In (in)](https://cql.hl7.org/09-b-cqlreference.html#in-valueset)

As a general rule, 
* Use the equivalent operator (~) when comparing to a direct-reference code. 
* Use the 'in' operator when comparing to a value set. 
* Use the equal operator (=) only with code-valued elements that have a required binding.

#### code
In FHIR, code elements are most often used with required bindings, meaning the allowable values are defined by the specification. Because of this, simple string comparison is sufficient. For example:

```cql
CQL:
    where Encounter.status = 'finished'
```	

NOTES: 
* The comparison is performed against the code value, not the display. 
* For example, the status finished will appear like this –
 
	code "**finished**": 'finished' from EncounterStatus display 'Finished'
* In edge-cases, string-valued elements may contain terminology values. For more information, see the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/using-cql.html#code-systems).

#### CodeableConcept
Most terminology-valued elements in FHIR are CodeableConcepts. 
* If comparing a value set (e.g., valueset "Inpatient Encounter"), use the 'in' operator:
```cql
CQL
    where Encounter.type in "Inpatient Encounter"
```	
The 'in' operator works for both single cardinality or multi-cardinality elements.
* If comparing to a direct-reference code (e.g. code "Blood Pressure"), use the ~ operator:
```cql
CQL
    where Observation.code ~ "Blood Pressure"
```	
This comparison is valid only for single-cardinality (e.g. 1..1). 
For multi-cardinality elements (e.g., 1..*) compared against direct-reference codes (e.g. code "Right Breast"), each CodeableConcept must be tested using the ~ operator, typically with exists:
```cql
CQL
    where exists (BenignCondition.bodySite Disorders where Disorder ~ "Right Breast")
```	
#### Coding
Some FHIR elements use the Coding type specifically. The same comparison rules apply. 
* For value sets (e.g. valueset "Inpatient Class"), use in:
```cql
CQL
    where Encounter.class in "Inpatient Class"
```	
* For direct-reference codes (e.g., code "Inpatient"), use ~:
```cql
CQL
    where Encounter.class ~ "Inpatient"
```	
