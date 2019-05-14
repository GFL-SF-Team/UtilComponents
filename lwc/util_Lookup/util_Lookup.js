import { LightningElement, api, track } from 'lwc';

export default class Util_Lookup extends LightningElement {
    @api isLabelHidden = false;
    @track labelClass = 'slds-form-element__label';

    constructor() {
        super();
        
        this.defineLabelClass();
    }

    defineLabelClass() {        
        this.isLabelHidden = true;
        console.log(this.labelClass);

        if (this.isLabelHidden) {
            console.log(this.labelClass);
            
            this.labelClas = this.labelClas + ' slds-hide';
            console.log(this.labelClass);
        }
    }

    // defineLabelClass() {
    //     let classString = 'slds-form-element__label';
        
    //     this.isLabelHidden = true;

    //     if (this.isLabelHidden) {
    //         classString += ' slds-hide';
    //     }

    //     return classString;
    // }
}