/**
* Test_MyBankTransactionFlow - Test class for testing the My Bank Transaction Flow.
* This test class validates the behavior of the My Bank Transaction Flow, including
* transaction processing, account updates, and transaction status.
*/

@isTest
public with sharing class Test_MyBankTransactionFlow {
    
/**
* Test data setup method.
* This method sets up test data, including customer records, account creation, and transactions.
*/
    @Testsetup
    static void testdata() {
        
         // Create test data for My_Customers__c records
      My_Customers__c customer2 = new My_Customers__c(
            Name = 'Customer 2',
            Account_Creation_Status__c = 'Under Review', // Initial status
            Account_Type__c = 'Saving',
            Aadhar_Number__c ='4364623652',
            First_Deposit_Amount__c = 100000
        );
        insert customer2;

        // Update the Account_Creation_Status__c to 'Account Created Successfully' so that A New Account is Crteated
        
        customer2.Account_Creation_Status__c = 'Account Created Successfully';
        update customer2;
          
  		My_Accounts__c acc = [SELECT Id, Name, Balance__c, Account_Type__c 
                            FROM My_Accounts__c WHERE My_Customers__c = :customer2.Id];
        
        // Create test data for My_Transactions__c records
    
      My_Transactions__c depositTransaction = new My_Transactions__c(
            Amount__c = 20000,
            Transaction_Type__c = 'deposit',
            My_Accountss__c = acc.id
      );

      My_Transactions__c withdrawalTransaction = new My_Transactions__c(
            Amount__c = 10000,
            Transaction_Type__c = 'withdrawal',
            My_Accountss__c = acc.Id
          );
		  My_Transactions__c withdrawalTransaction1 = new My_Transactions__c(
            Amount__c = 60000,
            Transaction_Type__c = 'withdrawal',
            My_Accountss__c = acc.Id
          );
        
      insert new List<My_Transactions__c>{ depositTransaction, withdrawalTransaction,withdrawalTransaction1 }; 
            
      }

/**
* Test method to validate account balance updates and transaction status.
* This method tests the balance update logic and transaction status after
* processing deposits and withdrawals.
*/
    //testing started on created data
    
    static testmethod void balanceUpdate(){
        List<My_Transactions__c> updatedTransactions = [SELECT Id, Transaction_Status__c FROM My_Transactions__c];
        System.assertEquals('Success', updatedTransactions[0].Transaction_Status__c);
        System.assertEquals('Success', updatedTransactions[1].Transaction_Status__c);
        System.assertEquals('Pending', updatedTransactions[2].Transaction_Status__c);

        List<My_Accounts__c> updatedAccounts = [SELECT Id,Balance__c, Total_Deposits__c, Total_Withdrawals__c FROM My_Accounts__c];
        System.assertEquals(120000, updatedAccounts[0].Total_Deposits__c);
        System.assertEquals(10000, updatedAccounts[0].Total_Withdrawals__c);
        System.assertEquals(90000, updatedAccounts[0].Balance__c);
    }
    
}