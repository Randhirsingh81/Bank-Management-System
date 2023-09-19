public class MyTransactionHandler {
    
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
    
    
    public static void updatetotaldepositsAndWithdrawals(List<My_Transactions__c> transactions) {
        List<My_Accounts__c> accountsToUpdate = new List<My_Accounts__c>();

        for (My_Transactions__c transact : transactions) {
            if (transact.Transaction_Status__c == 'Success' &&
                transact.My_Accountss__c != null) {

                if (transact.Transaction_Type__c == 'deposit') {
                    // Query the related account and calculate the total deposits
                    My_Accounts__c account = [SELECT Id, Total_Deposits__c FROM My_Accounts__c
                                               WHERE Id = :transact.My_Accountss__c];
                    Decimal totalDeposits = account.Total_Deposits__c + transact.Amount__c;

                    // Update the account's Total Deposits field
                    account.Total_Deposits__c = totalDeposits;
                    accountsToUpdate.add(account);
                } else if (transact.Transaction_Type__c == 'withdrawal') {
                    // Query the related account and calculate the total withdrawals
                    My_Accounts__c account = [SELECT Id, Total_Withdrawals__c FROM My_Accounts__c
                                               WHERE Id = :transact.My_Accountss__c];
                    Decimal totalWithdrawals = account.Total_Withdrawals__c + transact.Amount__c;

                    // Update the account's Total Withdrawals field
                    account.Total_Withdrawals__c = totalWithdrawals;
                    accountsToUpdate.add(account);
                }
            }
        }

        // Perform the update if there are records to update
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
    
    
}