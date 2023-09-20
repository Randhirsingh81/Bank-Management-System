@isTest
public class Test_MyTransactionsTriggersAndHandler {
    // Test method to cover trigger logic
    static testMethod void testTriggerLogic() {
        
         // Create test data for My_Customers__c records
       My_Customers__c customertest = new My_Customers__c(
            Name = 'Customer 1',
            Account_Creation_Status__c = 'Under Review', // Initial status
            Account_Type__c = 'Saving',
            Aadhar_Number__c ='4364623652',
            First_Deposit_Amount__c = 10000
        );
        insert customertest;

        // Update the Account_Creation_Status__c to 'Account Created Successfully'
        
        customertest.Account_Creation_Status__c = 'Account Created Successfully';
        update customertest;
  
        // Create test data for My_Accounts__c records
        My_Accounts__c testAccount = new My_Accounts__c(
            Name = 'Test Account',
            My_Customers__c = customertest.Id
        );
        insert testAccount;

        // Create test data for My_Transactions__c records
        My_Transactions__c depositTransaction = new My_Transactions__c(
            Amount__c = 200,
            Transaction_Type__c = 'deposit',
            Transaction_Status__c = 'Pending',
            My_Accountss__c = testAccount.Id
        );

        My_Transactions__c withdrawalTransaction = new My_Transactions__c(
            Amount__c = 100,
            Transaction_Type__c = 'withdrawal',
            Transaction_Status__c = 'Pending',
            My_Accountss__c = testAccount.Id
        );
        
                
          My_Transactions__c depositTransaction1 = new My_Transactions__c(
            Amount__c = 60000,
            Transaction_Type__c = 'deposit',
            Transaction_Status__c = 'Pending',
            My_Accountss__c = testAccount.id
        );


        insert new List<My_Transactions__c>{ depositTransaction, withdrawalTransaction,depositTransaction1 };

        // Trigger should update transaction status and total deposits/withdrawals
        List<My_Transactions__c> updatedTransactions = [SELECT Id, Transaction_Status__c FROM My_Transactions__c];
        System.assertEquals('Success', updatedTransactions[0].Transaction_Status__c);
        System.debug('check 1');
        System.assertEquals('Success', updatedTransactions[1].Transaction_Status__c);
        System.debug('check 2');
         System.assertEquals('Pending', updatedTransactions[2].Transaction_Status__c);

        List<My_Accounts__c> updatedAccounts = [SELECT Id, Total_Deposits__c, Total_Withdrawals__c FROM My_Accounts__c];
        System.assertEquals(10000, updatedAccounts[0].Total_Deposits__c);
          System.debug('check 1');
        System.assertEquals(100, updatedAccounts[1].Total_Withdrawals__c);
          System.debug('check 2');
    }
}