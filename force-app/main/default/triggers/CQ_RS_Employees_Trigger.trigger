/**
* @description This trigger handles Before and After events for the CQ_RS_SQX_Employees__c object.
* It enforces business logic for preventing certain updates and updating related bank records.
*
* ************************Revision History************************
* Date: 2023-10-17
* Author: Randhir Singh
* Description: Initial trigger creation to enforce business logic on CQ_RS_SQX_Employees__c records.
* ************************Revision History************************
*/
trigger CQ_RS_Employees_Trigger on CQ_RS_SQX_Employees__c (After insert, After delete, before update, before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            // Before Update: Call the handleBeforeUpdate method for preventing editing
            CQ_RS_Employees.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
        } else if (Trigger.isDelete) {
            // Before Delete: Call the handlePreventEmployeeEditing method to prevent deleting employees
            CQ_RS_Employees.handlePreventEmployeeEditing(Trigger.old, Trigger.oldMap);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // After Insert: Call the handleAfterBankTestField method for updating related bank records
            CQ_RS_Employees.handleAfterBankTestField(Trigger.new);
        } else if (Trigger.isDelete) {
            // After Delete: Call the handleAfterBankTestField method for updating related bank records
            CQ_RS_Employees.handleAfterBankTestField(Trigger.old);
        }
    }
}