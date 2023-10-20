// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_CQ_RS_SQX_BANK__C from '@salesforce/schema/CQ_RS_SQX_Bank__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/CQ_RS_SQX_Bank__c.Name';

import FIELD_CQ_RS_WORKING_HOURS__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Working_Hours__c';

import FIELD_CQ_RS_SQX_ACCOUNT__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_SQX_Account__c';

import FIELD_CQ_RS_WORK_DETAIL__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Work_Detail__c';

import FIELD_CQ_RS_SQX_PART_FAMILY__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_SQX_Part_Family__c';

import FIELD_CQ_RS_START_DATE__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Start_Date__c';

import FIELD_CQ_RS_SQX_PART__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_SQX_Part__c';

import FIELD_CQ_RS_COMPLETION_DATE__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Completion_Date__c';

import FIELD_CQ_RS_DEPARTMENT__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Department__c';

import FIELD_CQ_RS_WORKING_DAYS__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Working_Days__c';

import FIELD_CQ_RS_SQX_ACCOUNT_OWNER__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_SQX_Account_Owner__c';

import FIELD_CQ_RS_WORK_STAUS__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Work_Staus__c';

import FIELD_OWNERID from '@salesforce/schema/CQ_RS_SQX_Bank__c.OwnerId';

import FIELD_CQ_RS_UPLOAD_FILE__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Upload_File__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    
import FIELD_CQ_RS_SQX_ACCOUNT__NAME from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_SQX_Account__r.Name';
    


    


    
import FIELD_CQ_RS_SQX_PART_FAMILY__NAME from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_SQX_Part_Family__r.Name';
    


    


    
import FIELD_CQ_RS_SQX_PART__NAME from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_SQX_Part__r.Name';
    


    


    


    


    
import FIELD_CQ_RS_SQX_ACCOUNT_OWNER__NAME from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_SQX_Account_Owner__r.Name';
    


    


    


    



// import section custom label
    
        
import CQRS_INFORMATION from '@salesforce/label/c.CQRS_INFORMATION';
        
    
        
import CQRS_CUSTOM_LINKS from '@salesforce/label/c.CQRS_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_CQ_RS_WORKING_HOURS__C,
    
    FIELD_CQ_RS_SQX_ACCOUNT__C,
    
    FIELD_CQ_RS_WORK_DETAIL__C,
    
    FIELD_CQ_RS_SQX_PART_FAMILY__C,
    
    FIELD_CQ_RS_START_DATE__C,
    
    FIELD_CQ_RS_SQX_PART__C,
    
    FIELD_CQ_RS_COMPLETION_DATE__C,
    
    FIELD_CQ_RS_DEPARTMENT__C,
    
    FIELD_CQ_RS_WORKING_DAYS__C,
    
    FIELD_CQ_RS_SQX_ACCOUNT_OWNER__C,
    
    FIELD_CQ_RS_WORK_STAUS__C,
    
    FIELD_OWNERID,
    
    FIELD_CQ_RS_UPLOAD_FILE__C,
    
    
    
        
    
        
    
        
    FIELD_CQ_RS_SQX_ACCOUNT__NAME,
        
    
        
    
        
    FIELD_CQ_RS_SQX_PART_FAMILY__NAME,
        
    
        
    
        
    FIELD_CQ_RS_SQX_PART__NAME,
        
    
        
    
        
    
        
    
        
    FIELD_CQ_RS_SQX_ACCOUNT_OWNER__NAME,
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        

        
    "CQ_RS_SQX_Account__c": FIELD_CQ_RS_SQX_ACCOUNT__NAME,
    

        

        
    "CQ_RS_SQX_Part_Family__c": FIELD_CQ_RS_SQX_PART_FAMILY__NAME,
    

        

        
    "CQ_RS_SQX_Part__c": FIELD_CQ_RS_SQX_PART__NAME,
    

        

        

        

        
    "CQ_RS_SQX_Account_Owner__c": FIELD_CQ_RS_SQX_ACCOUNT_OWNER__NAME,
    

        

        

        

};

