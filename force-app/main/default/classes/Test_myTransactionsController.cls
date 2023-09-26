@istest
public class Test_myTransactionsController {
    
    
@Testsetup
/**
 * Test data setup method.
 * This method sets up test data, including customer records, account creation, and transactions.
 */
    static void testdata() {
        
         // Create test data for My_Customers__c records
        
    My_Customers__c customertest = new My_Customers__c(
            Name = 'Customer 1',
            Account_Creation_Status__c = 'Under Review', // Initial status
            Account_Type__c = 'Saving',
            Aadhar_Number__c ='4364623652',
            First_Deposit_Amount__c = 10000
        );
        insert customertest;

        // Update the Account_Creation_Status__c to 'Account Created Successfully' so that A New Account is Crteated
        
        customertest.Account_Creation_Status__c = 'Account Created Successfully';
        update customertest;
        // Create test data for My_Accounts__c records
        
        My_Accounts__c accounts = [SELECT Id, Name, Balance__c, Account_Type__c 
                                    FROM My_Accounts__c WHERE My_Customers__c = :customertest.Id];
        
        
         // Create test data for My_Transactions__c records
    List<My_Transactions__c> transactions = new List<My_Transactions__c>();
        for (Integer i = 1; i <= 10; i++) {
            transactions.add(new My_Transactions__c(
                Amount__c = 1000 * i,  // Transaction amount
                My_Accountss__c = accounts.id,  // Sample related account
                Transaction_Type__c = 'Deposit'  // Sample type
            ));
        }
        
        // Insert the test data
        insert transactions;
    }

    /**
     * Test the getTransactions method.
     * This method tests the behavior of the getTransactions method in the MyTransactionsController class.
     */
     // Test the getTransactions method
    @isTest
    static void testGetTransactions() {
        // Create test data
       //testdata();
        
        // Call the getTransactions method
        List<My_Transactions__c> result = MyTransactionsController.getTransactions();
        
        // Verify that the method returns the expected number of records
        System.assertEquals(10, result.size(), 'Number of records returned should be 10');
        
        // Add additional assertions as needed to verify the content of the returned records
        // For example, you can check that the first record's Transaction_Type__c is 'Deposit'
        System.assertEquals('Deposit', result[0].Transaction_Type__c, 'First record should have Transaction_Type__c as Deposit');
    }

}