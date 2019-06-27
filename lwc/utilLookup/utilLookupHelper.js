/* eslint-disable no-console */
/**
 * @author: Dmytro Lambru
 * @description: Helper class for component
 */
import { fireCustomEvent, addElementClass, removeElementClass, handleErrorInResponse, handleErrorInResponseFromApex } from 'c/utils';
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

    validateListSize(number) {

        if (number !== 5 && number !== 7 && number !== 10) {
            console.error(`The length of the list must be 5 or 7 or 10! The value is set to 10. Your value is ${number}`);
            number = 5;
        }

        return number;
    }

    respondToStateChange(cmp) {
        const callback = () => {

            if (!cmp.focusStateMap.isInputFocused && !cmp.focusStateMap.isListFocused) {
                cmp.isListOpen = false;
            }
        }

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setTimeout(callback);
    }

    clearInputAndRecords(cmp) {
        const inputElement = cmp.template.querySelector('[data-id="input"]');
        inputElement.value = '';

        cmp.recordList = [];

        this.hideClearBtn(cmp);
    }

    changeFocusOnInput(cmp) {
        const inputElement = cmp.template.querySelector('[data-id="input"]');
        inputElement.focus();
    }

    showClearBtn(cmp) {
        removeElementClass(cmp, '[data-id="clear_input_button"]', 'slds-hidden');
    }

    hideClearBtn(cmp) {
        addElementClass(cmp, '[data-id="clear_input_button"]', 'slds-hidden');
    }

    fireEventWithSelectedRecord(cmp, selectedRecord) {
        fireCustomEvent(cmp, 'select', { record: selectedRecord.record });
    }

    setValueForInputWithSelectedRecord(cmp, selectedRecord) {
        const inputElement = cmp.template.querySelector('[data-id="input_with_record"]');

        //TODO: set new value for input
    }
}