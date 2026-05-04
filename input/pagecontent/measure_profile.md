{:toc}

{: #Profiles-Used-by-CMS-Measure}

###  CMS Measure Profile
The CMS publishable measure profile ([CMSCQMPublishableMeasure](StructureDefinition-cmscqm-publishablemeasure.html))is derived from [Measure](https://hl7.org/fhir/R4/measure.html). 

### Quality Measure IG Conformance
While the CMS measure profile is derived from FHIR Measure, CMS measures must also conform to the appropriate measure profile based on their scoring type:

<table class="grid">
  <tr><th>Scoring Type</th><th>Profile</th></tr>
  <tr><td>Cohort</td><td><a href="https://hl7.org/fhir/uv/cqm/StructureDefinition-cqm-cohortmeasure.html">CQMCohortMeasure</a></td></tr>
  <tr><td>Proportion</td><td><a href="https://hl7.org/fhir/uv/cqm/StructureDefinition-cqm-proportionmeasure.html">CQMProportionMeasure</a></td></tr>
  <tr><td>Ratio</td><td><a href="https://hl7.org/fhir/uv/cqm/StructureDefinition-cqm-ratiomeasure.html">CQMRatioMeasure</a></td></tr>
  <tr><td>Continuous Variable</td><td><a href="https://hl7.org/fhir/uv/cqm/StructureDefinition-cqm-cvmeasure.html">CQMContinuousVariableMeasure</a></td></tr>
  <tr><td>Composite</td><td><a href="https://hl7.org/fhir/uv/cqm/StructureDefinition-cqm-compositemeasure.html">CQMCompositeMeasure</a></td></tr>
  <tr><td>Attestation</td><td><a href="https://hl7.org/fhir/uv/cqm/StructureDefinition-cqm-attestationmeasure.html">CQMAttestationMeasure</a></td></tr>
</table>

