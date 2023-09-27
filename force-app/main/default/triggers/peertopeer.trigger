trigger peertopeer on My_Transactions__c (after insert) {
    List<My_Accounts__c> accountsToUpdate = new List<My_Accounts__c>();
    List<My_Transactions__c> transactionsToCreate = new List<My_Transactions__c>();

    // Map to store record type names for efficient lookup
    Map<Id, String> recordTypeMap = new Map<Id, String>();
    for (RecordType rt : [SELECT Id, Name FROM RecordType WHERE SObjectType = 'My_Transactions__c']) {
        recordTypeMap.put(rt.Id, rt.Name);
    }

    for (My_Transactions__c transact : Trigger.new) {
        
        // Check if the record type is "Peer to Peer Transaction"
        if (recordTypeMap.get(transact.RecordTypeId) == 'Peer to Peer Transactions') {
            // Assuming you have custom fields on My_Transactions__c for receiver information.
            String receiverName = transact.Reciever_Name__c;
            String receiverAccountNumber = String.valueOf(transact.Reciever_Account_Number__c);
            String receiverIFSC = transact.Reciever_IFSC__c;
            Decimal amount = transact.Amount__c;

            // Query the Account based on receiver information.
            List<My_Accounts__c> matchingAccounts = [SELECT Id, Balance__c FROM My_Accounts__c WHERE
                                              Account_Number__c = :receiverAccountNumber
                                              AND IFSC_Code__c = :receiverIFSC];
            List<My_Accounts__c> senderAccounts = [Select Id,Name, Balance__c From My_Accounts__c WHERE Id = :transact.My_Accountss__c ];

            if (senderAccounts.size() == 1) {
                My_Accounts__c senderAccount =senderAccounts[0];
                // Deduct the transaction amount from the sender's balance.
                senderAccount.Balance__c -= amount;
                if (!accountsToUpdate.contains(senderAccount)) {
                    accountsToUpdate.add(senderAccount);
                }
            }

            if (matchingAccounts.size() == 1) {
                // If exactly one matching account is found, update its balance.
                My_Accounts__c matchingAccount = matchingAccounts[0];
                matchingAccount.Balance__c += amount;
                accountsToUpdate.add(matchingAccount);
                
   				
                // Create a new transaction related to the matched account.
                My_Transactions__c newTransaction = new My_Transactions__c(
                    My_Accountss__c = matchingAccount.Id,
                    Amount__c = amount,
                    Transaction_Type__c = 'Credited',
                    Sender_Name__c = senderAccounts[0].Name
                    
                );
                transactionsToCreate.add(newTransaction);
            } else {
                // Handle cases where there are no matching accounts or multiple matches.
                // You can raise a custom exception or log an error message.
                transact.addError('No matching account found for the receiver.');
            }
        }
    }

    // Update accounts and insert new transactions in a single transaction.
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
    if (!transactionsToCreate.isEmpty()) {
        insert transactionsToCreate;
    }
}