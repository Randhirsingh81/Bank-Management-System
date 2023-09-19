public class CustomerDuplicateCheck {
public static void Check(List<My_Customers__c> custList){
    
    // get the id of the current logged in user  
    List<My_Customers__c> createdRecord = [SELECT Id FROM My_Customers__c WHERE CreatedById =: UserInfo.getUserId()];
       
    if(!createdRecord.isEmpty()){     // Check for user has created
        
            for(My_Customers__c h : custList){
                h.addError('You can only create one "My Customers" record.'+ UserInfo.getName() +' Has Created Record. ');
            }
        }
    }
}