The US Quality Core [US Quality Core Communication](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-communication.html) profile represents information transmitted from a sender to a receiver.  It reflects communication about or with the patient. 
<strong style="color:red;">REVIEW NEEDED: should we acknowledge these profiles are out of scope?.</strong>

Important distinction:
If the measure intent is to represent patient education or other clinical actions, authors should use the Procedure profile instead. "An action that is being or was performed on a patient" such as training or counseling e.g., involves verification of the patient’s comprehension or aims to change the patient’s mental state.

By default, Communication resources in US Quality Core are characterized by the `topic` element. 

```cql
CQL:
define "Lab Results Communicated":
 [USQualityCore.Communication: "Informing health care professional of test result (procedure)"] LabReport
   where LabReport.topic ~ "Laboratory test result abnormal (situation)"
     and LabReport.status ~ 'completed'
     and exists(LabReport.reasonCode reason
       where reason ~ "Serum potassium level above reference range (finding)")
```

> NOTES: 
The Communication profile does not fix the value of the `status` element, authors must consider all the possible values for the element to ensure the expression meets measure intent.

.reasonCode, in the example above, this expression uses a direct-reference code of "Serum pregnancy test negative (finding)" (i.e. referencing a specific code from a code system, rather than a value set consisting of multiple codes).  For more information on using direct-reference codes in CQL expressions, refer to the [Codes](https://hl7.org/fhir/uv/cql/using-cql.html#codes) topic in the Using CQL with FHIR IG.

### Communication Not Done

US Quality Core defines the [US Quality Core Communication Not Done](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-communicationnotdone.html) to represent documentation of the reason a communication was not done. By default, CommunicationNotDone resources in US Quality Core are characterized by the `topic` element.

```cql
CQL:
define "Medication Not Available Communication":
[USQualityCore.CommunicationNotDone] Update
  where exists(Update.category category
    where category ~ "Informing health care professional (procedure)")
    and Update.topic ~ "Medication not available (finding)"
    and Update.status = 'completed'
     and exists(Update.reasonCode reason   
       where reason ~ "Medication not available (finding)")
```

> NOTES: 
The US Quality Core Communication Not Done profile fixes the value of the `status` element to `not-done`, this element does not need to be tested in the expression.

Direct-reference codes cannot be used as the terminology target of a retrieve of a negation profile. 
Workarounds Include:
* placing the code in a single code value set
* using the full long hand logical expression instead of the shorthand expression 



