import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';

const CUSTOMER_OBJECT = 'Our_Customers__c'; // Replace with the actual object name

export default class CreateCustomerRecord extends LightningElement {
    createRecord() {
        const fields = {}; // Define the field values for the new record
        const recordInput = { apiName: CUSTOMER_OBJECT, fields };

        createRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record created successfully',
                        variant: 'success',
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    })
                );
            });
    }
}