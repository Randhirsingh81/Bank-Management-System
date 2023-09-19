public with sharing class ApprovalRequestController {
    @AuraEnabled(cacheable=true)
    public static List<ProcessInstanceWorkitem> getApprovalRequests() {
        // Query the ApprovalRequest object to fetch the approval requests
        List<ProcessInstanceWorkitem> requests = [SELECT Id,  CreatedById FROM ProcessInstanceWorkitem
];
        return requests;
    }
}