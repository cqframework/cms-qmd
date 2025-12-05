This page provides discussion and best-practice recommendations for authoring patterns for accessing patient information in FHIR and CQL. For general conventions and guidance regarding the use of FHIR and CQL, refer to the [Using CQL](https://hl7.org/fhir/us/cqfmeasures/using-cql.html) topic in the Quality Measure IG.

Feedback on the patterns and discussion here can be provided by submitting a [New Issue](https://github.com/cqframework/CQL-Formatting-and-Usage-Wiki/issues/new/choose) to this repository.

# QI-Core Information Model Overview

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