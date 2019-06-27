/* eslint-disable no-console */
// !!! - This file should contain only universal functions that can be used everywhere.
// !!! - Do not add a function that will be used only in your application.
// !!! - Add a full comment block

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { DEBUG_MODE } from './constants';
import * as $Validation from './validationUtils';

// redirect all
export * from './validationUtils';
export * from './pubsub';

export function showConsoleError(arg1, arg2) {

    if (!DEBUG_MODE) return;

    if (arg2) {
        console.error(arg1, arg2)
    } else {
        console.error(arg1)
    }
}

/**
 * @author Dmytro Lambru
 * @description Dispatch 'CustomEvent'
 * @param {object} cmp component(this) class object
 * @param {string} eventName - name for the event
 * @param {any} data - (optional) Data to transfer. Defaults to undefined
 * @param {boolean} isBubblePhase - (optional) A Boolean value indicating whether the event bubbles up through the DOM or not. Defaults to false
 * @param {boolean} isComposed - (optional) A Boolean value indicating whether the event can pass through the shadow boundary. Defaults to false
 */
export function fireCustomEvent(cmp, eventName, data = undefined, isBubblePhase = false, isComposed = false) {

    if (!$Validation.isInheritedFromLightningElement(cmp)) return;

    const eventToFire = new CustomEvent(eventName, {
        detail: data,
        bubbles: isBubblePhase,
        composed: isComposed
    });

    cmp.dispatchEvent(eventToFire);
}

/**
 * @author Dmytro Lambru
 * @description Add class to element
 * @param {object} cmp component(this) class object
 * @param {string} identifier identifier fot the element
 * @param {string} className name of the class to add
 */
export function addElementClass(cmp, identifier, className) {

    if (!$Validation.isInheritedFromLightningElement(cmp)) return;

    const element = cmp.template.querySelector(identifier);

    if ($Validation.isObject(element)) {
        element.classList.add(className);
    } else {
        showConsoleError(`Could not find element with identifier:'${identifier}' and find result is '${'' + element}'`);
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

    if (!$Validation.isInheritedFromLightningElement(cmp)) return;

    const element = cmp.template.querySelector(identifier);

    if ($Validation.isObject(element)) {
        element.classList.remove(className);
    } else {
        showConsoleError(`Could not find element with identifier: '${identifier}' and find result is '${'' + element}'`);
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

    if (!$Validation.isInheritedFromLightningElement(cmp)) return;

    if (isShowToast) {
        showCriticalErrorToast(cmp);
    }

    const errorList = reduceErrors(error);

    showConsoleError('ERRORS:', errorList);
}

/**
 * @author Lambru Dmytro
 * @description Show error(s) info from Apex
 * @param {object} cmp component(this) object
 * @param {object} response LightningResult class object
 * @param {boolean} [isShowToast=true]
 */
export function handleErrorInResponseFromApex(cmp, response, isShowToast = true) {

    if (!$Validation.isInheritedFromLightningElement(cmp)) return;
    if (isShowToast) showCriticalErrorToast(cmp, response.code);

    if (!!response && response.hasOwnProperty('code') && !!response.code) {
        showConsoleError('APEX ERROR CODE:', response.code);
    }

    if (!!response && response.hasOwnProperty('message') && !!response.message) {
        showConsoleError('APEX ERROR MSG:', response.message);
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

    if (!$Validation.isInheritedFromLightningElement(cmp)) return;

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

    if (!$Validation.isInheritedFromLightningElement(cmp)) return;

    const title = 'System error!';
    let message = 'Please let us know about it';
    const variant = 'error';
    const mode = 'sticky';

    if (!$Validation.isUndefinedOrNull(code)) {
        message = `Please let us know about it, error code: ${code}`;
    }

    showToast(cmp, title, message, variant, mode);
}

/**
 * @author Lambru Dmytro
 * @description clone and break all references to an object and its nested objects, although uncover 'Proxy' object.
 * @param {any} value - value to convert
 * @returns {any} - converted value
 */
export function jsonConverter(value) {
    return JSON.parse(JSON.stringify(value));
}