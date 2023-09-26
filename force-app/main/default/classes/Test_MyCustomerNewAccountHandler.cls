/**
 * Test_MyCustomerNewAccountHandler - Test class for testing the trigger logic in MyCustomerNewAccountHandler.
 * This test class validates the trigger logic that creates My_Accounts__c records when My_Customers__c records are updated.
 */
@isTest
public class Test_MyCustomerNewAccountHandler {
    
    /**
     * Test method to cover the trigger logic.
     */
    static testMethod void testTriggerLogic() {
        
        // Create test data for My_Customers__c records
        
        My_Customers__c customer1 = new My_Customers__c(
            Name = 'Customer 1',
            Account_Creation_Status__c = 'Under Review', // Initial status
            Account_Type__c = 'Saving',
            Aadhar_Number__c ='4364623652',
            First_Deposit_Amount__c = 10000
        );
        insert customer1;

        // Update the Account_Creation_Status__c to 'Account Created Successfully'
        
        customer1.Account_Creation_Status__c = 'Account Created Successfully';
        update customer1;

        // Verify that a My_Accounts__c record is created for the customer
        
        List<My_Accounts__c> accounts = [SELECT Id FROM My_Accounts__c WHERE My_Customers__c = :customer1.Id];
        System.assertEquals(1, accounts.size(), 'Expected one My_Accounts__c record to be created');
    }
}