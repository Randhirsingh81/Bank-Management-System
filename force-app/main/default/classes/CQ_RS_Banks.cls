/**
* @description This class provides utility methods for enforcing validation rules related to bank records.
* It contains methods to prevent editing of closed banks and to prevent the transition of a bank's work
* status to 'Completed' when employees have no resumes.
* 
* ************************Revision History************************
* Date        Author          Description
* ----------  --------------  ----------------------------------------
* 2023-10-17  Randhir Singh   Initial version
* ************************Revision History************************
*/
public class CQ_RS_Banks {
    
    // Custom error message for preventing editing closed banks
    public static final String EDIT_ERROR_MSG = 'Updating the status is not allowed for closed banks. Record is locked from editing';
    
    // Custom error message for preventing record completion without employee resumes
    public static final String EDIT_ERROR_MSG1 = 'At least one resume of any Employees should be there for work status to be completed.';
    
    /**
* PreventRecordEditing - Prevents the editing of bank records with the 'Closed' work status.
* 
* @param newBank List of new bank records
* @param oldBank Map of old bank records (before update)
*/
    public static void PreventRecordEditing(List<CQ_RS_SQX_Bank__c> newBank, Map<Id, CQ_RS_SQX_Bank__c> oldBank) {
        Set<Id> closedBankIds = new Set<Id>();
        
        // Identify closed banks in the old records
        for (CQ_RS_SQX_Bank__c oldBankRecord : oldBank.values()) {
            if (oldBankRecord.CQ_RS_Work_Staus__c == 'Closed') {
                closedBankIds.add(oldBankRecord.Id);
            }
        }
        
        // Loop through the new bank records and check if they are closed
        for (CQ_RS_SQX_Bank__c newBankRecord : newBank) {
            if (closedBankIds.contains(newBankRecord.Id)) {
                newBankRecord.addError(EDIT_ERROR_MSG);
            }
        }
    }
    
    /**
* PreventRecordFromCompletion - Prevents transitioning a bank's work status to 'Completed' when employees have no resumes.
* 
* @param newBanks List of new bank records
* @param oldBanks Map of old bank records (before update)
*/
    public static void PreventRecordFromCompletion(List<CQ_RS_SQX_Bank__c> newBanks, Map<Id, CQ_RS_SQX_Bank__c> oldBanks) {
        // Create a set to capture all the bank Ids that transitioned from 'In Progress' to 'Completed'
        Set<Id> banksToCheck = new Set<Id>();
        
        for (CQ_RS_SQX_Bank__c bank : newBanks) {
            CQ_RS_SQX_Bank__c oldBank = oldBanks.get(bank.Id);
            if (oldBank.CQ_RS_Work_Staus__c == 'In Progress' && bank.CQ_RS_Work_Staus__c == 'Completed') {
                banksToCheck.add(bank.Id);
            }
        }
        
        // Only query once if there are bank IDs to check.
        if (!banksToCheck.isEmpty()) {
            // Use a map to easily fetch associated employees for each bank.
            Map<Id, List<CQ_RS_SQX_Employees__c>> bankToEmployeesMap = new Map<Id, List<CQ_RS_SQX_Employees__c>>();
            
            // Query employees associated with banks in the banksToCheck set
            for (CQ_RS_SQX_Employees__c employee : [SELECT Id, CQ_RS_SQX_Bank__c, CQ_RS_Resume__c FROM CQ_RS_SQX_Employees__c WHERE CQ_RS_SQX_Bank__c IN :banksToCheck AND CQ_RS_Resume__c != NULL]) {
                if (!bankToEmployeesMap.containsKey(employee.CQ_RS_SQX_Bank__c)) {
                    bankToEmployeesMap.put(employee.CQ_RS_SQX_Bank__c, new List<CQ_RS_SQX_Employees__c>());
                }
                bankToEmployeesMap.get(employee.CQ_RS_SQX_Bank__c).add(employee);
            }
            
            // Loop through the newBanks to check and apply validation
            for (CQ_RS_SQX_Bank__c bank : newBanks) {
                if (banksToCheck.contains(bank.Id) && (bankToEmployeesMap.get(bank.Id) == null || bankToEmployeesMap.get(bank.Id).isEmpty())) {
                    bank.CQ_RS_Work_Staus__c.addError(EDIT_ERROR_MSG1);
                }
            }
        }
    }
}