/* eslint-disable no-console */
/**
 * @author: Dmytro Lambru
 * @date: 05.2019
 */
import { LightningElement, api, track } from 'lwc';
import { addElementClass, removeElementClass } from 'c/utils';
import helper from './utilLookupHelper';

export default class UtilLookup extends LightningElement {
    // public
    @api
    get config() {
        return this._config;
    }
    set config(value) {
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
    }

    connectedCallback() {
        console.error('RUN connectedCallback()');
    }

    renderedCallback() {
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