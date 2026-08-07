{:toc}

{: #Profiles-Used-by-CMS-Measure}


###  Measure Profiles
[MADiE Measure](StructureDefinition-madie-measure.html) is derived from [FHIR Measure](https://hl7.org/fhir/R4/measure.html). Its purpose is to support general measure development in MADiE.

[CMS Publishable Measure](StructureDefinition-cms-publishable-measure.html) is derived from the MADiE Measure profile and defines requirements for CMS published program measures.  

### Quality Measure IG Conformance
While the CMS measure profile is derived from FHIR Measure, CMS measures must also conform to profiles and guidance in the HL7 [Quality Measure Implementation Guide (QMIG)](https://hl7.org/fhir/uv/cqm/index.html).

### CMS Test Case Profile
CMS test cases must conform to the [CMSTestCase](StructureDefinition-cms-test-case.html) profile.

### Extensions
[CMS Type](StructureDefinition-cms-type.html)

[CMS Scoring](StructureDefinition-cms-scoring.html)

### Terminology
[CMS Measure Scoring value set](ValueSet-cms-measure-scoring.html)

