# Communication

## Communication

QI-Core defines the [Communication](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-communication.html) profile to represent communications with or about the patient. It is important to note that the definition of the profile is "A record of information transmitted from a sender to a receiver".  Measure developers looking to model clinical concepts like patient education should use the Procedure profile as that represents "An action that is being or was performed on a patient".

By default, Communication resources in QI-Core are characterized by the `topic` element. In comparison to STU 4.1.1, there are no new communication profiles added to STU6 of QI-Core.

```cql
define "Lab results communicated":
   ["Communication": "report-labs"] LabReport
       where LabReport.topic = 'report-labs'
       and LabReport.status = 'completed'
       and LabReport.reasonCode = 'Serum pregnancy test negative (finding)'

```

> NOTE: Because the Communication profile does not fix the value of the `status` element, authors must consider all the possible values for the element to ensure the expression meets measure intent.

> NOTE: For the LabReport.reasonCode, this expression uses a direct-reference code of "Serum pregnancy test negative (finding)" (i.e. referencing a specific code from a code system, rather than a value set consisting of multiple codes).  For more information on using direct-reference codes in CQL expressions, refer to the [Codes](https://hl7.org/fhir/uv/cql/using-cql.html#codes) topic in the Using CQL with FHIR IG.

## Communication not done

QI-Core defines the [CommunicationNotDone](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-communicationnotdone.html) to represent documentation of the reason a communication was not done. By default, CommunicationNotDone resources in QI-Core are characterized by the `topic` element.

```cql
define "Medication Not Available":
["CommunicationNotDone": "progress update"] ProgressUpdate 
    where ProgressUpdate.topic = 'progress-update'
    and ProgressUpdate.status = 'completed'
    and ProgressUpdate.reasonCode = 'Medication not available from manufacturer (finding)'
```

> NOTE: Because the CommunicationNotDone profile fixes the value of the `status` element to `not-done`, this element does not need to be tested in the expression.

> NOTE: At this time, direct-reference codes cannot be used as the terminology target of a retrieve of a negation profile. Available workarounds for this issue are to either create a value set with the single required code or to use the long-hand expression of the negation statement.


