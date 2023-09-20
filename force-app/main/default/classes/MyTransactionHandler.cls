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
       
    // Create a map to store account records for updates
    Map<Id, My_Accounts__c> accountMap = new Map<Id, My_Accounts__c>();

    for (My_Transactions__c transact : transactions) {
        if (transact.Transaction_Status__c == 'Success' && transact.My_Accountss__c != null) {
            Id accountId = transact.My_Accountss__c;

            // Check if the account is already in the map; if not, query and add it
            if (!accountMap.containsKey(accountId)) {
                accountMap.put(accountId, new My_Accounts__c(
                    Id = accountId,
                    Total_Deposits__c = 0, // Initialize to zero if it's a new entry
                    Total_Withdrawals__c = 0 // Initialize to zero if it's a new entry
                ));
            }

            My_Accounts__c account = accountMap.get(accountId);

            if (transact.Transaction_Type__c == 'deposit') {
                // Calculate and update the total deposits
                account.Total_Deposits__c += transact.Amount__c;
            } else if (transact.Transaction_Type__c == 'withdrawal') {
                // Calculate and update the total withdrawals
                account.Total_Withdrawals__c += transact.Amount__c;
            }
        }
    }

    // Perform the update if there are records to update
    if (!accountMap.isEmpty()) {
        update accountMap.values();
    }
}

    
}