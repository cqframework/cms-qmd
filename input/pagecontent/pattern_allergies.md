# Allergies

FHIR defines the [AllergyIntolerance](http://hl7.org/fhir/allergyintolerance.html) resource to represent allergies and intolerances for a patient.  In comparison to STU 4.1.1, there are no new allergy/ intolerance profiles added to STU6 of QI-Core.

## Current allergies

QI-Core defines the [AllergyIntolerance](https://hl7.org/fhir/us/qicore/STU6/StructureDefinition-qicore-allergyintolerance.html) profile to represent allergies and intolerances for a patient. By default, AllergyIntolerance resources in QI-Core are characterized by the `code` element.

```cql
define "Statin Allergy Intolerance":
  ["AllergyIntolerance": "Statin Allergen"] StatinAllergyIntolerance
    where StatinAllergyIntolerance.clinicalStatus is null 
      or StatinAllergyIntolerance.clinicalStatus ~ QICoreCommon."allergy-active"
```

> NOTE: Because the AllergyIntolerance profile does not constrain the values of the `clinicalStatus` or `verificationStatus` elements of the resource, authors must consider the possible values of these elements to ensure the expression matches measure intent. In this case, the `clinicalStatus`, if present, must be equivalent to the code `"allergy-active"` (NOTE the use of `allergy-active` here to distinguish from similar codes used for the Condition resource). 

In retrospective cases, the logic will be evaluated on data that exists at the time of evaluation. This means that while a given allergy/intolerance may have been active during the measurement period, it might no longer be active when the measure is run. As such, work is ongoing as of May 2025 to develop a more reliable way to determine whether an allergy was active at some point in time. 

## No known allergies

US Core guidance for [allergies](https://hl7.org/fhir/us/core/STU6.1/AllergyIntolerance-example.html) states that if a patient has been asked, but has indicated they have no known allergies, this would be represented as:
```cql
define "No Known Allergies":
 ["AllergyIntolerance": "No known allergy (situation)"] NKA
    where NKA.verificationStatus = "allergy-confirmed"
```

## Verified allergies
_Updated 2025-06-10_

Similar to the Condition resource, the AllergyIntolerance resource in FHIR has a `verificationStatus` element to represent, for example, whether the information has been confirmed. The element is not required, but if it is present, it is a modifier element, and has the potential to negate the information the AllergyIntolerance resource represents (e.g. refuted). For most usage, when measure intent is looking for positive evidence of an allergy, the verificationStatuses of `refuted` and `entered-in-error` should be excluded if verificationStatus is present:

```cql
define "Verified Allergies":
  [AllergyIntolerance] VerifiedAllergyIntolerance
    where VerifiedAllergyIntolerance.verificationStatus is not null implies
      (VerifiedAllergyIntolerance.verificationStatus ~ "confirmed"
        or VerifiedAllergyIntolerance.verificationStatus ~ "unconfirmed"
      )
```

To support reuse of this pattern, the following fluent functions can be used:

```cql
/*
@description: Returns true if the given condition either has no verification status or has a verification status of confirmed, unconfirmed, provisional, or differential
*/
define fluent function isVerified(allergyIntolerance FHIR.AllergyIntolerance):
  allergyIntolerance.verificationStatus is not null implies
    (allergyIntolerance.verificationStatus ~ "allergy-confirmed"
      or allergyIntolerance.verificationStatus ~ "allergy-unconfirmed"
    )

/*
@description: Returns conditions in the given list that either have no verification status or have a verification status of confirmed, unconfirmed, provisional, or differential
*/
define fluent function verified(allergyIntolerances List<FHIR.AllergyIntolerance>):
  allergyIntolerances A
    where A.verificationStatus is not null implies
      (A.verificationStatus ~ "allergy-confirmed"
        or A.verificationStatus ~ "allergy-unconfirmed"
      )
```