const LOOKUP_FILTERS = {"CQ_RS_SQX_Part__c":{"fields":["CQ_RS_SQX_Part_Family__c"]},"CQ_RS_SQX_Account__c":{"filters":[{"field":"RecordTypeId","operator":"eq","isDynamic":false,"usv_function":"reference","usv_param":"Name","value":"Supplier"},{"field":"compliancequest__Active__c","operator":"eq","isDynamic":false,"value":"Yes"}],"logic":"and","fields":[]}};
const DYNAMIC_SOURCES = {"CQ_RS_SQX_Part__c":{"ns":"","componentname":"CQUI_RS_Filter_Products_By_ProductFamily"}};
const FORM_RULES = {"onLoad":{"invoke":{"action":[{"name":"CQ_RS_Bank_Auto_Populate_the_completion_date","ns":""}]}},"CQ_RS_Upload_File__c":{"required":{"fields":["CQ_RS_Department__c"],"filter":"record.CQ_RS_Department__c == 'Cyber Security' "}},"Name":{"setValues":[{"fields":["Name"],"filter":"record.Name   ","action":{"CQ_RS_Work_Staus__c":"Draft"}}]},"CQ_RS_Completion_Date__c":{"readonly":{"fields":["Name"],"filter":"record.Name   "}},"CQ_RS_SQX_Account__c":{"transfer":[{"fields":["CQ_RS_SQX_Account__c"],"filter":"record.CQ_RS_SQX_Account__c   ","action":{"OwnerId":["CQ_RS_SQX_Account_Owner__c"],"Owner":["CQ_RS_SQX_Account_Owner__r"]}}]},"CQ_RS_Working_Hours__c":{"required":{"fields":["CQ_RS_Department__c"],"filter":"record.CQ_RS_Department__c == 'IT' "}},"CQ_RS_Work_Detail__c":{"hidden":{"fields":["CQ_RS_Department__c"],"filter":"record.CQ_RS_Department__c == 'Cyber Security' "}},"CQ_RS_SQX_Account_Owner__c":{"readonly":{"fields":["Name"],"filter":"record.Name   "}}};
const FORMULA_FIELDS = {};

