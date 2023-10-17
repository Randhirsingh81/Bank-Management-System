/**
* CQ_RS_Test_Banks - This test class is designed to verify and validate the behavior of bank records
* within the context of editing and completion. It focuses on ensuring that bank records are correctly
* restricted from editing when they have a 'Closed' status, and that an attempt to change the status
* to 'Completed' is prevented if there are employees associated with resumes.
* ************************Revision History************************
* Date           Author         Description
* --------------------------------------------------------------
* 2023-10-17     Randhir Singh   Initial version
* --------------------------------------------------------------
* ************************Revision History************************
*/
@isTest
public class CQ_RS_Test_Banks {
    
    // Test to prevent editing a record when the Work Status is "Closed."
    static testMethod void testPreventRecordEditing() {
        // Simulate running the test as a specific user.
        System.runAs(CQ_RS_CreateTestUser.createUserMethod()){
            
            // Create a closed bank in old data
            CQ_RS_SQX_Bank__c closedBank = new CQ_RS_SQX_Bank__c(
                Name = 'Closed Bank',
                CQ_RS_Work_Staus__c = 'Closed'
            );
            insert closedBank;
            
            // Attempt to update the closed bank (should fail)
            Test.startTest();
            closedBank.Name = 'Updated Closed Bank';
            try {
                update closedBank;
            } catch (DmlException e) {
                // Check that the expected error message is thrown
                System.assert(e.getMessage().contains(CQ_RS_Banks.EDIT_ERROR_MSG));
            }
            Test.stopTest();
            
            // Create an open bank in old data
            CQ_RS_SQX_Bank__c openBank = new CQ_RS_SQX_Bank__c(
                Name = 'Open Bank',
                CQ_RS_Work_Staus__c = 'In Progress'
            );
            insert openBank;
            
            // Update the open bank (should not fail)
            openBank.Name = 'Updated Open Bank';
            update openBank;
        }
    }
    
    // Test to prevent changing the Work Status to "Completed" when employees have resumes.
    static testMethod void testPreventRecordFromCompletion() {
        // Simulate running the test as a specific user.
        System.runAs(CQ_RS_CreateTestUser.createUserMethod()){
            // Create an 'In Progress' bank with at least one employee with a resume
            CQ_RS_SQX_Bank__c inProgressBankWithEmployees = new CQ_RS_SQX_Bank__c(
                Name = 'In Progress Bank with Employees',
                CQ_RS_Work_Staus__c = 'In Progress'
            );
            insert inProgressBankWithEmployees;
            
            // Create an employee with a resume
            CQ_RS_SQX_Employees__c employeeWithResume = new CQ_RS_SQX_Employees__c(
                Name = 'Employee with Resume',
                CQ_RS_SQX_Bank__c = inProgressBankWithEmployees.Id,
                CQ_RS_Resume__c = 'Resume Data'
            );
            insert employeeWithResume;
            
            // Attempt to change the status of the 'In Progress' bank with employees to 'Completed' (should fail)
            Test.startTest();
            inProgressBankWithEmployees.CQ_RS_Work_Staus__c = 'Completed';
            try {
                update inProgressBankWithEmployees;
            } catch (DmlException e) {
                // Check that the expected error message is thrown
                System.assert(e.getMessage().contains(CQ_RS_Banks.EDIT_ERROR_MSG1));
            }
            Test.stopTest();
        }
    }
}