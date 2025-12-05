# Use of Terminologies

FHIR supports various types of terminology-valued elements, including:

* [code](http://hl7.org/fhir/datatypes.html#code)
* [Coding](http://hl7.org/fhir/datatypes.html#Coding)
* [CodeableConcept](http://hl7.org/fhir/datatypes.html#CodeableConcept)

Within CQL, references to terminology code systems, value sets, codes, and concepts are directly supported, and all such usages are declared within CQL libraries, as described in the [Terminology](https://cql.hl7.org/02-authorsguide.html#terminology) section of the CQL Author's Guide.

When referencing terminology-valued elements within CQL, the following comparison operations are supported:

* [Equal (=)](https://cql.hl7.org/09-b-cqlreference.html#equal-3)
* [Equivalent (~)](https://cql.hl7.org/09-b-cqlreference.html#equivalent-3)
* [In (in)](https://cql.hl7.org/09-b-cqlreference.html#in-valueset)

As a general rule, the equivalent (~) operator should be used whenever the terminology being compared is a direct-reference code, and the in operator should be used whenever the terminology being compared is a value set. The equal (=) operator should only be used with code-valued elements that have a required binding.

## code
In FHIR, code-valued elements are most often used with required bindings, meaning that the only values that can appear are established by the specification. Because of this, basic string comparison can be used, for example:

    where Encounter.status = 'finished'

NOTE: The comparison here is to the code value, not the display

NOTE: Note also that there are edge-cases where the string-valued elements may contain terminology values. For more detail on this case, refer to the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/using-cql.html#code-systems)

## CodeableConcept
Most terminology-valued elements in FHIR are CodeableConcepts. If the terminology being compared is a value set (e.g. valueset "Inpatient Encounter"), use the in operator:

    where Encounter.type in "Inpatient Encounter"
Note that the in operator works whether the element is single cardinality or multi-cardinality.

If the terminology being compared is a direct-reference code (e.g. code "Blood Pressure"), use the ~ operator:

    where Observation.code ~ "Blood Pressure"
Note that this comparison only works if the element is single-cardinality. For multi-cardinality elements with direct-reference code comparison (e.g. code "Right Breast"), each CodeableConcept must be tested using the ~ operator, so an exists is used:

    where exists (Condition.bodySite S where S ~ "Right Breast")
## Coding
Some terminology-valued elements in FHIR use the Coding type specifically. The same comparison patterns are used for elements of this type. For value sets (e.g. valueset "Inpatient Class"), use in:

    where Encounter.class in "Inpatient Class"
And for direct-reference codes (e.g. code "Inpatient"), use ~:

    where Encounter.class ~ "Inpatient"

