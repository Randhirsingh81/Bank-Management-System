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
    
    // Define the test user and store the user's details
    private static User testUser;
    
    @testSetup
    static void setupTestData() {
        // Create a test user
        testUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'TestUser',
            Email = 'testuser@example.com',
            Username = 'testuser123@example1.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        
        // Insert the test user
        insert testUser;
        // Query the PermissionSet by its name
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CQ_RS_Common_Permission_Set' LIMIT 1];
        
        if (ps != null) {
            // Assign the Permission Set to the test user
            PermissionSetAssignment psAssignment = new PermissionSetAssignment(
                AssigneeId = testUser.Id,
                PermissionSetId = ps.Id
            );
            
            insert psAssignment;
        } else {
            System.debug('PermissionSet not found. Check the name.');
        }
        
    }
    
    
    // Test to prevent editing a record when the Work Status is "Closed."
    static testMethod void testPreventRecordEditing() {
        // Simulate running the test as a specific user.
        user test=[select id , username from user where Username = 'testuser123@example1.com' LIMIT 1];
        System.runAs(test){
            
            // Create a closed bank in old data
            CQ_RS_SQX_Bank__c closedBank = new CQ_RS_SQX_Bank__c(
                Name = 'Closed Bank',
                CQ_RS_Work_Staus__c = 'Closed'
            );
            insert closedBank;
            
            // Attempt to update the closed bank (should fail)
            
            closedBank.Name = 'Updated Closed Bank';
            Database.SaveResult result = Database.update (closedBank, false);
            
            
            
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('Updating the status is not allowed for closed banks. Record is locked from editing', result.getErrors()[0].getMessage());
            
        }
        
        
    }
    
    
    // Test to prevent changing the Work Status to "Completed" when employees have resumes.
    static testMethod void testPreventRecordFromCompletion() {
        user test=[select id , username from user where Username = 'testuser123@example1.com' LIMIT 1];
        // Simulate running the test as a specific user.
        System.runAs(test){
            // Create an 'In Progress' bank with at least one employee with a resume
            CQ_RS_SQX_Bank__c inProgressBankWithEmployees = new CQ_RS_SQX_Bank__c(
                Name = 'In Progress Bank with Employees',
                CQ_RS_Work_Staus__c = 'In Progress'
            );
            insert inProgressBankWithEmployees;
            
            // Create an employee with a resume
            CQ_RS_SQX_Employees__c employeeWithResume = new CQ_RS_SQX_Employees__c(
                Name = 'Employee with Resume',
                CQ_RS_SQX_Bank__c = inProgressBankWithEmployees.Id
                
            );
            insert employeeWithResume;
            
            // Attempt to change the status of the 'In Progress' bank with employees to 'Completed' (should fail)
            
            inProgressBankWithEmployees.CQ_RS_Work_Staus__c = 'Completed';
            Database.SaveResult result = Database.update (inProgressBankWithEmployees, false);
            
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('At least one resume of any Employees should be there for work status to be completed.', result.getErrors()[0].getMessage());
        }
    }
}