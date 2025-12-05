# Using CQL with FHIR
As an aside, whether expressions in general should use the various elements of a profile depends entirely on measure or rule intent. However, there are some general guidelines that should be followed to ensure correct expression and evaluation of CQL.

To begin with, all elements in FHIR profiles have a cardinality that determines whether and how many values may appear in that element. Cardinality is expressed as a range, typically from 0 or 1 to 1 or *. A cardinality of 0..1 means the element is optional. A cardinality of 1..1 means the element is required. A cardinality of 0..* means the element may appear any number of times, and a cardinality of 1..* means the element must appear at least once, but may appear multiple times. Although other cardinalities are possible, those described above are the most common.

NOTE: Cardinality determines whether and how many values may appear for a given element, but the fact that an element is specified as required (e.g. 1..1) does not mean that expressions using that profile must use that element.

In addition, elements in FHIR profiles may have “(QI-Core)” prepended to the element’s short description found in the Description & Constraints column of the Key Elements Table. To ensure expression logic can be evaluated correctly, expressions must only use elements that are marked "(QI-Core)". For a complete discussion of this aspect, refer to the [MustSupport Flag](https://hl7.org/fhir/us/qicore/STU6/#mustsupport-flag) topic in the QI-Core Implementation Guide.

And finally, elements in FHIR profiles may be marked as modifier elements, meaning that the value of the element may change the overall meaning of the resource. For example, the clinicalStatus element of a Condition is a modifier element because the value determines whether the Condition overall represents the presence or absence of a condition. As a result, for each modifier element, authors must carefully consider whether each possible value would impact the intent of the expression.

To summarize, cardinality determines whether data will be present at all, "(QI-Core)" determines whether the element can be used in an expression, and modifier elements must always be considered to determine the impact of possible values of the element on the result of the expression. End of aside.
