/**
* @description This class contains methods to handle various business logic related to the CQ_RS_SQX_Employees__c object.
* It enforces rules to prevent editing employee records under certain conditions, updates the 'Test__c' field in related 'CQ_RS_SQX_Bank__c' records,
* and prevents editing employees when their associated bank's work status is "Completed."
*
* ************************Revision History************************
* Date: 2023-10-17
* Author: Randhir Singh
* Description: Initial class creation with methods for handling employee-related logic.
* ************************Revision History************************
*/

public class CQ_RS_Employees {
    
    // Error Message for preventing editing when the Bank work status is "Completed"
    public static final String EDIT_ERROR_MSG = 'Employees records cannot be edited when the Bank work status is "Completed"'; // Use custom label
    
    /**
* @description Handles the before update operation for CQ_RS_SQX_Employees__c records.
* This method checks and prevents editing of employee records if the related bank's work status is "Completed."
* It also prevents changing the parent of an employee.
*
* @param newEmployees List of new CQ_RS_SQX_Employees__c records.
* @param OldEmployeesMap Map of old CQ_RS_SQX_Employees__c records.
*/
    public static void handleBeforeUpdate(List<CQ_RS_SQX_Employees__c> newEmployees, Map<Id, CQ_RS_SQX_Employees__c> OldEmployeesMap) {
        Set<Id> parentIds = new Set<Id>();
        Map<Id, CQ_RS_SQX_Bank__c> parents = new Map<Id, CQ_RS_SQX_Bank__c>();
        
        // Collect parent IDs from the updated child records
        for (CQ_RS_SQX_Employees__c employee : newEmployees) {
            parentIds.add(employee.CQ_RS_SQX_Bank__c);
        }
        
        // Query the parent objects to check their work status
        parents = new Map<Id, CQ_RS_SQX_Bank__c>(
            [SELECT Id, CQ_RS_Work_Staus__c FROM CQ_RS_SQX_Bank__c WHERE Id IN :parentIds]
        );
        
        // Loop through the child records and apply the status check
        for (CQ_RS_SQX_Employees__c employee : newEmployees) {
            CQ_RS_SQX_Bank__c parent = parents.get(employee.CQ_RS_SQX_Bank__c);
            CQ_RS_SQX_Employees__c oldEmp = OldEmployeesMap.get(employee.Id);
            if (oldEmp.CQ_RS_SQX_Bank__c != employee.CQ_RS_SQX_Bank__c) {
                employee.addError('You cannot change the Parent!');
            }
            // Check if the parent's work status is "Completed" and prevent editing
            if (parent != null && parent.CQ_RS_Work_Staus__c == 'Completed') {
                employee.addError(EDIT_ERROR_MSG);
            }
        }
    }
    
    /**
* @description Handles the prevention of editing employee records when the related bank has a "Closed" work status.
*
* @param newEmployees List of new CQ_RS_SQX_Employees__c records.
* @param oldEmployeeMap Map of old CQ_RS_SQX_Employees__c records.
*/
    public static void handlePreventEmployeeEditing(List<CQ_RS_SQX_Employees__c> newEmployees, Map<Id, CQ_RS_SQX_Employees__c> oldEmployeeMap) {
        
        // Collect the IDs of related banks with Closed Work Status
        Set<Id> closedBankIds = new Set<Id>();
        for (CQ_RS_SQX_Employees__c employee : [SELECT CQ_RS_SQX_Bank__c, CQ_RS_SQX_Bank__r.CQ_RS_Work_Staus__c FROM CQ_RS_SQX_Employees__c WHERE Id IN :newEmployees]) {
            if (employee.CQ_RS_SQX_Bank__c != null && employee.CQ_RS_SQX_Bank__r.CQ_RS_Work_Staus__c == 'Closed') {
                closedBankIds.add(employee.CQ_RS_SQX_Bank__c);
            }
        }
        
        // Iterate through the records in newEmployees and add an error if the related bank is Closed
        for (CQ_RS_SQX_Employees__c employee : newEmployees) {
            if (closedBankIds.contains(employee.CQ_RS_SQX_Bank__c)) {
                employee.addError('Editing is not allowed because the related bank is Closed.');
            }
        }
    }
    
    /**
* @description Handles the update of the 'Test__c' field in 'CQ_RS_SQX_Bank__c' based on 'CQ_RS_SQX_Employees__c' records.
* This method is invoked by the 'CQ_RS_Employees_Trigger' trigger when 'CQ_RS_SQX_Employees__c' records are inserted or deleted.
*
* @param newEmployees List of new CQ_RS_SQX_Employees__c records.
*/
    public static void handleAfterBankTestField(List<CQ_RS_SQX_Employees__c> newEmployees) {
        Set<Id> bankIdsToUpdate = new Set<Id>();
        
        for (CQ_RS_SQX_Employees__c employee : newEmployees) {
            if (employee.CQ_RS_SQX_Bank__c != null) {
                bankIdsToUpdate.add(employee.CQ_RS_SQX_Bank__c);
            }
        }
        // Get counts of employees for each bank
        List<AggregateResult> results = [
            SELECT CQ_RS_SQX_Bank__c, COUNT(Id) employeeCount
            FROM CQ_RS_SQX_Employees__c
            WHERE CQ_RS_SQX_Bank__c IN :bankIdsToUpdate
            GROUP BY CQ_RS_SQX_Bank__c
        ];
        
        // Build a map of bankId to its count of employees
        Map<Id, Integer> bankToEmployeeCount = new Map<Id, Integer>();
        for (AggregateResult ar : results) {
            bankToEmployeeCount.put((Id)ar.get('CQ_RS_SQX_Bank__c'), (Integer)ar.get('employeeCount'));
        }
        
        // Create a list of banks to update
        List<CQ_RS_SQX_Bank__c> banksToUpdate = new List<CQ_RS_SQX_Bank__c>();
        for (Id bankId : bankIdsToUpdate) {
            CQ_RS_SQX_Bank__c bank = new CQ_RS_SQX_Bank__c(Id = bankId);
            bank.Test__c = (bankToEmployeeCount.containsKey(bankId) && bankToEmployeeCount.get(bankId) > 0) ? 'Yes' : 'No';
            banksToUpdate.add(bank);
        }
        
        if (!banksToUpdate.isEmpty()) {
            update banksToUpdate;
        }
    }
}