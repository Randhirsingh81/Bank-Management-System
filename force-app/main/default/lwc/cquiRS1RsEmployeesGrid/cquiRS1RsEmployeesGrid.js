import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import CQ_RS_SQX_EMPLOYEES__C from '@salesforce/schema/CQ_RS_SQX_Employees__c';


import FIELDS_PARENT_ID from '@salesforce/schema/CQ_RS_SQX_Bank__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/CQ_RS_SQX_Bank__c.Name';

import FIELDS_PARENT_CQ_RS_WORK_STAUS__C from '@salesforce/schema/CQ_RS_SQX_Bank__c.CQ_RS_Work_Staus__c';





//import fields


import FIELDS_CQ_RS_SQX_EMPLOYEES__C_NAME from '@salesforce/schema/CQ_RS_SQX_Employees__c.Name';

import FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_BANK__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_SQX_Bank__c';

import FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_BANK__R_NAME from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_SQX_Bank__r.Name';

import FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_BIRTH_DATE__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_Birth_Date__c';

import FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_RESUME__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_Resume__c';

import FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_USER__C from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_SQX_User__c';

import FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_USER__R_ALIAS from '@salesforce/schema/CQ_RS_SQX_Employees__c.CQ_RS_SQX_User__r.Alias';

import FIELDS_CQ_RS_SQX_EMPLOYEES__C_CREATEDDATE from '@salesforce/schema/CQ_RS_SQX_Employees__c.CreatedDate';


//import customlabels (Labels must not have space)

import CQRS1_NEW from '@salesforce/label/c.CQRS1_NEW';

import CQRS1_MODIFY_ALL from '@salesforce/label/c.CQRS1_MODIFY_ALL';


import CQRS1_EMPLOYEES from '@salesforce/label/c.CQRS1_EMPLOYEES';




//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_CQ_RS_SQX_EMPLOYEES__C_NAME,

        
    FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_BANK__C,
                
            
    FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_BIRTH_DATE__C,

        
    FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_RESUME__C,

        
    FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_USER__C,
                
            
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

    FIELDS_PARENT_CQ_RS_WORK_STAUS__C,

];

export default class cquiRS1RsEmployeesGrid  extends CqGridForm {
    @api
    maxRows;

    @api
    maxColumns;

    @api
    gridType;

    @api
    flexipageRegionWidth;
    
    constructor() {
        super();
        this.fields = columns;
        this.columns = columns;
        this.mainObject = CQ_RS_SQX_EMPLOYEES__C;
        this.relationalField = FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_BANK__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQRS1_NEW,"name":"std_new","componentName":"cqui-r-s-rs-employees-both"},{"label": CQRS1_MODIFY_ALL,"name":"showEditSelected","componentName":"cqui-r-s-rs-employees-both","component_namespace":"c-","action_type":"","bulk":true},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {"edit":{"fields":["CQ_RS_Work_Staus__c","CQ_RS_Work_Staus__c"],"visible":"parent.CQ_RS_Work_Staus__c.value == 'Draft'   && parent.CQ_RS_Work_Staus__c.value == 'In Progress'  "},"delete":{"fields":["CQ_RS_Work_Staus__c","CQ_RS_Work_Staus__c"],"visible":"parent.CQ_RS_Work_Staus__c.value == 'Draft'   && parent.CQ_RS_Work_Staus__c.value == 'In Progress'  "}};
        

        
        this.headerFormRules = {"std_new":{"fields":["CQ_RS_Work_Staus__c","CQ_RS_Work_Staus__c"],"visible":"parent.CQ_RS_Work_Staus__c.value == 'Draft'   && parent.CQ_RS_Work_Staus__c.value == 'In Progress'  "}};
        

        
        this.iconName = 'action:edit_groups';
        
        
    
        this.lookupFields[FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_BANK__C.fieldApiName] = FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_BANK__R_NAME;
                
                
            
        this.lookupFields[FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_USER__C.fieldApiName] = FIELDS_CQ_RS_SQX_EMPLOYEES__C_CQ_RS_SQX_USER__R_ALIAS;
                
                
            
        
        this.orderBy = FIELDS_CQ_RS_SQX_EMPLOYEES__C_CREATEDDATE;
        

        
        this.sortOrder = 'ASC NULLS LAST';
        

        
        this.customTitle = CQRS1_EMPLOYEES;
        

        

        

        

        this.componentName="c:cquiRS1RsEmployeesGrid";

    }

    connectedCallback(){
        this.maxRowsToDisplay = this.maxRows;
        this.maxColumnsToDisplay = this.maxColumns;
        this.gridDesktopView = this.gridType;
    }

    @api 
    get recordId() {
        return this._recordId;
    }

    set recordId(value) {
        this._recordId = value;
    }

}