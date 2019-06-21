/* eslint-disable no-console */
/**
 * @author: Dmytro Lambru
 * @date: 05.2019
 */
import { LightningElement, api, track } from 'lwc';
import helper from './utilLookupHelper';
import { addElementClass, removeElementClass, isObject } from 'c/utils';

export default class UtilLookup extends LightningElement {
    // public
    @api
    get config() {
        return this._config;
    }

    set config(value) {
        if (!isObject(value)) return;

        this._config = { ...this.defaultConfig, ...this._config, ...value };
    }

    // private tracked
    @track isLoading = false;

    // private
    _config = {}

    defaultConfig = {
        label: 'Lookup for', // label text
        isLabelHidden: false, // to hide label if needed
        placeholder: 'Lookup for ...', // placeholder for input field
        listSize: 5, // max number of list items

        icon: { // icon config
            name: 'standard:account', // SLDS icon
            size: 'small',
            alternativeText: 'Account'
        },

        searchConfigMap: { // config for search
            objectName: 'Account',
            fieldForQueryList: ['Name', 'Phone', 'Type', 'Site'],
            fieldForSearchList: ['Name', 'Site'], // fields for search through 'Name LIKE %text for search% OR Site ...'
            fieldForOrderList: ['Name'], // optional - fields for 'ORDER BY Name, Site'
            // fieldForFilterCriterionList: [ // optional - fields for filtering 'NumberOfEmployees = 8 AND ...'
            //     { fieldName: 'NumberOfEmployees', condition: '=', value: '8', typeOfValue: 'Integer' },
            //     { fieldName: 'Type', condition: '=', value: 'Customer - Direct', typeOfValue: 'String' },
            // ],
            fieldToShowList: [ // fields to display in the result list
                { fieldName: 'Name', isFieldLabelHidden: false },
                { fieldLabel: 'Phone number', fieldName: 'Phone', isFieldLabelHidden: false }, // with custom label
                { fieldName: 'Name', isFieldLabelHidden: false },
            ],

            recordList: [
                {
                    recordId: 'someId',
                    record: {},
                    fieldToShowList: [{
                        fieldName: 'Name__c',
                        fieldLabel: 'Name',
                        value: 'Bla bla'
                    }],
                }
            ],
        }
    }

    // START - lifecycle hooks
    constructor() {
        super();
        console.error('RUN constructor()');
    }

    connectedCallback() { console.error('RUN connectedCallback()'); }

    renderedCallback() {
        console.error('RUN renderedCallback()');

        helper.setListLengthClass(this);
    }

    disconnectedCallback() { console.error('RUN disconnectedCallback()'); }
    // END - lifecycle hooks

    handleInputFocus() {
        addElementClass(this, '[data-id="lookup_container"]', 'slds-is-open');
    }

    handleInputBlur() {
        removeElementClass(this, '[data-id="lookup_container"]', 'slds-is-open');
    }

    handleInputChange(event) {
        let stringToSearch = event.target.value;
        console.error('stringToSearch', stringToSearch);

        if (!stringToSearch) {
            //TODO: reset result list
            return;
        }

        helper.doLookup(this, stringToSearch);
    }

}