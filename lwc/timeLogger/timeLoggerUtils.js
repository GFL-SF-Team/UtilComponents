import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { DEBUG_MODE } from './timeLoggerConstants';

export default new class TimeLoggerUtils {

    handleErrorInResponse(cmp, error, isShowToast = true) {

        if (isShowToast) {
            this.showCriticalErrorToast(cmp);
        }

        const errorList = this.reduceErrors(error);

        this.showConsoleError('ERRORS:', errorList);
    }

    handleErrorInResponseFromApex(cmp, response, isShowToast = true) {

        if (isShowToast) this.showCriticalErrorToast(cmp, response.code);

        if (!!response && response.hasOwnProperty('code') && !!response.code) {
            this.showConsoleError('APEX ERROR CODE:', response.code);
        }

        if (!!response && response.hasOwnProperty('message') && !!response.message) {
            this.showConsoleError('APEX ERROR MSG:', response.message);
        }
    }

    showToast(cmp, title, message = "", variant = 'success', mode = 'dismissable') {

        const newEvent = new ShowToastEvent({
            title,
            message,
            variant,
            mode
        });

        cmp.dispatchEvent(newEvent);
    }

    showCriticalErrorToast(cmp, code) {
        const title = 'System error!';
        let message = 'Please let us know about it';
        const variant = 'error';
        const mode = 'sticky';

        if (code) {
            message = `Please let us know about it, error code: ${code}`;
        }

        this.showToast(cmp, title, message, variant, mode);
    }

    showConsoleError(arg1, arg2) {

        if (!DEBUG_MODE) return;

        if (arg2) {
            // eslint-disable-next-line no-console
            console.error(arg1, arg2)
        } else {
            // eslint-disable-next-line no-console
            console.error(arg1)
        }
    }

    reduceErrors(errors) {
        errors = this.convertToArrayIfNotArray(errors);

        return (
            errors
                // Remove null/undefined items
                .filter(error => !!error)
                // Extract an error message
                .map(error => {
                    // UI API read errors
                    if (Array.isArray(error.body)) {
                        return error.body.map(e => e.message);
                    }
                    // UI API DML, Apex and network errors
                    else if (error.body && typeof error.body.message === 'string') {
                        return error.body.message;
                    }
                    // JS errors
                    else if (typeof error.message === 'string') {
                        return error.message;
                    }
                    // Unknown error shape so try HTTP status text
                    return error.statusText;
                })
                // Flatten
                .reduce((prev, curr) => prev.concat(curr), [])
                // Remove empty strings
                .filter(message => !!message)
        );
    }

    convertToArrayIfNotArray(value) {

        if (!value) {
            value = [];
        } else if (!Array.isArray(value)) {
            value = [value];
        }

        return value;
    }
}