export default class cquiRSRsBankBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_CQ_RS_SQX_BANK__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true}

        // Extend rules
        this.lookupFilters = LOOKUP_FILTERS;
        this.dynamicSources = DYNAMIC_SOURCES;
        this.inputFormRules = FORM_RULES;
        this.systemFormRules = FORMULA_FIELDS;
        this.picklistValueSource = {
            
        };
        this.uiType = {"CQ_RS_Upload_File__c":{"type":"file","showFilePicker":true,"shareContent":true}};
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

    
    get v_CQ_RS_WORKING_HOURS__C() {
        return this.getValueFor(FIELD_CQ_RS_WORKING_HOURS__C.fieldApiName);
    }
    get f_CQ_RS_WORKING_HOURS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_WORKING_HOURS__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_WORKING_HOURS__C() {
        return lookupDisplayFields[FIELD_CQ_RS_WORKING_HOURS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_WORKING_HOURS__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_SQX_ACCOUNT__C() {
        return this.getValueFor(FIELD_CQ_RS_SQX_ACCOUNT__C.fieldApiName);
    }
    get f_CQ_RS_SQX_ACCOUNT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_SQX_ACCOUNT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_SQX_ACCOUNT__C() {
        return lookupDisplayFields[FIELD_CQ_RS_SQX_ACCOUNT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_SQX_ACCOUNT__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_WORK_DETAIL__C() {
        return this.getValueFor(FIELD_CQ_RS_WORK_DETAIL__C.fieldApiName);
    }
    get f_CQ_RS_WORK_DETAIL__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_WORK_DETAIL__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_WORK_DETAIL__C() {
        return lookupDisplayFields[FIELD_CQ_RS_WORK_DETAIL__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_WORK_DETAIL__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_SQX_PART_FAMILY__C() {
        return this.getValueFor(FIELD_CQ_RS_SQX_PART_FAMILY__C.fieldApiName);
    }
    get f_CQ_RS_SQX_PART_FAMILY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_SQX_PART_FAMILY__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_SQX_PART_FAMILY__C() {
        return lookupDisplayFields[FIELD_CQ_RS_SQX_PART_FAMILY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_SQX_PART_FAMILY__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_START_DATE__C() {
        return this.getValueFor(FIELD_CQ_RS_START_DATE__C.fieldApiName);
    }
    get f_CQ_RS_START_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_START_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_START_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_RS_START_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_START_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_SQX_PART__C() {
        return this.getValueFor(FIELD_CQ_RS_SQX_PART__C.fieldApiName);
    }
    get f_CQ_RS_SQX_PART__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_SQX_PART__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_SQX_PART__C() {
        return lookupDisplayFields[FIELD_CQ_RS_SQX_PART__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_SQX_PART__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_COMPLETION_DATE__C() {
        return this.getValueFor(FIELD_CQ_RS_COMPLETION_DATE__C.fieldApiName);
    }
    get f_CQ_RS_COMPLETION_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_COMPLETION_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_COMPLETION_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_RS_COMPLETION_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_COMPLETION_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_DEPARTMENT__C() {
        return this.getValueFor(FIELD_CQ_RS_DEPARTMENT__C.fieldApiName);
    }
    get f_CQ_RS_DEPARTMENT__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_DEPARTMENT__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_DEPARTMENT__C() {
        return lookupDisplayFields[FIELD_CQ_RS_DEPARTMENT__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_DEPARTMENT__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_WORKING_DAYS__C() {
        return this.getValueFor(FIELD_CQ_RS_WORKING_DAYS__C.fieldApiName);
    }
    get f_CQ_RS_WORKING_DAYS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_WORKING_DAYS__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_WORKING_DAYS__C() {
        return lookupDisplayFields[FIELD_CQ_RS_WORKING_DAYS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_WORKING_DAYS__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_SQX_ACCOUNT_OWNER__C() {
        return this.getValueFor(FIELD_CQ_RS_SQX_ACCOUNT_OWNER__C.fieldApiName);
    }
    get f_CQ_RS_SQX_ACCOUNT_OWNER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_SQX_ACCOUNT_OWNER__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_SQX_ACCOUNT_OWNER__C() {
        return lookupDisplayFields[FIELD_CQ_RS_SQX_ACCOUNT_OWNER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_SQX_ACCOUNT_OWNER__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_RS_WORK_STAUS__C() {
        return this.getValueFor(FIELD_CQ_RS_WORK_STAUS__C.fieldApiName);
    }
    get f_CQ_RS_WORK_STAUS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_WORK_STAUS__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_WORK_STAUS__C() {
        return lookupDisplayFields[FIELD_CQ_RS_WORK_STAUS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_WORK_STAUS__C.fieldApiName].fieldApiName);
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

    
    get v_CQ_RS_UPLOAD_FILE__C() {
        return this.getValueFor(FIELD_CQ_RS_UPLOAD_FILE__C.fieldApiName);
    }
    get f_CQ_RS_UPLOAD_FILE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_RS_UPLOAD_FILE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_RS_UPLOAD_FILE__C() {
        return lookupDisplayFields[FIELD_CQ_RS_UPLOAD_FILE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_RS_UPLOAD_FILE__C.fieldApiName].fieldApiName);
    }

    


    
        
    get CQRS_INFORMATION() {
        return CQRS_INFORMATION;
    }
        
    
        
    get CQRS_CUSTOM_LINKS() {
        return CQRS_CUSTOM_LINKS;
    }
        
    
}