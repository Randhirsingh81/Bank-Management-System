/**
* CQ_RS_Test_Employees - This test class is designed to validate the behavior of employee records within the context of
* related bank records. It includes tests to ensure that:
* 
* 1. An employee record cannot be updated when the related bank has a 'Closed' status.
* 2. A new employee cannot be created when the related bank has a 'Completed' status.
* 3. An employee cannot be deleted when the related bank is 'In Progress.'
* 4. The 'Test__c' field on the related bank is set to 'No' when there are no related employees.
* 5. The 'Test__c' field on the related bank is set to 'No' after deleting related employees.
* ************************Revision History************************
* Date           Author           Description
* --------------------------------------------------------------
* 2023-10-17     Randhir Singh     Initial version
* --------------------------------------------------------------
* ************************Revision History************************
*/
@isTest
public class CQ_RS_Test_Employees {
    // Define the test user and store the user's details
    private static User testUser;
    
    @testSetup
    static void setupTestData() {
        // Create a test user
        testUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'TestUser',
            Email = 'testuser@example.com',
            Username = 'testuser1@example1.com',
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
    
    
    // Test updating an employee when the related bank is not "Completed."
    static testMethod void testBeforeUpdateTrigger() {
        user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        
        System.runAs(Usertest){
            // Create a test CQ_RS_SQX_Bank__c record with a Work Status not "Completed."
            CQ_RS_SQX_Bank__c testBank = new CQ_RS_SQX_Bank__c(
                CQ_RS_Work_Staus__c = 'In Progress'
            );
            insert testBank;
            
            // Create a test CQ_RS_SQX_Employees__c record associated with the above bank.
            CQ_RS_SQX_Employees__c testEmployee = new CQ_RS_SQX_Employees__c(
                Name = 'Test Employee',
                CQ_RS_SQX_Bank__c = testBank.Id
            );
            insert testEmployee;
            
            // Attempt to update the Employee record (should fail due to validation rule).
            
            Test.startTest();
            testEmployee.Name = 'Updated Employee Name';
            Database.SaveResult result = Database.update (testEmployee, false);
            
            Test.stopTest();
            
            System.assert(result.isSuccess());
        }
    }
    
    
    // Test preventing the creation of an employee when the related bank is "Completed."
    @isTest
    static void testPreventEmployeeEditing() {
        user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        
        System.runAs(Usertest){
            // Create a bank with "Completed" status
            CQ_RS_SQX_Bank__c completedBank = new CQ_RS_SQX_Bank__c(
                Name = 'Completed Bank',
                CQ_RS_Work_Staus__c = 'Completed'
            );
            insert completedBank;
            
            CQ_RS_SQX_Bank__c completedBank2 = new CQ_RS_SQX_Bank__c(
                Name = 'Completed Bank2',
                CQ_RS_Work_Staus__c = 'Completed'
            );
            insert completedBank2;
            
            // Create an employee related to the completed bank (should fail due to validation rule)
            CQ_RS_SQX_Employees__c employeeCompletedBank = new CQ_RS_SQX_Employees__c(
                Name = 'Employee for Completed Bank',
                CQ_RS_SQX_Bank__c = completedBank.Id
            );
            insert employeeCompletedBank;
            
            Test.startTest();
            
            
            employeeCompletedBank.CQ_RS_SQX_Bank__c = completedBank2.Id;
            Database.SaveResult result = Database.update(employeeCompletedBank, false);
            
            
            Test.stopTest();
            
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('Employees records cannot be edited when the Bank work status is "Completed"', result.getErrors()[0].getMessage());
        }
    }    
    
    
    
    // Test verifying that the 'Test__c' field is set to 'No' when there are no related employees.
    @isTest
    static void testInsertBankTestField() {
        user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        
        System.runAs(Usertest){
            // Create a bank with no related employees
            CQ_RS_SQX_Bank__c bankNoEmployees = new CQ_RS_SQX_Bank__c(
                Name = 'Bank with No Employees',
                CQ_RS_Work_Staus__c = 'In Progress'
            );
            insert bankNoEmployees;
            
            // Ensure that the 'Test__c' field is 'No'
            bankNoEmployees = [SELECT Test__c FROM CQ_RS_SQX_Bank__c WHERE Id = :bankNoEmployees.Id];
            System.assertEquals('No', bankNoEmployees.Test__c, 'value of test should be No ');
        }
    }
    
    // Test verifying that the 'Test__c' field is set to 'No' after deleting related employees.
    @isTest
    static void testDeleteBankTestField() {
        user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        
        System.runAs(Usertest){
            // Create a bank with related employees
            CQ_RS_SQX_Bank__c bankWithEmployees = new CQ_RS_SQX_Bank__c(
                Name = 'Bank with Employees',
                CQ_RS_Work_Staus__c = 'In Progress'
            );
            insert bankWithEmployees;
            
            // Create an employee related to the bank
            CQ_RS_SQX_Employees__c employee = new CQ_RS_SQX_Employees__c(
                Name = 'Employee',
                CQ_RS_SQX_Bank__c = bankWithEmployees.Id
            );
            insert employee;
            
            // Delete the employee
            delete employee;
            
            // Ensure that the 'Test__c' field is 'No'
            bankWithEmployees = [SELECT Test__c FROM CQ_RS_SQX_Bank__c WHERE Id = :bankWithEmployees.Id];
            System.assertEquals('No', bankWithEmployees.Test__c);
        }
    }
}