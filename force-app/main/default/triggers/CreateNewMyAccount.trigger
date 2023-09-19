trigger CreateNewMyAccount on My_Customers__c (after update) {
    MyCustomerNewAccountHandler.handleNewAccountCreation(Trigger.new, Trigger.oldMap);
}