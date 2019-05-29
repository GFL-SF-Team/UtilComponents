/**
 * @author: Dmytro Lambru
 * @date: 05.2019
 */
import { LightningElement, api, wire } from 'lwc';
import helper from './utilLookupHelper';
import { addElementClass, removeElementClass, handleErrorInResponse, handleErrorInResponseFromApex } from 'c/utils';
import lookup from '@salesforce/apex/Util_LookupController.lookup';

export default class UtilLookup extends LightningElement {
    // public
    @api label = 'Lookup for'; // label text
    @api isLabelHidden = false; // to hide label if needed
    // @api componentWidth = 100;

    // private

    connectedCallback() {
        // helper.setComponentStyle(this);
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

        this.doLookup();
        // this.wiredLookup();
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

    doLookup() {
        lookup()
            .then(response => {

                if (response.success) {
                    const data = response.data;

                } else {
                    handleErrorInResponseFromApex(this, response);
                }
            })
            .catch(error => {
                handleErrorInResponse(this, error);
            });
    }

    // @wire(lookup, { stringToSearch: 'LOL' })
    // wiredLookup({ error, data }) {
    //     console.error('2131');

    //     if (data) {
    //         console.error(data);

    //     } else if (error) {
    //         handleErrorInResponse(this, error);
    //     }
    // }

}