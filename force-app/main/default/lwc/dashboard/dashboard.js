import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getApprovalRequests from '@salesforce/apex/ApprovalRequestController.getApprovalRequests';

export default class ReportChartButton extends NavigationMixin(LightningElement) {
    navigateToReportChart() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '01Z5j000000q8NGEAY', // it is  the Record Page ID 
                actionName: 'view',
            },
        });
    }

    @track showRequests = false;
    @track approvalRequests;

    showApprovalRequests() {
        // Fetch the approval requests data using an Apex method
        getApprovalRequests()
            .then(result => {
                this.approvalRequests = result;
                this.showRequests = true;
            })
            .catch(error => {
                console.error(error);
            });
    }
}