/**
 * @author: Dmytro Lambru
 */
import { LightningElement, api } from 'lwc';
import { addElementClass, removeElementClass } from 'c/utils';
import helper from './util_LookupHelper';

export default class Util_Lookup extends LightningElement {
    @api label = 'Relate to'; // label text
    @api isLabelHidden = false; // to hide label if needed

    connectedCallback() {
        // helper.setClassForLabel(this);
    }

    disconnectedCallback() {}

    handleInputFocus() {
        addElementClass(this, '[data-id="lookup_container"]', 'slds-is-open');
    }

    handleInputBlur() {
        removeElementClass(this, '[data-id="lookup_container"]', 'slds-is-open');
    }

    handleInputChange() {
        console.error('LOL');
        
    }
}