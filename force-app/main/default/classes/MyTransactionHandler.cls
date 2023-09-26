public class MyTransactionHandler {
    
    /**
     * Updates the transaction status based on a threshold amount.
     * Transactions with amounts below the threshold are marked as 'Success',
     * while those equal to or above the threshold are marked as 'Pending'.
     *
     * @param transactions The list of My_Transactions__c records to update.
     */

    public static void updateTransactionStatus(List<My_Transactions__c> transactions) {
        // Define the threshold amount
        Decimal thresholdAmount = 50000;

        for (My_Transactions__c transact : transactions) {
            // Check if the Transaction amount is below the threshold
            if (transact.Amount__c < thresholdAmount) {
                transact.Transaction_Status__c = 'Success';
            } else {
                transact.Transaction_Status__c = 'Pending';
            }
        }
    }
    /**
     * Updates the total deposits and withdrawals for My_Accounts__c records
     * based on a list of My_Transactions__c records with 'Success' status.
     * Only 'deposit' and 'withdrawal' transactions are considered for updates.
     *
     * @param transactions The list of My_Transactions__c records to process.
     */
public static void updatetotaldepositsAndWithdrawals(List<My_Transactions__c> transactions) {
    List<Id> accountIdsToUpdate = new List<Id>();

    for (My_Transactions__c transact : transactions) {
        if (transact.Transaction_Status__c == 'Success' &&
            transact.My_Accountss__c != null &&
            (transact.Transaction_Type__c == 'deposit' || transact.Transaction_Type__c == 'withdrawal')) {

            Id accountId = transact.My_Accountss__c;

            // Check if the account ID is not null and if it's not already in the list
            if (accountId != null && !accountIdsToUpdate.contains(accountId)) {
                accountIdsToUpdate.add(accountId);
            }
        }
    }

    // Query the accounts to update
    List<My_Accounts__c> accountsToUpdate = [SELECT Id, Total_Deposits__c, Total_Withdrawals__c
                                            FROM My_Accounts__c
                                            WHERE Id IN :accountIdsToUpdate];

    // Update the accounts based on the transactions
    for (My_Accounts__c account : accountsToUpdate) {
        for (My_Transactions__c transact : transactions) {
            if (transact.Transaction_Status__c == 'Success' &&
                transact.My_Accountss__c == account.Id) {

                if (transact.Transaction_Type__c == 'deposit') {
                    account.Total_Deposits__c += transact.Amount__c;
                } else if (transact.Transaction_Type__c == 'withdrawal') {
                    account.Total_Withdrawals__c += transact.Amount__c;
                }
            }
        }
    }

    // Perform the update if there are records to update
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}


    
}