trigger MyCustomersDuplicateCheckTrigger on My_Customers__c (before insert) {
    CustomerDuplicateCheck.Check(Trigger.new);
}