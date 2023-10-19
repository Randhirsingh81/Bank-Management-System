/**
 * Apex controller for retrieving My Transactions records.
 */
public with sharing class MyTransactionsController {
    /**
     * Retrieves a list of My Transactions records.
     *
     * @return List of My_Transactions__c records.
     */
    
    @AuraEnabled(cacheable=true)
    public static List<My_Transactions__c> getTransactions() {
        return [SELECT Id, Amount__c, Transaction_date__c, My_Accountss__r.Name, Transaction_Status__c,
                Transaction_Type__c FROM My_Transactions__c limit 10];
    }
}