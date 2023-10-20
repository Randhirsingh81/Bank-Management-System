// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_CQ_RS_SQX_EMPLOYEES__C from '@salesforce/schema/CQ_RS_SQX_Employees__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/CQ_RS_SQX_Employees__c.Name';

import FIELD_OWNERID from '@salesforce/schema/CQ_RS_SQX_Employees__c.OwnerId';

import FIELD_CQ_RS_SQX_BANK__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_SQX_Bank__c';

import FIELD_CQ_RS_TITLE__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_Title__c';

import FIELD_CQ_RS_BIRTH_DATE__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_Birth_Date__c';

import FIELD_CQ_RS_SQX_USER__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_SQX_User__c';

import FIELD_CQ_RS_RESUME__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_Resume__c';

import FIELD_CREATEDBYID from '@salesforce/schema/CQ_RS_SQX_Employees__c.CreatedById';

import FIELD_LASTMODIFIEDBYID from '@salesforce/schema/CQ_RS_SQX_Employees__c.LastModifiedById';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    
import FIELD_CQ_RS_SQX_BANK__NAME from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_SQX_Bank__r.Name';
    


    


    


    
import FIELD_CQ_RS_SQX_USER__NAME from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_SQX_User__r.Name';
    


    


    


    



// import section custom label
    
        
import CQRS_INFORMATION from '@salesforce/label/c.CQRS_INFORMATION';
        
    
        
import CQRS_SYSTEM_INFORMATION from '@salesforce/label/c.CQRS_SYSTEM_INFORMATION';
        
    
        
import CQRS_CUSTOM_LINKS from '@salesforce/label/c.CQRS_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_OWNERID,
    
    FIELD_CQ_RS_SQX_BANK__C,
    
    FIELD_CQ_RS_TITLE__C,
    
    FIELD_CQ_RS_BIRTH_DATE__C,
    
    FIELD_CQ_RS_SQX_USER__C,
    
    FIELD_CQ_RS_RESUME__C,
    
    FIELD_CREATEDBYID,
    
    FIELD_LASTMODIFIEDBYID,
    
    
    
        
    
        
    
        
    FIELD_CQ_RS_SQX_BANK__NAME,
        
    
        
    
        
    
        
    FIELD_CQ_RS_SQX_USER__NAME,
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        

        
    "CQ_RS_SQX_Bank__c": FIELD_CQ_RS_SQX_BANK__NAME,
    

        

        

        
    "CQ_RS_SQX_User__c": FIELD_CQ_RS_SQX_USER__NAME,
    

        

        

        

};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiRSRsEmployeesBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_CQ_RS_SQX_EMPLOYEES__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true,"expando_unique_id_3":true}

        // Extend rules
        this.lookupFilters = LOOKUP_FILTERS;
        this.dynamicSources = DYNAMIC_SOURCES;
        this.inputFormRules = FORM_RULES;
        this.systemFormRules = FORMULA_FIELDS;
        this.picklistValueSource = {
            
        };
        this.uiType = {"CQ_RS_Resume__c":{"type":"file","showFilePicker":true,"shareContent":true}};
        this.parentRecordApi="";
        
    }


    @api
    get recordId() {
        return this._recordId;
    }
    set recordId(value) {
        this._recordId = value;
        this.parentId = value;
    }

    // getters for field value, display value and field metadata
    
    get v_NAME() {
        return this.getValueFor(FIELD_NAME.fieldApiName);
    }
    get f_NAME() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_NAME.fieldApiName] : {};
        return val;
    }

    get d_NAME() {
        return lookupDisplayFields[FIELD_NAME.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_NAME.fieldApiName].fieldApiName);
    }

    
    get v_OWNERID() {
        return this.getValueFor(FIELD_OWNERID.fieldApiName);
    }
    get f_OWNERID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_OWNERID.fieldApiName] : {};
        return val;
    }

    get d_OWNERID() {
        return lookupDisplayFields[FIELD_OWNERID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_OWNERID.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_SQX_BANK__C() {
        return this.getValueFor(FIELD_CQ_RS_SQX_BANK__C.fieldApiName);
    }
    get f_CQ_RS_SQX_BANK__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_SQX_BANK__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_SQX_BANK__C() {
        return lookupDisplayFields[FIELD_CQ_RS_SQX_BANK__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_SQX_BANK__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_TITLE__C() {
        return this.getValueFor(FIELD_CQ_RS_TITLE__C.fieldApiName);
    }
    get f_CQ_RS_TITLE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_TITLE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_TITLE__C() {
        return lookupDisplayFields[FIELD_CQ_RS_TITLE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_TITLE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_BIRTH_DATE__C() {
        return this.getValueFor(FIELD_CQ_RS_BIRTH_DATE__C.fieldApiName);
    }
    get f_CQ_RS_BIRTH_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_BIRTH_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_BIRTH_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_RS_BIRTH_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_BIRTH_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_SQX_USER__C() {
        return this.getValueFor(FIELD_CQ_RS_SQX_USER__C.fieldApiName);
    }
    get f_CQ_RS_SQX_USER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_SQX_USER__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_SQX_USER__C() {
        return lookupDisplayFields[FIELD_CQ_RS_SQX_USER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_SQX_USER__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_RESUME__C() {
        return this.getValueFor(FIELD_CQ_RS_RESUME__C.fieldApiName);
    }
    get f_CQ_RS_RESUME__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_RESUME__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_RESUME__C() {
        return lookupDisplayFields[FIELD_CQ_RS_RESUME__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_RESUME__C.fieldApiName].fieldApiName);
    }

    
    get v_CREATEDBYID() {
        return this.getValueFor(FIELD_CREATEDBYID.fieldApiName);
    }
    get f_CREATEDBYID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CREATEDBYID.fieldApiName] : {};
        return val;
    }

    get d_CREATEDBYID() {
        return lookupDisplayFields[FIELD_CREATEDBYID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CREATEDBYID.fieldApiName].fieldApiName);
    }

    
    get v_LASTMODIFIEDBYID() {
        return this.getValueFor(FIELD_LASTMODIFIEDBYID.fieldApiName);
    }
    get f_LASTMODIFIEDBYID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_LASTMODIFIEDBYID.fieldApiName] : {};
        return val;
    }

    get d_LASTMODIFIEDBYID() {
        return lookupDisplayFields[FIELD_LASTMODIFIEDBYID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_LASTMODIFIEDBYID.fieldApiName].fieldApiName);
    }

    


    
        
    get CQRS_INFORMATION() {
        return CQRS_INFORMATION;
    }
        
    
        
    get CQRS_SYSTEM_INFORMATION() {
        return CQRS_SYSTEM_INFORMATION;
    }
        
    
        
    get CQRS_CUSTOM_LINKS() {
        return CQRS_CUSTOM_LINKS;
    }
        
    
}