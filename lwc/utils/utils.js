
// /*
// * @author: Dmytro Lambru
// * @description: Is a given variable an object?
// * @param {Object} obj: object to check
// * @return {Boolean}
// */
// const isObject = (obj) => {
//     const type = typeof obj;
//     return type === 'function' || type === 'object' && !!obj;
// }

// /*
// * @author: Dmytro Lambru
// * @description: Add class to element with ID
// * @param {Object} cmp: component class object
// * @param {String} elementId: id of the element
// * @param {String} className: name of the class to add
// */
// const addClassById = (cmp, elementId, className) => {
//     const element = cmp.template.querySelector(elementId);
    
//     if (isObject(element)) {
//         element.classList.add(className);
//     }
//     else {
//         console.error(`Could not find element with ID:'${elementId}' and find result is 'undefined'`);
//     }
// }

/*
* @author: Dmytro Lambru
* @description: Remove class from element with ID
* @param {Object} cmp: component class object
* @param {String} elementId: id of the element
* @param {String} className: name of the class to remove
*/
const removeClassById = (cmp, elementId, className) => {
    const element = cmp.template.querySelector(elementId);
    
    if (isObject(element)) {
        element.classList.add(className);
    }
    else {
        console.error(`Could not find element with ID:'${elementId}' and find result is 'undefined'`);
    }
}

export {
    removeClassById
};