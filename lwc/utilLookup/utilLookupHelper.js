/**
 * @author: Dmytro Lambru
 * @description: Helper class for component
 */
import { fireCustomEvent, addElementClass, removeElementClass, handleErrorInResponse, handleErrorInResponseFromApex } from 'c/utils';
import lookup from '@salesforce/apex/Util_LookupController.lookup';

export default new class UtilLookupHelper {

    /**
     * @description send a request to the organization to search for records
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     * @param {string} stringToSearch - user input value
     */
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

    /**
     * @description switch visibility of the spinner element
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     * @param {boolean} isLoading
     */
    switchSpinner(cmp, isLoading) {
        cmp.isLoading = isLoading;
    }

    /**
     * @description validate number for list size
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {number} number - number to validate
     * @returns {number} - valid number
     */
    validateListSize(number) {

        if (number !== 5 && number !== 7 && number !== 10) {
            // eslint-disable-next-line no-console
            console.error(`The length of the list must be 5 or 7 or 10! The value is set to 10. Your value is ${number}`);
            number = 5;
        }

        return number;
    }

    /**
     * @description determine the state of the component view
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    respondToStateChange(cmp) {
        const callbackFunction = () => {

            if (!cmp.focusStateMap.isInputFocused && !cmp.focusStateMap.isListFocused) {
                this.hideList(cmp);
            }
        }

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setTimeout(callbackFunction);
    }

    /**
     * @description open list with search result
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    openList(cmp) {
        cmp.isListOpen = true;
    }

    /**
     * @description hide list with search result
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    hideList(cmp) {
        cmp.isListOpen = false;
    }

    /**
     * @description return the component to its initial state
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    clearInputAndRecords(cmp) {
        const inputElement = cmp.template.querySelector('[data-id="input"]');
        inputElement.value = '';

        cmp.recordList = [];
        this.hideClearBtn(cmp);
    }

    /**
     * @description forced focus on the input field
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    changeFocusOnInput(cmp) {
        const inputElement = cmp.template.querySelector('[data-id="input"]');
        inputElement.focus();
    }

    /**
     * @description show 'clear' button in the input field
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    showClearBtn(cmp) {
        removeElementClass(cmp, '[data-id="clear_input_button"]', 'slds-hidden');
    }

    /**
     * @description hide 'clear' button in the input field
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    hideClearBtn(cmp) {
        addElementClass(cmp, '[data-id="clear_input_button"]', 'slds-hidden');
    }

    /**
     * @description show input field with selected record
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    showInputWithSelectedRecord(cmp) {

        if (cmp.config.isHiddenInputWithSelectedRecord) return;

        cmp.isShowInputWithSelectedRecord = true;
    }

    /**
     * @description hide input field with selected record
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    hideInputWithSelectedRecord(cmp) {
        cmp.isShowInputWithSelectedRecord = false;
    }

    /**
     * @description save selected record info 
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     * @param {string} recordId - record org ID
     */
    setSelectedRecordInfo(cmp, recordId) {
        cmp.selectedRecordInfo = cmp.recordList.find(recordInfo => recordInfo.recordId === recordId);
    }

    /**
     * @description send event on select record with selected record
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    fireEventWithSelectedRecord(cmp) {
        fireCustomEvent(cmp, 'select', { record: cmp.selectedRecordInfo.record });
    }

    /**
     * @description send event on remove selected record
     * @author Dmytro Lambru
     * @date 2019-07-02
     * @param {object} cmp - component object
     */
    fireEventSelectedRecordRemoved(cmp) {
        fireCustomEvent(cmp, 'remove');
    }
}