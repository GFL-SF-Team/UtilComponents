/**
 * @author: Dmytro Lambru
 * @description: Helper class for component
 */
export default new class Util_LookupHelper {

    openResultList(cmp) {
        const lookupContainer = cmp.template.querySelector('#lookup_container');
        lookupContainer.classList.add('slds-is-open');
    }

    closeResultList(cmp) {
        const lookupContainer = cmp.template.querySelector('#lookup_container');
        lookupContainer.classList.remove('slds-is-open');
    }

    setClassForLabel(cmp) {
        cmp.labelClass = 'slds-form-element__label';
    
        if (cmp.isLabelHidden) {
            cmp.labelClass = cmp.labelClass + ' slds-hide';
        }

    }
}