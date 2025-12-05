# Changes to expressing something that didn’t happen for a reason
These patterns address three use cases for indicating something did not happen for a reason:

1. **Events not done for a reason**  
     a.&nbsp;&nbsp; *I don’t administer aspirin for a reason (e.g., MedicationAdministrationNotDone)*  
     b.&nbsp;&nbsp; *I don’t give an immunization for a reason (e.g., ImmunizationNotDone)*  
    Used with: CommunicationNotDone, ImmunizationNotDone, MedicationAdministrationNotDone, MedicationDispenseDeclined, ProcedureNotDone  
2. **Requests not to do something for a reason**  
     a.&nbsp;&nbsp; *I don’t order aspirin because the patient is allergic (e.g., MedicationRequest)*  
     b.&nbsp;&nbsp; *I don’t order mammography because the patient has had bilateral mastectomies (e.g., ServiceRequest)*  
    Used with: DeviceNotRequested, MedicationNotRequested, ServiceNotRequested  

    Note that each of these profiles includes the element doNotPerform which is a boolean element fixed to true (i.e., a request not to perform the request).  The converse, positive instances for these profiles are DeviceRequest, MedicationRequest, and ServiceRequest, respectively.  
  
    Each of these positive instances also include the doNotPerform Boolean element fixed to false. The doNotPerform element does not appear in the respective patterns since the profiles fix the value.  The CQL expression resulting from use of the positive instances includes a doNotPerform = false or null, because a system may not populate a value for doNotPerfom unless it is true.

3. **Rejection of proposals to do something (not expressly covered by previous documentation)**  
     a.&nbsp;&nbsp; *I reject the proposal to order aspirin because the patient is allergic (e.g., TaskRejected, focus = MedicationRequest)*  
     b.&nbsp;&nbsp; *I reject the proposal to request/order a referral to an ophthalmologist because the patient refuses (e.g., Task Rejected, focus = ServiceRequest)*  
    Used with: TaskRejected with focus = DeviceRequest, MedicationRequest, or ServiceRequest
****