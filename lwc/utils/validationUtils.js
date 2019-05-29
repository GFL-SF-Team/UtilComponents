// !!! - This file must contain validation functions that return a boolean value - TRUE or FALSE

/**
 * @author Dmytro Lambru
 * @description Is the value type an object?
 * @param {*} value value to check
 * @return {Boolean} true or false
 */
export function isObject(value) {
    return !!value && typeof value === 'object';
}

/**
 * @author Dmytro Lambru
 * @description Is the value type null?
 * @param {*} value value to check
 * @return {Boolean} true or false
 */
export function isNull(value) {
    return value === null;
}

/**
 * @author Dmytro Lambru
 * @description Is the value type undefined?
 * @param {*} value value to check
 * @return {Boolean} true or false
 */
export function isUndefined(value) {
    return value === undefined;
}

/**
 * @author Dmytro Lambru
 * @description Is the value type undefined or null?
 * @param {*} value value to check
 * @return {Boolean} true or false
 */
export function isUndefinedOrNull(value) {
    return isUndefined(value) || isNull(value);
}