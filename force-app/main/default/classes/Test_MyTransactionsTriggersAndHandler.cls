@isTest
public class Test_MyTransactionsTriggersAndHandler {
    // Test method to cover trigger logic
    @testsetup
    static void setupTestData() {
        
      // Create a user with the "Customer 2" profile
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Bank Customer'];
        User u = new User(
            ProfileId = p.Id,
            Username = 'testuser123123@example.com',
            Email = 'testuser@example.com',
            Alias = 'testuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LastName ='testuser',
            LanguageLocaleKey = 'en_US'
        );
        insert u;
        
        
        
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
     My_Accounts__c testAccount = [SELECT Id, Name, Balance__c, Account_Type__c 
                             FROM My_Accounts__c WHERE My_Customers__c = :customertest.Id];
 
         system.debug(testAccount);

        // Create test data for My_Transactions__c records
        My_Transactions__c depositTransaction = new My_Transactions__c(
            Amount__c = 2000,
            Transaction_Type__c = 'deposit',
            Transaction_Status__c = 'Pending',
            My_Accountss__c = testAccount.Id
        );

        My_Transactions__c withdrawalTransaction = new My_Transactions__c(
            Amount__c = 9000,
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


        insert new List<My_Transactions__c>{ depositTransaction, withdrawalTransaction, depositTransaction1 };
            
            }
    
    
    

  static testMethod void testTriggerLogicforTransactions() {
        // Trigger should update transaction status and total deposits/withdrawals
        List<My_Transactions__c> updatedTransactions = [SELECT Id, Transaction_Status__c FROM My_Transactions__c];
      
        System.assertEquals('Success', updatedTransactions[0].Transaction_Status__c);
        System.assertEquals('Success', updatedTransactions[1].Transaction_Status__c);
        System.assertEquals('Pending', updatedTransactions[2].Transaction_Status__c);

        List<My_Accounts__c> updatedAccounts = [SELECT Id, Total_Deposits__c, Total_Withdrawals__c, Balance__c  FROM My_Accounts__c];
      
        System.assertEquals(12000, updatedAccounts[0].Total_Deposits__c);
        System.assertEquals(9000, updatedAccounts[0].Total_Withdrawals__c);
  
  }
    
}