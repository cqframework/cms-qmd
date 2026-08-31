{:toc}

{: #Profiles-Used-by-CMS-Measure}


###  Measure Profiles
[MADiE Measure](StructureDefinition-madie-measure.html) is derived from [FHIR Measure](https://hl7.org/fhir/R4/measure.html). Its purpose is to support general measure development in MADiE.

[CMS Publishable Measure](StructureDefinition-cms-publishable-measure.html) is derived from the MADiE Measure profile and defines requirements for CMS published program measures.  

### Quality Measure IG Conformance
While the CMS measure profile is derived from FHIR Measure, CMS measures must also conform to profiles and guidance in the HL7 [Quality Measure Implementation Guide (QMIG)](https://hl7.org/fhir/uv/cqm/index.html). The [Using CQL](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html) topic of that guide defines conformance requirements for the CQL a measure depends on. The requirements governing how that CQL is organized and referenced are summarized below; requirements governing how it is written are covered in the [CMS FHIR-based CQL Style Guide](measure_guidance.html), and query patterns in the [Patterns](patterns.html) topic.

#### CQL libraries

CQL used by a Measure SHALL be contained in a CQL library, and every library SHALL carry a [library declaration](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#libraries). The library identifier SHALL be a valid unquoted identifier containing only alphanumeric characters, with no underscores.

```cql
library EXM146 version '4.0.0'
```

#### Library versioning

Libraries used by measures SHALL declare a version, and that version SHALL follow the `<major>.<minor>.<patch>` convention of [semantic versioning](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#library-versioning). Patch changes retain forward and backward compatibility and are used only to fix issues; minor changes retain backward compatibility and may add functionality; major changes may break compatibility.

For measures in draft status a version label MAY be included, in which case it SHALL follow `<major>.<minor>.<patch>-<label>`.

#### Nested libraries

All CQL expressions referenced by a Measure SHALL be contained within a [single library](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#nested-libraries), so that the expression identifiers named in the Measure need not be qualified. That library may in turn include others, and every included library SHALL use a `called` clause. The called-alias for a given library SHOULD be the same everywhere it is included.

```cql
include Common version '2.0.0' called Common
```

#### Library namespaces

Libraries SHOULD use [namespaces](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#library-namespaces). Where one is used, the root of the CQL namespace SHALL match the root of the `url` of the Library resource carrying the library. A library declared without a namespace is treated as belonging to a public global namespace for resolution within a given environment.

```cql
library CMS.Common version '2.0.0'
```

#### Terminology declarations

Code systems and value sets referenced from CQL SHALL be identified by canonical URL &mdash; see [Code Systems](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#code-systems) and [Value Sets](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#value-sets). Version information MAY be included, and when it is, it is given using the version clause of the declaration or a versioned canonical reference.

```cql
codesystem "SNOMED CT:20240901": 'http://snomed.info/sct'
  version 'http://snomed.info/sct/731000124108/version/20240901'

valueset "Acute Pharyngitis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011'
```

As a best practice, terminology versions are specified externally using a version manifest rather than pinned in the library &mdash; see the [Manifest Guidance](manifest_guidance.html) topic. The local identifier for a value set should match its name in the [Value Set Authority Center (VSAC)](https://vsac.nlm.nih.gov/); where two value sets share a name, add a qualifying suffix so the human-readable name is preserved while the reference stays unique within the library.

#### Library resources and ELM

CQL is carried into a measure package using FHIR Library resources, referenced from the Measure through its `library` element, with the CQL itself in the Library's `content` element. Translated ELM may be included alongside the CQL; see [Library Resources](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#library-resources) and [Translation to ELM](https://build.fhir.org/ig/HL7/fhir-cqm/en/using-cql.html#translation-to-elm).

### CMS Test Case Profile
CMS test cases must conform to the [CMSTestCase](StructureDefinition-cms-test-case.html) profile.

### Extensions
[CMS Type](StructureDefinition-cms-type.html)

[CMS Scoring](StructureDefinition-cms-scoring.html)

### Terminology
[CMS Measure Scoring value set](ValueSet-cms-measure-scoring.html)
