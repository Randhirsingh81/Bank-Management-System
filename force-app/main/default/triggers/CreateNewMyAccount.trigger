trigger CreateNewMyAccount on My_Customers__c (after update, before insert) {
    
    if(Trigger.isAfter && trigger.IsUpdate) {
        
   			 MyCustomerNewAccountHandler.handleNewAccountCreation(Trigger.new, Trigger.oldMap);
    	}
    
   if  (Trigger.isInsert && Trigger.isBefore){
       
         MyCustomerNewAccountHandler.Check(Trigger.new);
   	   }
}