/**
 * @author: Dmytro Lambru
 * @description: Helper class for component
 */
export default new class Util_LookupHelper {

    setClassForLabel(cmp) {
        cmp.labelClass = 'slds-form-element__label';
    
        if (cmp.isLabelHidden) {
            cmp.labelClass = cmp.labelClass + ' slds-hide';
        }

    }
}