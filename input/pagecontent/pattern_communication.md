FHIR uses the Communication resource for information transmitted from a sender to a receiver, about or with the patient.

The US CQL implementation guide does not publish a Communication patterns page, so this page is the primary source for communication patterns; see the [Pattern Index](pattern_index.html) for the full list of available patterns.

> NOTE: The US Quality Core Communication and Communication Not Done profiles are both marked with an asterisk in the [US Quality Core profile list](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/profiles.html), meaning they are not part of that guide's conformance expectations; neither carries a USCDI+ Quality flagged data element.

### Communication

The [US Quality Core Communication](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-communication.html) profile is characterized by the `topic` element.

Where measure intent is patient education or another clinical action &mdash; training or counseling that verifies the patient's comprehension or aims to change their mental state &mdash; the [Procedure](pattern_procedures.html#procedure-performed) profile is the correct choice instead, since that is "an action that is being or was performed on a patient".

```cql
define "Lab Results Communicated":
  [USQualityCore.Communication: "Informing health care professional of test result (procedure)"] LabReport
    where LabReport.topic ~ "Laboratory test result abnormal (situation)"
      and LabReport.status = 'completed'
      and exists (LabReport.reasonCode Reason
        where Reason ~ "Serum potassium level above reference range (finding)")
```

The profile does not fix `status`, so the expression must account for every value relevant to measure intent.

`topic` and `reasonCode` above are compared against direct-reference codes rather than value sets, so the equivalent operator is used; see [Use of terminologies](pattern_fhir.html#use-of-terminologies) and the [Codes](https://hl7.org/fhir/uv/cql/3.0.0-202609-ballot/en/using-cql.html#codes) topic in the Using CQL With FHIR IG.

### Communication Not Done

US Quality Core defines the [US Quality Core Communication Not Done](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/StructureDefinition-us-quality-core-communicationnotdone.html) profile to document the reason a communication did not occur, also characterized by `topic`. The profile fixes `status` to `not-done`, so that element need not &mdash; and must not &mdash; be tested for any other value. See [Negation Patterns](pattern_negation.html).

```cql
define "Medication Not Available Communication":
  [USQualityCore.CommunicationNotDone] Update
    where exists (Update.category Category
        where Category ~ "Informing health care professional (procedure)")
      and Update.topic() ~ "Medication not available (finding)"
      and exists (Update.reasonCode Reason
        where Reason ~ "Medication not available (finding)")
```

`topic()` is the accessor for the negated activity extent, defined in USQualityCoreCommon; it returns the topic whether it was recorded as a code or as a reference to a value set through the `notDoneValueSet` extension. See [Extent of negation](pattern_negation.html#extent-of-negation).

> NOTE: A direct-reference code cannot currently be used as the terminology target in the retrieve of a negation profile. Either place the code in a single-code value set, or filter outside the retrieve using the activity-extent accessor as above. See [Negation in CQL](https://fhir.org/guides/onc/us-quality-core/0.5.0/en/negation.html#negation-in-cql) in US Quality Core.
