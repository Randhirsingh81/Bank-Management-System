@isTest
public class UpdateTransactionStatusTest {
    // Create test data
    static void createTestData() {
        // Create a test record with an amount below the threshold
        My_Transactions__c testRecord1 = new My_Transactions__c(
            Amount__c = 49000, Transaction_Type__c= 'withdrawal'
        );
        // Create a test record with an amount above the threshold
        My_Transactions__c testRecord2 = new My_Transactions__c(
            Amount__c = 55000,Transaction_Type__c='withdrawal'
        );
        
          My_Transactions__c testRecord3 = new My_Transactions__c(
            Amount__c = 49000, Transaction_Type__c= 'deposit'
        );
        // Create a test record with an amount above the threshold
        My_Transactions__c testRecord4 = new My_Transactions__c(
            Amount__c = 55000,Transaction_Type__c='deposit'
        );
        // Add the test records to a list
        List<My_Transactions__c> testRecords = new List<My_Transactions__c>();
        testRecords.add(testRecord1);
        testRecords.add(testRecord2);
        testRecords.add(testRecord3);
        testRecords.add(testRecord4);
        // Insert the test records
        insert testRecords;
    }

    // Test the trigger logic
    static testMethod void testUpdateTransactionStatusTrigger() {
        // Create test data
        createTestData();

        // Query the inserted records
        List<My_Transactions__c> insertedRecords = [SELECT Amount__c, Transaction_Status__c FROM My_Transactions__c];

        // Verify that the trigger updated the Transaction_Status__c field correctly
        System.assertEquals('Success', insertedRecords[0].Transaction_Status__c); // Amount below threshold should be 'Success'
        System.assertEquals('Pending', insertedRecords[1].Transaction_Status__c); // Amount above threshold should be 'Pending'
        System.assertEquals('Success', insertedRecords[2].Transaction_Status__c); // Amount below threshold should be 'Success'
        System.assertEquals('Pending', insertedRecords[3].Transaction_Status__c); // Amount above threshold should be 'Pending'
    }
}