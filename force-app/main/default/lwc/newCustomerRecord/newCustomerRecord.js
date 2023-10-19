import { LightningElement } from 'lwc';
//import customStyles from '@salesforce/resourceUrl/newCustomerRecord/newCustomerRecord_css';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import My_Customer from '@salesforce/schema/My_Customers__c';

import Name from '@salesforce/schema/My_Customers__c.Name';

import AadharNumber from '@salesforce/schema/My_Customers__c.Aadhar_Number__c';
import Email from '@salesforce/schema/My_Customers__c.Email__c';
//import AccounCreationStatus from '@salesforce/schema/My_Customers__c.Account_Creation_Status__c';

import AccountType from '@salesforce/schema/My_Customers__c.Account_Type__c';

import City__c from '@salesforce/schema/My_Customers__c.City__c';

import ContactNumber from '@salesforce/schema/My_Customers__c.Contact_Number__c';

import Country from '@salesforce/schema/My_Customers__c.Country__c';

import FirstDepositAmount from '@salesforce/schema/My_Customers__c.First_Deposit_Amount__c';

import Gender from '@salesforce/schema/My_Customers__c.Gender__c';

import ContentDocumentId from '@salesforce/schema/ContentVersion.Id'; // Import ContentDocumentId field

 

//import Email from '@salesforce/schema/Account__c.Email__c';

 

 

export default class CreateAccountRecord extends NavigationMixin(LightningElement) {
    objectApiName=My_Customer;
   // customStyles = customStyles;
    fields = [Name,Gender,ContactNumber,Email, AadharNumber,Country,City__c,AccountType, FirstDepositAmount,ContentDocumentId];

 

    handleSuccess(event){

        const toastEvent=new ShowToastEvent({

            title:"Customer has been registered successfully !",

            message: "Customer Created ",

            variant: "success"

        });
        this[NavigationMixin.Navigate]({

            type: 'standard__objectPage',

            attributes: {

                objectApiName: 'My_Customers__c',

                actionName: 'list'

            }

        });

        this.dispatchEvent(toastEvent);
      

    }

    handleCancel() {

        // Use the NavigationMixin to navigate to a different page (e.g., the list view)

        this[NavigationMixin.Navigate]({

            type: 'standard__objectPage',

            attributes: {

                objectApiName: 'My_Customers__c',

                actionName: 'list'

            }

        });

    }
    
    }