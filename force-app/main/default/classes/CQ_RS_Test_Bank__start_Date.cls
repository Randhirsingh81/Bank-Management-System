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
    // Custom error message for the validation rule
    private static final String VAL_ERROR_MESSAGE = 'Start date must be less the completed date';
    
    /**
* Test method to validate the validation rule for Start Date.
*/
    @isTest static void testDateCondition() {
        // Simulate running the test as a specific user.
        System.runAs(CQ_RS_CreateTestUser.createUserMethod()){
            
            // Create a test record with CQ_RS_Start_Date__c >= CQ_RS_Completion_Date__c
            CQ_RS_SQX_Bank__c testBank = new CQ_RS_SQX_Bank__c(
                Name = 'Test Restaurant',
                CQ_RS_Start_Date__c = Date.today(),
                CQ_RS_Completion_Date__c = Date.today().addDays(-5) // Making completion date 5 days before the start date
            );
            
            Exception expectedException;
            try {
                insert testBank;
            } catch (System.DmlException e) {
                expectedException = e;
            }
            
            // Assertions
            System.assertNotEquals(null, expectedException, 'A DML Exception should have been thrown due to the validation rule.');
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', expectedException.getDmlType(0).name(), 'Expected a custom validation exception.');
            System.assert(expectedException.getMessage().contains(VAL_ERROR_MESSAGE), 'Custom error message should be displayed.');
        }
    }
}