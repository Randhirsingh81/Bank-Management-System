/**
 * CQ_RS_CreateTestUser - This class provides a method for creating a test user with a specific profile and assigns a
 * permission set to the user. The created test user is suitable for testing purposes and is associated with a defined
 * permission set and profile.
 *
 * ************************Revision History************************
 * Date           Author           Description
 * --------------------------------------------------------------
 * 2023-10-17     Randhir Singh     Initial version
 * --------------------------------------------------------------
 * ************************Revision History************************
 */
public class CQ_RS_CreateTestUser {
    
    // Method to create a test user with a specific profile and assign a permission set
    public static User createUserMethod() {
        // Query the Permission Set by name
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CQ_RS_Common_Permission_Set' LIMIT 1];
        
        // Query the Profile by name
        Profile profile1 = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        // Create a test user with the specified profile and user details
        User testUser = new User(
            ProfileId = profile1.Id,
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'standarduser@testo1rg.com'
        );
        
        // Insert the test user into the database
        insert testUser;
        
        // Assign the permission set to the user
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = testUser.Id,
            PermissionSetId = ps.Id
        );
        insert psa;
        
        // Return the created test user for further use
        return testUser;
    }
}