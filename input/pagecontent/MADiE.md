{:toc}

{: #MADiE}

The Measure Authoring Development Integrated Environment (MADiE) is the CMS-supported measure authoring environment for creating and maintaining eCQMs and dQMs. It produces standardized measure artifacts, including the base Measure resource, CQL libraries, and supporting resources, that are packaged for implementation and distribution.


The guidance in this implementation guide is specific to CMS dQMs. While many concepts are broadly applicable to FHIR Measure resources, the conventions, examples, and recommendations described herein reflect CMS implementation and publication practices supported by MADiE.


### MADiE dQM Specifications 

MADiE supports Clinical Quality Language (CQL) as the authoring language for defining measure populations, supplemental data elements, stratifiers, observations, and reusable expressions.

For the underlying data model, MADiE supports the QI-Core and US Quality Core FHIR implementation guides, which define the FHIR profiles, data elements, and terminology used by the measure.

Addition of new data models starts with a MADiE enhancement request submitted through the ONC Jira [MADiE Issue Tracker](https://oncprojectracking.healthit.gov/support/projects/MADIE/summary). 

### dQM Metadata Used in MADiE

Table 4-1 MADiE Field Mapping provides a crosswalk between MADiE measure authoring fields and the corresponding FHIR Measure elements used in the CMS dQM specification. For each MADiE field, the table identifies its requirement level, provides a brief description, and maps the field to the corresponding FHIR Measure element where applicable.

<details>
<summary style="cursor:pointer;">
  <strong>Table 4-1. MADiE Field Mapping</strong> <em>(Click to expand)</em>
</summary>

<table class="grid">
  <thead>
    <tr>
      <th scope="col">MADiE Field</th>
      <th scope="col">Requirement Level</th>
      <th scope="col">Description</th>
      <th scope="col">Measure Element</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Clinical Recommendation</td>
      <td>Optional</td>
      <td>Summarizes the clinical guidelines or recommendations supporting the measure.</td>
      <td><code>Measure.clinicalRecommendationStatement</code></td>
    </tr>
    <tr>
      <td>CMS ID</td>
      <td>Conditional</td>
      <td>Identifies the measure across its versions and drafts. It will not be assigned to any other measure and cannot be changed. Only assigned when indicated. </td>
      <td><code>Measure.identifier:cmsId</code></td>
    </tr>
    <tr>
      <td>Copyright</td>
      <td>Optional</td>
      <td>Identifies the organization(s) that own the intellectual property represented by the measure.</td>
      <td><code>Measure.copyright</code></td>
    </tr>
    <tr>
      <td>Definition</td>
      <td>Optional</td>
      <td>A list of terms and their definitions.</td>
      <td><code>Measure.definition</code></td>
    </tr>
    <tr>
      <td>Description</td>
      <td>Required</td>
      <td>Describes the measure intent.</td>
      <td><code>Measure.description</code></td>
    </tr>
    <tr>
      <td>Developer</td>
      <td>Required</td>
      <td>Identifies the organization(s) responsible for authoring the measure. This field is required to export a measure. </td>
      <td><code>Measure.author</code></td>
    </tr>
    <tr>
      <td>Disclaimer</td>
      <td>Optional</td>
      <td>Provides disclaimer information for the measure.</td>
      <td><code>Measure.disclaimer</code></td>
    </tr>
    <tr>
      <td>eCQM Abbreviated Title</td>
      <td>Required</td>
      <td>Identifies the measure using a shortened title.</td>
      <td><code>Measure.identifier:shortName</code></td>
    </tr>
    <tr>
      <td>Endorsement #</td>
      <td>Conditional</td>
      <td>If an Endorsing Organization is selected, an Endorsing Number is required.</td>
      <td><code>Measure.identifier:endorserIdentifier</code></td>
    </tr>
    <tr>
      <td>Endorsing Organization</td>
      <td>Optional</td>
      <td>Identifies the organization that endorses the measure.</td>
      <td><code>Measure.endorser</code></td>
    </tr>
    <tr>
      <td>Experimental (Checkbox)</td>
      <td>Optional</td>
      <td>Indicates whether the measure is experimental. Defaults to “No” for new measures, indicated by an unchecked checkbox.</td>
      <td><code>Measure.experimental</code></td>
    </tr>
    <tr>
      <td>Guidance (Usage)</td>
      <td>Optional</td>
      <td>Describes how to interpret or implement certain components of a measure.</td>
      <td><code>Measure.usage</code></td>
    </tr>
    <tr>
      <td>Intended Venue</td>
      <td>Optional</td>
      <td>Specifies the intended reporting venue for the measure.</td>
      <td><code>Measure.useContext</code></td>
    </tr>
    <tr>
      <td>Measure CQL Library Name</td>
      <td>Required</td>
      <td>Identifies the current name of the primary CQL library associated with the measure.</td>
      <td><code>Measure.library</code></td>
    </tr>
    <tr>
      <td>Measure ID</td>
      <td>Required</td>
      <td>Identifies the measure uniquely across all versions and drafts. System generated and cannot be edited.</td>
      <td><code>Measure.identifier</code></td>
    </tr>
    <tr>
      <td>Measure Name</td>
      <td>Required</td>
      <td>Specifies the current measure name.</td>
      <td><code>Measure.title</code></td>
    </tr>
    <tr>
      <td>Measurement Period End</td>
      <td>Required</td>
      <td>Specifies the end of the measurement period.</td>
      <td><code>Measure.effectivePeriod.end</code></td>
    </tr>
    <tr>
      <td>Measurement Period Start</td>
      <td>Required</td>
      <td>Specifies the start of the measurement period.</td>
      <td><code>Measure.effectivePeriod.start</code></td>
    </tr>
    <tr>
      <td>Model</td>
      <td>Required</td>
      <td>Defines the FHIR profiles, data elements, and associated terminology used in a measure.</td>
      <td>x</td>
    </tr>
    <tr>
      <td>Population Criteria</td>
      <td>Required</td>
      <td>Defines one or more measure population groups.</td>
      <td><code>Measure.group</code></td>
    </tr>
    <tr>
      <td>Population Criteria Description</td>
      <td>Conditional</td>
      <td>Describes a population criteria’s intent. Should be present when measures have more than one population.</td>
      <td><code>Measure.group.description</code></td>
    </tr>
    <tr>
      <td>Population Criteria Improvement Notation</td>
      <td>Required</td>
      <td>Specifies whether an increase or decrease in score represents improvement.</td>
      <td><code>Measure.group.improvementNotation</code></td>
    </tr>
    <tr>
      <td>Population Criteria Improvement Notation Description</td>
      <td>Optional</td>
      <td>Describes the improvement notation.</td>
      <td><code>Measure.group.improvementNotationGuidance</code></td>
    </tr>
    <tr>
      <td>Population Criteria Measure Type</td>
      <td>Required</td>
      <td>Indicates whether the measure is used to examine a process, an outcome over time, a patient-reported outcome, or a structure measure such as utilization.</td>
      <td><code>Measure.group.type</code></td>
    </tr>
    <tr>
      <td>Population Criteria Population Basis</td>
      <td>Required</td>
      <td>Specifies the type of elements in the populations.</td>
      <td><code>Measure.group.populationBasis</code></td>
    </tr>
    <tr>
      <td>Population Criteria Rate Aggregation</td>
      <td>Optional</td>
      <td>Specifies how to combine calculated information based on logic in each of several populations into one summarized result.</td>
      <td><code>Measure.group.rateAggregation</code></td>
    </tr>
    <tr>
      <td>Population Criteria Scoring</td>
      <td>Required</td>
      <td>Specifies the method used to calculate the measure score.</td>
      <td><code>Measure.group.scoring</code></td>
    </tr>
    <tr>
      <td>Population Criteria Scoring Precision</td>
      <td>Optional</td>
      <td>Specifies the number of decimal places used when reporting the measure score.</td>
      <td><code>Measure.group.scoringPrecision</code></td>
    </tr>
    <tr>
      <td>Population Criteria Scoring Unit</td>
      <td>Optional</td>
      <td>Specifies the expected units of measure for the measure score.</td>
      <td><code>Measure.group.scoringUnit</code></td>
    </tr>
    <tr>
      <td>Population Criteria Stratifier</td>
      <td>Optional</td>
      <td>Defines categories used to subdivide a measure population.</td>
      <td><code>Measure.group.stratifier</code></td>
    </tr>
    <tr>
      <td>Population Criteria Stratifier Description</td>
      <td>Optional</td>
      <td>Describes the stratifier's intent.</td>
      <td><code>Measure.group.stratifier.description</code></td>
    </tr>
    <tr>
      <td>Purpose</td>
      <td>Optional</td>
      <td>Describes the purpose of the measure. Specify why this measure is needed and why it has been designed as it has.</td>
      <td><code>Measure.purpose</code></td>
    </tr>
    <tr>
      <td>Rationale</td>
      <td>Optional</td>
      <td>Provides a detailed justification of the need for the measure, including statements pertaining to importance criteria such as impact, gap in care, and evidence.</td>
      <td><code>Measure.rationale</code></td>
    </tr>
    <tr>
      <td>References</td>
      <td>Optional</td>
      <td>Identifies bibliographic citations or references to clinical practice guidelines, sources of evidence, or other relevant materials supporting the measure’s intent and rationale.</td>
      <td><code>Measure.relatedArtifact:citation</code></td>
    </tr>
    <tr>
      <td>Risk Adjustment Definition</td>
      <td>Optional</td>
      <td>Defines patient characteristics that may influence outcomes, enabling more equitable comparisons of measure results across populations or providers.</td>
      <td><code>Measure.supplementalData</code> where usage: risk-adjustment-factor</td>
    </tr>
    <tr>
      <td>Risk Adjustment Description</td>
      <td>Optional</td>
      <td>Describes risk adjustment.</td>
      <td><code>Measure.riskAdjustment</code></td>
    </tr>
    <tr>
      <td>Steward</td>
      <td>Required</td>
      <td>Identifies the organization responsible for publishing the measure. This field is required to export a measure.</td>
      <td><code>Measure.publisher</code></td>
    </tr>
    <tr>
      <td>Supplemental Data Definition</td>
      <td>Optional</td>
      <td>Defines additional information to be returned for each member of a population.</td>
      <td><code>Measure.supplementalData</code>where usage: supplemental-data</td>
    </tr>
    <tr>
      <td>Supplemental Data Description</td>
      <td>Optional</td>
      <td>Describes supplemental data elements.</td>
      <td><code>Measure.supplementalDataGuidance</code></td>
    </tr>
    <tr>
      <td>Version</td>
      <td>Required</td>
      <td>Identifies the version of the measure.</td>
      <td><code>Measure.version</code></td>
    </tr>
    <tr>
      <td>Version ID</td>
      <td>Required</td>
      <td>Identifies a specific version of the measure. System generated and cannot be edited.</td>
      <td><code>Measure.identifier:versionSpecificIdentifier</code></td>
    </tr>
  </tbody>
</table>

</details>


### Namespaces in MADiE

MADiE establishes the namespace for authored and exported content by assigning canonical URLs to the associated resources.


At this time, MADiE supports a single namespace for authored and exported content and does not support organization-specific namespaces. As support for additional organizations and publication environments evolves, namespace conventions may be expanded to ensure artifacts developed independently remain uniquely identifiable.

For additional information about CQL library namespaces and their relationship to FHIR artifacts, see the Using CQL with FHIR Implementation Guide, [Library Namespaces section](https://hl7.org/fhir/uv/cql/using-cql.html#library-namespaces).

### dQM Export Naming Conventions

MADiE applies consistent naming conventions to the files generated for a dQM export. File names are based on the measure’s eCQM abbreviated title, measure version, and model information. 

#### Individual dQM Files

The human-readable and computable representations of the base Measure use the following pattern:

	{eCQMAbbreviatedTitle}-v{MeasureVersion}-{ModelFamily}.{format}

The applicable format extension is .html, .json, .xml, or .cql.

For example:

	CMSXXXXFHIR-v0.1.000-FHIR.html

	CMSXXXXFHIR-v0.1.000-FHIR.json

	CMSXXXXFHIR-v0.1.000-FHIR.xml
	
	CMSXXXXFHIR-v0.1.000-FHIR.cql	

#### dQM Packages

MADiE packages the dQM files in a .zip using the following pattern:

	{eCQMAbbreviatedTitle}-v{MeasureVersion}-{ModelFamily}.zip

For example:

	CMSXXXXFHIR-v0.1.000-FHIR.zip

#### MADiE CQL to ELM Translator

MADiE uses the open-source [cqframework CQL-to-ELM Translator]( https://github.com/cqframework/clinical_quality_language/tree/main/cql-to-elm) to translate CQL into Expression Logical Model (ELM), the computable representation used for validation and execution of CQL expressions.

Table 4-2 represents the translator parameters used in MADiE

<p><strong>Table 4-2 MADiE Translator Parameters</strong></p> <table class="grid">
<table class="grid">
  <thead>
    <tr>
      <th scope="col">Parameter</th>
      <th scope="col">Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>disable-method-invocation</td>
      <td><code>false</code></td>
    </tr>
    <tr>
      <td>validate-units</td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td>locators</td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td>error-severity (Export)</td>
      <td><code>Info</code></td>
    </tr>
    <tr>
      <td>error-severity (Export for publishing)</td>
      <td><code>error</code></td>
    </tr>
    <tr>
      <td>disable-list-promotion</td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td>result-types</td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td>detailed-errors</td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td>annotations</td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td>disable-list-demotion</td>
      <td><code>true</code></td>
    </tr>
  </tbody>
</table>
