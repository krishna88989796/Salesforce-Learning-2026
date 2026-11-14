import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getOpportunities from '@salesforce/apex/OpportunityRelatedListController.getOpportunities';

const COLUMNS = [
    { label: 'Opportunity Name', fieldName: 'oppUrl', type: 'url',
      typeAttributes: { label: { fieldName: 'Name' }, target: '_self' } },
    { label: 'Stage', fieldName: 'StageName' },
    { label: 'Amount', fieldName: 'Amount', type: 'currency' },
    { label: 'Close Date', fieldName: 'CloseDate', type: 'date-local' },
    { label: 'Owner', fieldName: 'OwnerName' }
];

export default class OpportunityRelatedList extends LightningElement {
    @api recordId; // Account Id, automatically bound on record page
    columns = COLUMNS;
    opportunities = [];
    isModalOpen = false;
    wiredResult;

    @wire(getOpportunities, { accountId: '$recordId' })
    wiredOpps(result) {
        this.wiredResult = result;
        if (result.data) {
            this.opportunities = result.data.map(opp => ({
                ...opp,
                oppUrl: '/' + opp.Id,
                OwnerName: opp.Owner ? opp.Owner.Name : ''
            }));
        }
    }

    get defaultFieldValues() {
        return { AccountId: this.recordId };
    }

    handleNewClick() {
        this.isModalOpen = true;
    }

    handleCancel() {
        this.isModalOpen = false;
    }

    handleSuccess(event) {
        // Do NOT navigate anywhere here — that's the key to staying put
        this.isModalOpen = false;
        return refreshApex(this.wiredResult);
    }

    handleError(event) {
        console.error('Error creating Opportunity', event.detail);
    }
}