/**
 * @author: Dmytro Lambru
 */
import { LightningElement, api, track } from 'lwc';
import { addElementClass, removeElementClass } from 'c/utils';
import helper from './utilLookupHelper';

export default class UtilLookup extends LightningElement {
    // public
    @api label = 'Lookup for'; // label text
    @api isLabelHidden = false; // to hide label if needed
    @api componentWidth = 100;

    // private

    connectedCallback() {
        helper.setComponentStyle(this);
    }

    renderedCallback() {
        // helper.setComponentStyle(this);
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
        // this.isInputLoading = true;
        // event.target.isLoading = true;
        // event.target.isLoading = false;

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        // setTimeout(() => {
        //     console.error(this.isInputLoading);
        //     this.isInputLoading = false;
        // }, 1000, this);

        console.error(value);
    }
}