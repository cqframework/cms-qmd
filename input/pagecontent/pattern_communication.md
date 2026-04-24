# Communication

## Communication

The QI-Core [Communication](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-communication.html) profile represents information transmitted from a sender to a receiver.  It reflects communication about or with the patient. 

Important distinction:
Measure developers looking to model clinical concepts like patient education should use the Procedure profile as that represents "An action that is being or was performed on a patient".

By default, Communication resources in QI-Core are characterized by the `topic` element. In comparison to STU 4.1.1, there are no new communication profiles added to STU6 of QI-Core.

```cql
CQL:
define "Lab Results Communicated":
   [Communication: "report-labs"] LabReport
       where LabReport.topic = 'report-labs'
       and LabReport.status = 'completed'
       and exists (LabReport.reasonCode  reason
	   where reason ~ 'Serum pregnancy test negative (finding)')

```

> NOTES: 
The Communication profile does not fix the value of the `status` element, authors must consider all the possible values for the element to ensure the expression meets measure intent.

.reasonCode, in the example above, this expression uses a direct-reference code of "Serum pregnancy test negative (finding)" (i.e. referencing a specific code from a code system, rather than a value set consisting of multiple codes).  For more information on using direct-reference codes in CQL expressions, refer to the [Codes](https://hl7.org/fhir/uv/cql/using-cql.html#codes) topic in the Using CQL with FHIR IG.

## Communication Not Done

QI-Core defines the [CommunicationNotDone](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-communicationnotdone.html) to represent documentation of the reason a communication was not done. By default, CommunicationNotDone resources in QI-Core are characterized by the `topic` element.

```cql
CQL:
define "Medication Not Available":
[CommunicationNotDone: code ~ "progress update (procedure)"] ProgressUpdate 
    where ProgressUpdate.topic ~ "Medication not available (finding)"
    and ProgressUpdate.status = 'completed'
    and exists (ProgressUpdate.reasonCode = Reason
	where Reason = 'Medication not available from manufacturer (finding)')
```

> NOTES: 
The CommunicationNotDone profile fixes the value of the `status` element to `not-done`, this element does not need to be tested in the expression.

Direct-reference codes cannot be used as the terminology target of a retrieve of a negation profile. 
Workarounds Include:
* placing the code in a single code value set
* using the full long hand logical expression instead of the shorthand expression 



