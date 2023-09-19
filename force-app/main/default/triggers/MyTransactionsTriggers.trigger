trigger MyTransactionsTriggers on My_Transactions__c (after update, after insert, before insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
          MyTransactionHandler.updatetotaldepositsAndWithdrawals( Trigger.new );
        }
    }
    
    if (Trigger.isInsert && Trigger.isBefore) {
        MyTransactionHandler.updateTransactionStatus(Trigger.new);
    }
}