/**
* CQ_RS_SQX_Bank_Completion_Date_FlowTest - This test class is responsible for testing the behavior of an Auto-Launched Flow
* that auto-populates the completion date for CQ_RS_SQX_Bank__c records.

* Date           Author               Description
* ---------------------------------------------------------------
* 2023-10-17     Randhir Singh        Initial version
* ---------------------------------------------------------------
* ************************Revision History************************
*/
@isTest
public class CQ_RS_SQX_Bank_Completion_Date_FlowTest {
    
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
    /**
* Test method to validate an Auto-Launched Flow's behavior.
*/
    @isTest
    static void testAutoLaunchedFlow() {
        // Simulate running the test as a specific user.
       user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        
        System.runAs(Usertest){            // 1. Insert a test record without the expected updates from the Flow
            CQ_RS_SQX_Bank__c testBank = new CQ_RS_SQX_Bank__c(
                Name = 'Test bank'
            );
            insert testBank;
            
            // Set up Flow and its variables
            Flow.Interview.CQ_RS_Bank_Auto_Populate_the_completion_date myflow = new Flow.Interview.CQ_RS_Bank_Auto_Populate_the_completion_date(
                new Map<String, Object> {
                    'InRecord' => testBank
                        }
            );
            
            Test.startTest();
            
            // Execute the flow
            myflow.start();
            
            Test.stopTest();
            
            // Retrieve the OutRecord variable from the flow
            CQ_RS_SQX_Bank__c outBank = (CQ_RS_SQX_Bank__c)myflow.getVariableValue('OutRecord');
            
            // Validate the expected changes on OutRecord
            System.assertEquals(Date.today().addDays(10), outBank.CQ_RS_Completion_Date__c, 'Target date on OutRecord should be 10 days ahead of the current date.');
        }
    }
}