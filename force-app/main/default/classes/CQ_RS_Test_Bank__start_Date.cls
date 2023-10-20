/**
* CQ_RS_Bank_Test_start_Date - This test class is responsible for testing the validation rule
* that ensures the 'Start Date' is less than the 'Completion Date' in the CQ_RS_SQX_Bank__c object.
*
* ************************Revision History************************
* Date           Author               Description
* ---------------------------------------------------------------
* 16/10/2023     Randhir Singh           Initial version
* ---------------------------------------------------------------
* ************************Revision History************************
*/
@isTest
private class CQ_RS_Bank_Test_start_Date {
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
    // Custom error message for the validation rule
    private static final String VAL_ERROR_MESSAGE = 'Start date must be less the completed date';
    
    /**
* Test method to validate the validation rule for Start Date.
*/
    @isTest static void testDateCondition() {
        // Simulate running the test as a specific user.
       user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        
        System.runAs(Usertest){
            
            // Create a test record with CQ_RS_Start_Date__c >= CQ_RS_Completion_Date__c
            CQ_RS_SQX_Bank__c testBank = new CQ_RS_SQX_Bank__c(
                Name = 'Test Restaurant',
                CQ_RS_Start_Date__c = Date.today(),
                CQ_RS_Completion_Date__c = Date.today().addDays(-5) // Making completion date 5 days before the start date
            );
         Test.startTest();
            Database.saveResult Result = database.insert(testBank, false);
         Test.stopTest();
            System.assert(!result.isSuccess());
        }
    }
}