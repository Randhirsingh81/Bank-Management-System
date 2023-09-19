@isTest
public class UpdateTotaldepositandwithdrawalTest {
    // Create test data
    static void createTestData() {
        
        My_Customers__c testCustomer = new My_Customers__c(
    Name = 'Test Customer',
    Aadhar_Number__c = '1234567890', // Provide a valid Aadhar number
    Gender__c = 'Male', // Provide a valid gender value
    Contact_Number__c = '123-456-7890', // Provide a valid contact number
    Country__c = 'India', // Provide a valid country value
    City__c = 'Gorakhpur', // Provide a valid city value
    Account_Type__c = 'Saving', // Provide a valid account type
    First_Deposit_Amount__c =10000
);
insert testCustomer;
        // Create a test account
        My_Accounts__c testAccount = new My_Accounts__c(Name = 'Test Account',  My_Customers__c = testCustomer.Id);
        insert testAccount;

        // Create a test deposit transaction
        My_Transactions__c testDepositTransaction = new My_Transactions__c(
          
            Transaction_Type__c = 'deposit',
            Transaction_Status__c = 'Success',
            Amount__c = 1000,
            My_Accountss__c = testAccount.Id
        );

        // Create a test withdrawal transaction
        My_Transactions__c testWithdrawalTransaction = new My_Transactions__c(
          
            Transaction_Type__c = 'withdrawal',
            Transaction_Status__c = 'Success',
            Amount__c = 500,
            My_Accountss__c = testAccount.Id
        );

        // Insert the test transactions
        insert new List<My_Transactions__c>{ testDepositTransaction, testWithdrawalTransaction };
    }

    // Test the trigger logic
    static testMethod void testUpdateTotaldepositandwithdrawalTrigger() {
        // Create test data
        createTestData();

        // Query the related account
        My_Accounts__c testAccount = [SELECT Id, Total_Deposits__c, Total_Withdrawals__c FROM My_Accounts__c LIMIT 1];

        // Verify the initial account balances
        System.assertEquals(1000, testAccount.Total_Deposits__c); // Initial deposit
        System.assertEquals(500, testAccount.Total_Withdrawals__c); // Initial withdrawal

        // Update the deposit transaction
        My_Transactions__c updatedDepositTransaction = [SELECT Amount__c FROM My_Transactions__c WHERE Id = :testAccount.Id];
        updatedDepositTransaction.Amount__c = 200;
        update updatedDepositTransaction;

        // Query the updated account
        testAccount = [SELECT Id, Total_Deposits__c, Total_Withdrawals__c FROM My_Accounts__c LIMIT 1];

        // Verify the updated account balance after changing deposit amount
        System.assertEquals(200, testAccount.Total_Deposits__c);

        // Update the withdrawal transaction
        My_Transactions__c updatedWithdrawalTransaction = [SELECT Amount__c FROM My_Transactions__c WHERE Id = :testAccount.Id];
        updatedWithdrawalTransaction.Amount__c = 100;
        update updatedWithdrawalTransaction;

        // Query the updated account
        testAccount = [SELECT Id, Total_Deposits__c, Total_Withdrawals__c FROM My_Accounts__c LIMIT 1];

        // Verify the updated account balance after changing withdrawal amount
        System.assertEquals(200, testAccount.Total_Deposits__c);
        System.assertEquals(100, testAccount.Total_Withdrawals__c);
    }
}