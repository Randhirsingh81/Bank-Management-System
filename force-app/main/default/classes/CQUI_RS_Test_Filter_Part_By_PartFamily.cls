/**
* CQUI_RS_Test_Filter_Part_By_PartFamily - This test class is responsible for verifying the behavior of the
* CQUI_RS_Filter_Products_By_ProductFamily class, which is used to filter products by a specific Part Family.
*
* ************************Revision History************************
* Date           Author               Description
* ---------------------------------------------------------------
* 2023-10-16     Randhir Singh         Initial version
* ---------------------------------------------------------------
* ************************Revision History************************
*/
@isTest
private class CQUI_RS_Test_Filter_Part_By_PartFamily {
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
     
    // Test method to verify the filtering of products by a specific Part Family.
    static testMethod void testFilterProducts() {
        // Simulate running the test as a specific user.
        user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        
        System.runAs(Usertest){
            // Create a test Part Family
            compliancequest__SQX_Part_Family__c testPartFamily = new compliancequest__SQX_Part_Family__c(
                Name = 'Test Part Family'
            );
            insert testPartFamily;
            
            // Create some test Part records associated with the Part Family
            compliancequest__SQX_Part__c testPart1 = new compliancequest__SQX_Part__c(
                Name = 'Part 1',
                compliancequest__Part_Family__c = testPartFamily.Id,
                compliancequest__Part_Number__c = 'P123',
                compliancequest__Part_Risk_Level__c = 3 // Set a valid Part Risk Level
            );
            compliancequest__SQX_Part__c testPart2 = new compliancequest__SQX_Part__c(
                Name = 'Part 2',
                compliancequest__Part_Family__c = testPartFamily.Id,
                compliancequest__Part_Number__c = 'P124',
                compliancequest__Part_Risk_Level__c = 4 // Set a valid Part Risk Level
            );
            insert new List<compliancequest__SQX_Part__c>{testPart1, testPart2};
                
                // Instantiate the filter class to be tested
                CQUI_RS_Filter_Products_By_ProductFamily filter = new CQUI_RS_Filter_Products_By_ProductFamily();
            
            // Create test parameters
            Map<String, Object> currentRecord = new Map<String, Object>{
                'CQ_RS_SQX_Part_Family__c' => testPartFamily.Id
                    };
                        String searchTerm = 'Part';
            
            // Call the filter method to retrieve filtered records
            List<SObject> filteredRecords = CQUI_RS_Filter_Products_By_ProductFamily.getRecords(currentRecord, searchTerm);
            
            // Verify that the filtering works as expected
            System.assertEquals(2, filteredRecords.size(), 'Both test Part records should be included in the filtered results.');
            currentRecord.put('CQ_RS_SQX_Part_Family__c', null );
            filteredRecords = CQUI_RS_Filter_Products_By_ProductFamily.getRecords(currentRecord, 'Part 2');
            System.assertEquals(0, filteredRecords.size(), '0 Part records should be included in the filtered results.');
           
           
        }
    }
}