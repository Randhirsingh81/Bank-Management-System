/**
* @description This trigger handles the Before Update operations for the CQ_RS_SQX_Bank__c object.
* It calls methods from the CQ_RS_Banks class to enforce business logic for preventing certain updates.
*
* ************************Revision History************************
* Date: 2023-10-17
* Author: Randhir Singh
* Description: Initial trigger creation to enforce business logic on CQ_RS_SQX_Bank__c updates.
* ************************Revision History************************
*/
trigger CQ_RS_Banks_Trigger on CQ_RS_SQX_Bank__c (before update) {
    
    // Perform operations related to Before Update
    if (Trigger.IsBefore) {
        if (Trigger.isUpdate) {
            // Call the PreventRecordFromCompletion method to prevent marking banks as 'Completed'
            CQ_RS_Banks.PreventRecordFromCompletion(Trigger.new, Trigger.oldMap);
            
            // Call the PreventRecordEditing method to prevent editing closed bank records
            CQ_RS_Banks.PreventRecordEditing(Trigger.new, Trigger.oldMap);
        }
    }
}