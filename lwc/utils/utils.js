/* eslint-disable no-console */
// !!! - This file should contain only universal functions that can be used everywhere.
// !!! - Do not add a function that will be used only in your application.
// !!! - Add a full comment block

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import * as $Validation from './validationUtils';

// redirect all
export * from './validationUtils';

/**
 * @author Dmytro Lambru
 * @description Add class to element
 * @param {object} cmp component(this) class object
 * @param {string} identifier identifier fot the element
 * @param {string} className name of the class to add
 */
export function addElementClass(cmp, identifier, className) {
    const element = cmp.template.querySelector(identifier);

    if ($Validation.isObject(element)) {
        element.classList.add(className);
    } else {
        throw Error(`Could not find element with identifier:'${identifier}' and find result is 'undefined'`);
    }
}

/**
 * @author Dmytro Lambru
 * @description Remove class from element with ID
 * @param {object} cmp component(this) class object
 * @param {string} identifier identifier for the element
 * @param {string} className name of the class to remove
 */
export function removeElementClass(cmp, identifier, className) {
    const element = cmp.template.querySelector(identifier);

    if ($Validation.isObject(element)) {
        element.classList.remove(className);
    } else {
        throw Error(`Could not find element with identifier: '${identifier}' and find result is 'undefined'`);
    }
}

/**
 * @author Dmytro Lambru
 * @description Reduces one or more LDS errors into a string[] of error messages
 * @param {*} errors
 * @return {string[]} Error messages
 */
export function reduceErrors(errors) {
    errors = convertToArrayIfNotArray(errors);

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


/**
 * @author Lambru Dmytro
 * @description Convert value to an array if it is not an array
 * @param {*} value
 * @returns {array} value as array
 */
export function convertToArrayIfNotArray(value) {

    if ($Validation.isUndefinedOrNull(value)) {
        value = [];
    } else if (!Array.isArray(value)) {
        value = [value];
    }

    return value;
}

/**
 * @author Lambru Dmytro
 * @description Show error(s) info from response
 * @param {object} cmp component(this) object
 * @param {*} error
 * @param {boolean} [isShowToast=true]
 */
export function handleErrorInResponse(cmp, error, isShowToast = true) {

    if (isShowToast) showCriticalErrorToast(cmp);

    const errorList = reduceErrors(error);
    console.error(errorList);
}

/**
 * @author Lambru Dmytro
 * @description Show error(s) info from Apex
 * @param {object} cmp component(this) object
 * @param {object} response LightningResult class object
 * @param {boolean} [isShowToast=true]
 */
export function handleErrorInResponseFromApex(cmp, response, isShowToast = true) {

    if (isShowToast) showCriticalErrorToast(cmp, response.code);

    if (!!response && response.hasOwnProperty('code') && !!response.code) {
        console.error('APEX ERROR CODE:', response.code);
    }

    if (!!response && response.hasOwnProperty('message') && !!response.message) {
        console.error('APEX ERROR MSG:', response.message);
    }
}


/**
 * @author Lambru Dmytro
 * @description Toast notification that pops up to alert users of a success, info, error, or warning.
 * @param {object} cmp component(this) object
 * @param {string} title title of toast
 * @param {string} message toast message
 * @param {string} [variant='success'] (info/success/warning/error)
 * @param {string} [mode='dismissable'] (dismissable/pester/sticky)
 */
export function showToast(cmp, title, message, variant = 'success', mode = 'dismissable') {
    const newEvent = new ShowToastEvent({
        title,
        message,
        variant,
        mode
    });

    cmp.dispatchEvent(newEvent);
}

/**
 * @author Lambru Dmytro
 * @description Toast notification with critical system error
 * @param {object} cmp component(this) object
 * @param {string|number} code error code
 */
export function showCriticalErrorToast(cmp, code) {
    const title = 'System error!';
    let message = 'Please let us know about it';
    const variant = 'error';
    const mode = 'sticky';

    if (!$Validation.isUndefinedOrNull(code)) {
        message = `Please let us know about it, error code: ${code}`;
    }

    showToast(cmp, title, message, variant, mode);
}