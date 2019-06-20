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
            isFieldLabelHidden: false, // to hide label for the fields
            fieldForSearchList: ['Name', 'Site'],
            fieldForQueryList: ['Name', 'Phone', 'Type'],
            fieldToShowList: [
                { fieldName: 'Name' },
                { fieldLabel: 'Phone number', fieldName: 'Phone' }, // with custom label
                { fieldName: 'Name' },
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
        const stringToSearch = event.target.value;

        helper.switchSpinner(this, true);
        helper.doLookup(this, stringToSearch);

        console.error(stringToSearch);
    }

}