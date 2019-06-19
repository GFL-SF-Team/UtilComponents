/* eslint-disable no-console */
/**
 * @author: Dmytro Lambru
 * @description: Helper class for component
 */
import { addElementClass, handleErrorInResponse, handleErrorInResponseFromApex } from 'c/utils';
import lookup from '@salesforce/apex/Util_LookupController.lookup';

export default new class UtilLookupHelper {

    doLookup(cmp) {

        lookup()
            .then((response) => {

                if (response.success) {
                    const data = response.data;
                    console.error(data);

                } else {
                    handleErrorInResponseFromApex(cmp, response);
                }

                this.switchSpinner(cmp, false);
            })
            .catch((error) => {
                this.switchSpinner(cmp, false);
                handleErrorInResponse(cmp, error);
            })
    }

    switchSpinner(cmp, isLoading) {
        cmp.isLoading = isLoading;
    }

    setListSizeClass(cmp) {
        const listContainerClass = `slds-dropdown_length-with-icon-${cmp.config.listSize}`;

        addElementClass(cmp, '[data-id="list_container"]', listContainerClass);
    }

    // setComponentStyle(cmp) {
    //     cmp.classList.add(`my_width_${cmp.componentWidth}`);
    // }
}