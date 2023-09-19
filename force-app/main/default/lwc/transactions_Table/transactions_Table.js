import { LightningElement, wire, track } from 'lwc';
import getTransactions from '@salesforce/apex/MyTransactionsController.getTransactions';

export default class MyTransactionsList extends LightningElement {
    transactions;

    @wire(getTransactions)
    wiredTransactions({ data, error }) {
        if (data) {
            this.transactions = data;
        } else if (error) {
            console.error(error);
        }
    }

    @track showTableFlag = false;
    @track buttonLabel = 'Show Transactions';


    // showTable() {
    //     this.showTableFlag = !this.showTableFlag;
        
    // }
    // hideTable() {
    //     this.showTableFlag = false;

    // }

    
    toggleTable() {
        this.showTableFlag = !this.showTableFlag;
        this.buttonLabel = this.showTableFlag ? 'Hide Transactions' : 'Show Transactions';
    }
}