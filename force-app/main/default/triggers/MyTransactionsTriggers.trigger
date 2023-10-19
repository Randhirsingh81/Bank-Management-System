// Trigger to handle My_Transactions__c records
trigger MyTransactionsTriggers on My_Transactions__c (after update, after insert, before insert) {
    // Check if this is an after trigger
    if (Trigger.isAfter) {
        // Check if this is an insert or update operation
        if (Trigger.isInsert || Trigger.isUpdate) {
            // Call the handler to update total deposits and withdrawals
            MyTransactionHandler.updatetotaldepositsAndWithdrawals(Trigger.new);
        }
    }
    
    // Check if this is a before insert trigger
    if (Trigger.isInsert && Trigger.isBefore) {
        // Call the handler to update transaction status
        MyTransactionHandler.updateTransactionStatus(Trigger.new);
    }
}