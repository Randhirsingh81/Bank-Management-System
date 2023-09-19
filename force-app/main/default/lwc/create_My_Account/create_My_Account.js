import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import bank_photos from '@salesforce/resourceUrl/bank_photos';

export default class CreateCustomerButton extends NavigationMixin(LightningElement) {
 bgimage = bank_photos + '/bank_photos/bank1.png';
    createCustomer() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'My_Customers__c',
                actionName: 'new'
            }
        });
    }
    createTransaction() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'My_Transactions__c',
                actionName: 'new'
            }
        });
    }
}