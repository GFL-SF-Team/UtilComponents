/* eslint-disable no-console */
/**
 * @author: Dmytro Lambru
 * @date: 05.2019
 */
import { LightningElement, api, track } from 'lwc';
import helper from './utilLookupHelper';
import { isObject } from 'c/utils';

export default class UtilLookup extends LightningElement {
    // public
    @api
    get config() {
        return this._configMap;
    }
    set config(configMap) {
        if (!isObject(configMap)) return;

        this._configMap = { ...this.defaultConfigMap, ...this._configMap, ...configMap };
        console.log('this._configMap', this._configMap);

        this._configMap.listSize = helper.validateListSize(this._configMap.listSize);

        // copy a number of records for the query limit to the search config
        this._configMap.searchConfigMap.numberOfRecords = this._configMap.listSize;
    }

    // private tracked
    @track isLoading = false;
    @track recordList = [];

    // private
    _configMap = {};
    focusStateMap = {
        isInputFocused: false,
        isListFocused: false
    };

    defaultConfigMap = {
        label: 'Lookup for', // label text
        isLabelHidden: false, // to hide label if needed
        placeholder: 'Lookup for ...', // placeholder for input field
        listSize: 5, // max number of list items (5 or 7 or 10 only)

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
                { fieldName: 'Name', isFieldLabelHidden: true },
                { fieldLabel: 'Phone number', fieldName: 'Phone', isFieldLabelHidden: false }, // with custom label
                { fieldName: 'Name', isFieldLabelHidden: false },
            ]
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

    handleInputChange(event) {
        const stringToSearch = event.target.value.trim();

        if (!stringToSearch) {
            this.recordList = [];
            helper.hideClearBtn(this);
            return;
        }

        helper.showClearBtn(this);
        helper.doLookup(this, stringToSearch);
    }

    handleClearInput() {
        helper.clearInputAndRecords(this);
        helper.changeFocusOnInput(this);
    }

    handleInputFocus() {
        this.focusStateMap.isInputFocused = true;
        // console.log('handleInputFocus()');
        helper.showList(this);
    }

    handleInputBlur() {
        this.focusStateMap.isInputFocused = false;
        helper.respondToStateChange(this);
        // console.log('handleInputBlur()');
    }

    handleListFocus() {
        this.focusStateMap.isListFocused = true;
        // console.log('handleListFocus()');

    }

    handleListBlur() {
        this.focusStateMap.isListFocused = false;
        helper.respondToStateChange(this);
        // console.log('handleListBlur()');

    }

    handleListItemClick(event) {
        console.log('handleListItemClick()');
        console.log('li event', event);
        console.log('li ID', event.currentTarget.dataset.recordId);

        const recordId = event.currentTarget.dataset.recordId;

        helper.fireEventWithSelectedRecord(this, recordId);

        helper.clearInputAndRecords(this);
        this.handleListBlur();
    }
}