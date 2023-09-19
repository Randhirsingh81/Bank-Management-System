public with sharing class MyTransactionsController {
    @AuraEnabled(cacheable=true)
    public static List<My_Transactions__c> getTransactions() {
        return [SELECT Id, Amount__c, Transaction_date__c, My_Accountss__r.Name, Transaction_Status__c,
                Transaction_Type__c FROM My_Transactions__c limit 10];
    }
}