/* eslint-disable no-console */
import { LightningElement } from 'lwc';

export default class LookupContainer extends LightningElement {

    utilLookupConfig = {
        label: 'Label for Lookup :)', // label text
        isLabelHidden: false, // to hide label if needed
        placeholder: 'Lookup for Account', // placeholder for input field
        listSize: 7, // max number of list items (5 or 7 or 10 only)

        icon: { // icon config
            name: 'standard:account', // SLDS icon
            size: 'small',
            alternativeText: 'Account'
        },

        searchConfigMap: { // config for search
            objectName: 'Account',
            fieldForQueryList: ['Name', 'Phone', 'Type', 'Site', 'SomeField__c'],
            fieldForSearchList: ['Name', 'Site'], // fields for search through 'Name LIKE %text for search% OR Site ...'
            fieldForOrderList: ['Name'], // optional - fields for 'ORDER BY Name, Site'
            fieldToShowList: [ // fields to display in the result list
                { fieldName: 'Name', isFieldLabelHidden: true },
                { fieldName: 'Phone', fieldLabel: 'Phone number', isFieldLabelHidden: false }, // with custom label
                { fieldName: 'SomeField__c', isFieldLabelHidden: false },
            ]
        }
    }

    // START - lifecycle hooks
    // constructor() {
    //     super();
    //     console.error('RUN constructor()');
    // }

    // connectedCallback() {
    //     console.error('RUN connectedCallback()');
    // }

    // renderedCallback() {
    //     console.error('RUN renderedCallback()');
    // }

    // disconnectedCallback() {
    //     console.error('RUN disconnectedCallback()');
    // }
    // END - lifecycle hooks

    handleSelectedRecord(event) {
        console.log('handleSelectedRecord()', JSON.parse(JSON.stringify(event.detail)));
    }

    handleSelectedRecordRemoved() {
        console.log('handleSelectedRecordRemoved()');
    }
}