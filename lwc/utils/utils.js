/*
* @author: Dmytro Lambru
* @description: Is a given variable an object?
* @param {Object} obj: object to check
* @return {Boolean}
*/
export function isObject(obj) {
    return !!obj && typeof obj === 'object';
}

/*
* @author: Dmytro Lambru
* @description: Add class to element
* @param {Object} cmp: component class object
* @param {String} identifier: identifier fot the element
* @param {String} className: name of the class to add
*/
export function addElementClass(cmp, identifier, className) {
    const element = cmp.template.querySelector(identifier);
    
    if (isObject(element)) {
        element.classList.add(className);
    }
    else {
        throw Error(`Could not find element with identifier:'${identifier}' and find result is 'undefined'`);
    }
}

/*
* @author: Dmytro Lambru
* @description: Remove class from element with ID
* @param {Object} cmp: component class object
* @param {String} identifier: identifier for the element
* @param {String} className: name of the class to remove
*/
export function removeElementClass(cmp, identifier, className) {
    const element = cmp.template.querySelector(identifier);
    
    if (isObject(element)) {
        element.classList.remove(className);
    }
    else {
        throw Error(`Could not find element with identifier:'${identifier}' and find result is 'undefined'`);
    }
}