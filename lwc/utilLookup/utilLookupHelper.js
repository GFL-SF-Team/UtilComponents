/* eslint-disable no-console */
/**
 * @author: Dmytro Lambru
 * @description: Helper class for component
 */
import { addElementClass, removeElementClass, handleErrorInResponse, handleErrorInResponseFromApex } from 'c/utils';
import lookup from '@salesforce/apex/Util_LookupController.lookup';

export default new class UtilLookupHelper {

    doLookup(cmp, stringToSearch) {
        this.switchSpinner(cmp, true);

        lookup({
            stringToSearch,
            searchConfigJson: JSON.stringify(cmp.config.searchConfigMap)
        })
            .then((response) => {

                if (response.success) {
                    const data = JSON.parse(response.data);

                    cmp.recordList = data;

                    console.log(data);

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

    setListLengthClass(cmp) {
        const listContainerClass = `slds-dropdown_length-with-icon-${cmp.config.searchConfigMap.numberOfRecords}`;

        addElementClass(cmp, '[data-id="list_container"]', listContainerClass);
    }

    validateListSize(number) {

        if (number !== 5 && number !== 7 && number !== 10) {
            console.error(`The length of the list must be 5 or 7 or 10! The value is set to 10. Your value is ${number}`);
            number = 10;
        }

        return number;
    }

    showList(cmp) {
        addElementClass(cmp, '[data-id="lookup_container"]', 'slds-is-open');
    }

    hideList(cmp) {
        removeElementClass(cmp, '[data-id="lookup_container"]', 'slds-is-open');
    }

    respondToStateChange(cmp) {
        const callback = () => {

            if (!cmp.focusStateMap.isInputFocused && !cmp.focusStateMap.isListFocused) {
                this.hideList(cmp);
            }
        }

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setTimeout(callback);
    }

    clearInputData(cmp) {
        const inputElement = cmp.template.querySelector('[data-id="input"]');

        inputElement.value = '';
        cmp.recordList = [];
        inputElement.focus();
    }

    hideOrShowClearBtn(cmp, isVisible) {

        if (isVisible) {
            removeElementClass(cmp, '[data-id="clear_input_button"]', 'slds-hidden');
        } else {
            addElementClass(cmp, '[data-id="clear_input_button"]', 'slds-hidden');
        }
    }
}