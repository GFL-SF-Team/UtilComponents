/**
 * @author: Dmytro Lambru
 */
import { LightningElement, api } from 'lwc';
import {addClassById, removeClassById} from 'c/Utils';
import helper from './util_LookupHelper';

export default class Util_Lookup extends LightningElement {
    @api label = 'Relate to'; // label text
    @api isLabelHidden = false; // to hide label if needed

    connectedCallback() {        
        // helper.setClassForLabel(this);
    }

    disconnectedCallback() {}

    handleInputFocus() {
        addClassById(this, '#lookup_container', 'slds-is-open');
    }

    handleInputBlur() {
        removeClassById(this, '#lookup_container', 'slds-is-open');
    }

    handleInputChange() {
        console.error('LOL');
        
    }
}