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
    
    // Test updating an employee when the related bank is not "Completed."
    static testMethod void testBeforeUpdateTrigger() {
        System.runAs(CQ_RS_CreateTestUser.createUserMethod()){
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
            try {
                testEmployee.Name = 'Updated Employee Name';
                update testEmployee;
            } catch (DmlException e) {
                System.assert(e.getMessage().contains('Employees records cannot be edited when the Bank work status is "Completed"'));
            }
            Test.stopTest();
        }
    }
    
    // Test preventing the creation of an employee when the related bank is "Completed."
    @isTest
    static void testPreventEmployeeEditing() {
        System.runAs(CQ_RS_CreateTestUser.createUserMethod()){
            // Create a bank with "Completed" status
            CQ_RS_SQX_Bank__c completedBank = new CQ_RS_SQX_Bank__c(
                Name = 'Completed Bank',
                CQ_RS_Work_Staus__c = 'Completed'
            );
            insert completedBank;
            
            // Create an employee related to the completed bank (should fail due to validation rule)
            CQ_RS_SQX_Employees__c employeeCompletedBank = new CQ_RS_SQX_Employees__c(
                Name = 'Employee for Completed Bank',
                CQ_RS_SQX_Bank__c = completedBank.Id
            );
            
            Test.startTest();
            try {
                insert employeeCompletedBank;
            } catch (DmlException e) {
                // Check that the expected error message is thrown
                System.assert(e.getMessage().contains('Employees records cannot be edited when the Bank work status is "Completed"'));
            }
            Test.stopTest();
        }
    }    
    
    // Test preventing the deletion of an employee when a related bank is "In Progress."
    @isTest
    static void testPreventEmployeeEditingOnDelete() {
        System.runAs(CQ_RS_CreateTestUser.createUserMethod()){
            // Create a bank
            CQ_RS_SQX_Bank__c bank = new CQ_RS_SQX_Bank__c(
                Name = 'Bank',
                CQ_RS_Work_Staus__c = 'In Progress'
            );
            insert bank;
            
            // Create an employee related to the bank
            CQ_RS_SQX_Employees__c employee = new CQ_RS_SQX_Employees__c(
                Name = 'Employee',
                CQ_RS_SQX_Bank__c = bank.Id
            );
            insert employee;
            
            // Attempt to delete the employee (should fail due to "You cannot change the Parent!" validation rule)
            Test.startTest();
            try {
                delete employee;
            } catch (DmlException e) {
                // Check that the expected error message is thrown
                System.assert(e.getMessage().contains('You cannot change the Parent!'));
            }
            Test.stopTest();
        }
    }
    
    // Test verifying that the 'Test__c' field is set to 'No' when there are no related employees.
    @isTest
    static void testInsertBankTestField() {
        System.runAs(CQ_RS_CreateTestUser.createUserMethod()){
            // Create a bank with no related employees
            CQ_RS_SQX_Bank__c bankNoEmployees = new CQ_RS_SQX_Bank__c(
                Name = 'Bank with No Employees',
                CQ_RS_Work_Staus__c = 'In Progress'
            );
            insert bankNoEmployees;
            
            // Ensure that the 'Test__c' field is 'No'
            bankNoEmployees = [SELECT Test__c FROM CQ_RS_SQX_Bank__c WHERE Id = :bankNoEmployees.Id];
            System.assertEquals('No', bankNoEmployees.Test__c);
        }
    }
    
    // Test verifying that the 'Test__c' field is set to 'No' after deleting related employees.
    @isTest
    static void testDeleteBankTestField() {
        System.runAs(CQ_RS_CreateTestUser.createUserMethod()){
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