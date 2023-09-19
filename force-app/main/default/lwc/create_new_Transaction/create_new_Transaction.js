import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class CreateCustomerButton extends NavigationMixin(LightningElement) {

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