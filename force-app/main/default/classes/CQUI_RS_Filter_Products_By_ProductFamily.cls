global class CQUI_RS_Filter_Products_By_ProductFamily implements cqext.CQUI_DynamicFilterInterface{
    
    /**
*
* @param currentRecord: Object that needs to be queried.
* @param searchTerm: the term that needs to be matched.
*/
    global static List<SObject> getRecords(Map<String,Object> currentRecord, String searchTerm) {
        
        //set searchText
        // if search string is entered, then it wraps wildcard around it.
        // Otherwise, it searches all names.
        String searchText='';
        if(!String.isBlank(searchTerm)){
            searchText = '%' + searchTerm + '%';
        }else{
            searchText = '%%';
        }
        
        // list of object that need to be filtered.
        List<compliancequest__SQX_Part__c> filteredParts = new List<compliancequest__SQX_Part__c>();
        Id partfamilyId;
        if(currentRecord != null){
            //get selected part family field value
            partfamilyId = (String)currentRecord.get('CQ_RS_SQX_Part_Family__c');
            if (partfamilyId != null) {
                
                // get all parts which part family matches with record's part family selection
                filteredParts = [SELECT Id, 
                                 Name, 
                                 compliancequest__Part_Number__c, 
                                 compliancequest__Part_Type__c,
                                 compliancequest__Part_Family__c,
                                 compliancequest__Part_Risk_Level__c
                                 FROM compliancequest__SQX_Part__c
                                 WHERE compliancequest__Part_Family__c =: partfamilyId
                                 AND Name LIKE :searchText];
                                 
            }
        }
        return filteredParts;
    }
    
}