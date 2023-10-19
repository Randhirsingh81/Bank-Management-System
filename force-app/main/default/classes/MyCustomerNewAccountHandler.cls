public class MyCustomerNewAccountHandler {
/**
     * method handleNewAccountCreation Handles new account creation based on the account creation status of My_Customers__c records.
     *
     * @param newCustomers   List of new My_Customers__c records.
     * @param oldCustomerMap Map of old My_Customers__c records (before update).
     */

    public static void handleNewAccountCreation(List<My_Customers__c> newCustomers, Map<Id, My_Customers__c> oldCustomerMap) {
        List<My_Accounts__c> newBankAccounts = new List<My_Accounts__c>();

        // Use a set to store the IDs of My_Customers__c records that need account creation
        Set<Id> customerIdsToProcess = new Set<Id>();

        // Iterate through the updated My_Customers__c records to identify those that meet the criteria
        for (My_Customers__c newCustomer : newCustomers) {
            My_Customers__c oldCustomer = oldCustomerMap.get(newCustomer.Id);
            
            // Check if the Account_Creation_Status__c is 'Account Created Successfully'
            if (oldCustomer.Account_Creation_Status__c != 'Account Created Successfully' &&
                newCustomer.Account_Creation_Status__c == 'Account Created Successfully') {
                customerIdsToProcess.add(newCustomer.Id);
            }
        }

        // Query My_Customers__c records to get the related data
        Map<Id, My_Customers__c> customerMap = new Map<Id, My_Customers__c>([SELECT Id, Name, Account_Type__c,OwnerId, First_Deposit_Amount__c
                                                                            FROM My_Customers__c WHERE Id IN :customerIdsToProcess]);

        // Create My_Accounts__c records based on the selected My_Customers__c records
        for (Id customerId : customerIdsToProcess) {
            My_Customers__c customer = customerMap.get(customerId);
            My_Accounts__c newBankAccount = new My_Accounts__c(
                Name = customer.Name,
                Total_Deposits__c = customer.First_Deposit_Amount__c,
                Account_Type__c = customer.Account_Type__c,
                Balance__c = customer.First_Deposit_Amount__c,
                My_Customers__c = customer.Id,
                Owner__c =customer.OwnerId
            );
            newBankAccounts.add(newBankAccount);
        }

        // Insert the newly created My_Accounts__c records
        if (!newBankAccounts.isEmpty()) {
            insert newBankAccounts;
        }
    }
    /**
     * Checks for duplicate 'My Customers' records created by the same user and adds an error message if found.
     *
     * @param custList List of My_Customers__c records to check for duplicates.
     */
    
     public static void Check(List<My_Customers__c> custList){     // duplicate My customers  check method 
    
    // get the id of the current logged in user  
    List<My_Customers__c> createdRecord = [SELECT Id FROM My_Customers__c WHERE CreatedById =: UserInfo.getUserId()];
     if(!createdRecord.isEmpty()){     // Check for user has created
        
            for(My_Customers__c h : custList){
                h.addError('You can only create one "My Customers" record.'+ UserInfo.getName() +' Has Created Record. ');
            }
        }
    }
    
    
}