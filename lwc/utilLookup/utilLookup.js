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

        this._config = { ...this.defaultConfig, ...value };
    }

    // private tracked
    @track isLoading = false;

    // private
    _config = {}

    defaultConfig = {
        label: 'Lookup for', // label text
        isLabelHidden: false, // to hide label if needed
        placeholder: "Lookup for ...", // placeholder for input field
        listSize: 5,
    }

    connectedCallback() {
        console.error('RUN connectedCallback()');
        // const listContainerClass = `slds-dropdown_length-with-icon-${this.config.listSize}`;

        // addElementClass(this, '[data-id="list_container"]', listContainerClass);
    }

    renderedCallback() {
        helper.setListSizeClass(this);

        console.error('RUN renderedCallback()');
    }

    disconnectedCallback() { console.error('RUN disconnectedCallback()'); }

    handleInputFocus() {
        addElementClass(this, '[data-id="lookup_container"]', 'slds-is-open');
    }

    handleInputBlur() {
        removeElementClass(this, '[data-id="lookup_container"]', 'slds-is-open');
    }

    handleInputChange(event) {
        const value = event.target.value;

        helper.switchSpinner(this, true);
        helper.doLookup(this);

        console.error(value);
    }

}