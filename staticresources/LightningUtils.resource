/*
 * @author: Dmytro Lambru
 * @date: 22.10.2018
 * @description: Class with set of utility methods
 */

/* What is this ? */
let _refresh = true;

/* Utils class variable encapsulation (private variable) */
let _storage;

class Utils {

    constructor() {
        _storage = this.createStorageService();
    }

    get storage() {
        return _storage;
    }

    set storage(value) {
        //override protection
    }

    /*
     * @author: Dmytro Lambru
     * @description: create object with a set of methods for working with encapsulated Map object
     * @return {Object}: object with a set of methods
     */
    createStorageService() {
        //private scope
        const _memory = new Map();

        function _memoryIsHasKey(key) {
            return _memory.get(key);
        }

        return {
            /* if new value is set, returns true */
            set: (key, value) => {
                if (!_memoryIsHasKey(key)) {
                    _memory.set(key, value);
                    return true;
                }

                return false;
            },

            /* if value is overwritten, returns true */
            override: (key, value) => {
                if (_memoryIsHasKey(key)) {
                    _memory.set(key, value);
                    return true;
                }

                return false;
            },

            get: (key) => {
                return _memory.get(key);
            },

            has: (key) => {
                return _memory.has(key);
            },

            size: () => {
                return _memory.size;
            },

            entries: () => {
                return _memory.entries();
            },

            keys: () => {
                return _memory.keys();
            },

            values: () => {
                return _memory.values();
            },

            /* Do not add this method, deletes keys with similar value,
             * e.g. keys 'val' and 'val1' will be deleted at the same time,
             * which may have an effect on other applications on the same page.
             */
            // delete: (key) => {
            //     return _memory.delete(key);
            // },

            /* Do not add this method, as a full cleanup may affect other applications loaded on the same page. */
            // clear: () => {
            //     _memory.clear();
            // },
        }
    }

    /*
     * @author: Dmytro Lambru
     * @description: method to send request to server using Promise object
     * @param {Object}: cmp - component object
     * @param {String}: apexMethodName - server-side method name
     * @param {Object}: apexParams - params for server-side method e.g. {param1: 'some string', param2: ['some', 'array']}
     * @return {Object}: new Promise() and request result on resolve
     */
    sendPromiseRequest(cmp, apexMethodName, apexParams) {

        return new Promise((resolve, reject) => {
            if (!apexMethodName) {
                reject(new Error('No method name supplied'));
            }

            const action = cmp.get('c.' + apexMethodName);

            if ($A.util.isObject(apexParams) && Object.keys(apexParams).length !== 0) {
                action.setParams(apexParams);
            }

            action.setCallback(this, (response) => {
                if (response.getState() === "SUCCESS") {
                    resolve(response.getReturnValue());
                }
                else if (response.getState() === "INCOMPLETE") {
                    reject(new Error('Response status is "INCOMPLETE"'));
                }
                else if (response.getState() === "ERROR") {
                    reject(response.getError());
                }
            });

            $A.enqueueAction(action);
        });
    }

    /*
     * @author: Dmytro Lambru
     * @description: method to send request to server
     * @param {Object}: cmp - component object
     * @param {Object}: scope
     * @param {String}: apexMethodName - APEX method name
     * @param {Object}: apexParams - apex params e.g. {param name: value for param, ...}
     * @param {Function}: successCallBack - function that will be performed on success
     * @param {Function}: errorCallBack - function that will be performed on error
     * @param {String}: actionType - storable / abortable / background
     */
    sendRequest(cmp, helper, apexMethodName, apexParams, successCallBack, errorCallBack, actionType) {
        const action = cmp.get('c.' + apexMethodName);

        if (Object.keys(apexParams).length !== 0) {
            action.setParams(apexParams);
        }

        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                successCallBack(cmp, helper, response.getReturnValue());
            }
            else if (response.getState() === "INCOMPLETE") {
                this.showCriticalErrorToast('INCOMPLETE');
            }
            else if (response.getState() === "ERROR") {
                errorCallBack(cmp, helper, response.getError());
            }
        });

        if (actionType === 'storable') {
            action.setStorable();
        }
        else if (actionType === 'abortable') {
            action.setAbortable();
        }
        else if (actionType === 'background') {
            action.setBackground();
        }

        $A.enqueueAction(action);
    }

    /*
     * @author: Dmytro Lambru
     * @description: switching the element class with aura:id
     * @param {Object}: cmp - component object
     * @param {String}: auraId - aura:id of the element
     * @param {String}: className - name of the class to add or remove
     * @param {Boolean}: isAdd - true = to add | false = to remove
     */
    classSwitch(cmp, auraId, className, isAdd) {
        const element = cmp.find(auraId);

        if ( $A.util.isObject(element) ) {

            if (isAdd === true) {
                $A.util.addClass(element, className);
            }
            else {
                $A.util.removeClass(element, className);
            }
        }
        else {
            console.error(`cmp.find(${auraId}) - failed and find result is 'undefined'`);
        }
    }

    /*
     * @author: Dmytro Lambru
     * @description: check if the element has a class or not
     * @param {Object}: cmp - component object
     * @param {String}: auraId - aura:id of the element
     * @param {String}: className - name of the class to check
     * @return {Boolean}: true = has | false = not
     */
    hasClass(cmp, auraId, className) {
        const element = cmp.find(auraId);

        if ( $A.util.isObject(element) ) {
            return $A.util.hasClass(element, className);
        }
        else {
            console.error(`cmp.find(${auraId}) - failed and find result is 'undefined'`);
        }
    }

    /*
     * @author: Dmytro Lambru
     * @description: toggle the element class with aura:id
     * @param {Object}: cmp - component object
     * @param {String}: auraId - aura:id of the element
     * @param {String}: className - name of the class to toggle
     */
    toggleClass(cmp, auraId, className) {
        const element = cmp.find(auraId);

        if ( $A.util.isObject(element) ) {
            $A.util.toggleClass(element, className);
        }
        else {
            console.error(`cmp.find(${auraId}) - failed and find result is 'undefined'`);
        }
    }

     /* For showing different toasts */
     //type: dismissible, pester, sticky
     showSuccessToast(title, message) {
         let toastEvent = $A.get("e.force:showToast");
         toastEvent.setParams({
             title: title,
             message: message,
             duration: '5000',
             key: 'action_icon_name',
             type: 'success',
             mode: 'dismissible'
         });
         toastEvent.fire();
     }

     showInfoToast(title, message, mode='dismissible') {
         let toastEvent = $A.get("e.force:showToast");
         toastEvent.setParams({
             title: title,
             message: message,
             duration: '5000',
             key: 'action_icon_name',
             type: 'info',
             mode: mode
         });
         toastEvent.fire();
     }

     showErrorToast(title, message) {
         let toastEvent = $A.get("e.force:showToast");
         toastEvent.setParams({
             title: title,
             message: message,
             duration: '5000',
             key: 'action_icon_name',
             type: 'error',
             mode: 'pester'
         });
         toastEvent.fire();
     }

     showWarningToast(title, message) {
         let toastEvent = $A.get("e.force:showToast");
         toastEvent.setParams({
             title: title,
             message: message,
             duration: '5000',
             key: 'action_icon_name',
             type: 'warning',
             mode: 'sticky'
         });
         toastEvent.fire();
     }


    showCriticalErrorToast(code) {
        let toastEvent = $A.get("e.force:showToast");

        let params = {
            title: 'System error!',
            message: 'Please let us know about it',
            duration: '5000',
            key: 'action_icon_name',
            type: 'error',
            mode: 'sticky'
        };

        if (!$A.util.isUndefinedOrNull(code)) {
            params['messageTemplate'] = 'Please let us know about it, error code: {0}';
            params['messageTemplateData'] = [code.toString()];
        }

        toastEvent.setParams(params);
        toastEvent.fire();
    }

    /*
     * @author: Dmytro Lambru
     */
    showExceptionInConsole(exception) {
        if (exception instanceof TypeError) {
            console.error('Exception >>> TypeError', exception);
        } else if (exception instanceof SyntaxError) {
            console.error('Exception >>> SyntaxError', exception);
        } else if (exception instanceof ReferenceError) {
            console.error('Exception >>> ReferenceError', exception);
        } else if (exception instanceof URIError) {
            console.error('Exception >>> URIError', exception);
        } else if (exception instanceof RangeError) {
            console.error('Exception >>> RangeError', exception);
        } else if (exception instanceof EvalError) {
            console.error('Exception >>> EvalError', exception);
        } else {
            console.error('Exception >>>', exception);
        }
    }

    /*
     * @author: Andriy Lokotosh
     * @description: to handle bad response result from server
     * @param {String}: state - response state
     * @param {Object}: response - Aura response object
     * @param {Function}: onErrorFunction - function that is always executed
     */
    handleBadServerResult(state, response, onErrorFunction) {

        if (state === "ERROR") {
            let errors = response.getError();

            if (errors && errors[0] && errors[0].message) {
                this.showErrorToast('Server Result Error', 'Error message: ' + errors[0].message + '. Please contact to your administrator');
            }
            else {
                this.showErrorToast('Server Result Error', 'Unknown error. Please contact to your administrator');
            }

        }
        else if (state === "INCOMPLETE") {
            this.showErrorToast('Connection problem', 'Unknown error. Please check your connection. You might be offline');
        }

        if(onErrorFunction != undefined && onErrorFunction != null){
            onErrorFunction();
        }

    }


    /*
     * @author: Andriy Lokotosh
     * @description: to handle bad response result from Lightning Result
     * @param {String}: result - LightningResult object
     * @param {Function}: onErrorFunction - function that is always executed
     */
    handleLightningResult(result, onErrorFunction) {
        let parsedResult = JSON.parse(result.message);
        if (parsedResult.exceptionType === 'System.AuraHandledException'){
            this.showErrorToast('Error message: ', parsedResult.message);
        } else {
             this.showErrorToast('LightningResult Error',  'Please contact to your administrator');
        }

        console.log('LightningResult message: ' + parsedResult.message + ' ////// ' + result.message);

        if(onErrorFunction != undefined && onErrorFunction != null){
            onErrorFunction();
        }
    }

    /*
     * @author: Dmytro Lambru
     * @description: method to create components dynamically
     * @param {array}: componentConfigList - e.g. [
     *                                                {name: 'lightning:layoutItem', attributes: {size: '12', padding: 'around-medium'}},
     *                                                {name: 'aura:html', attributes: {tag: 'div', HTMLAttributes: {class: 'slds-grid slds-size--1-of-1'}}},
     *                                            ]
     * @return {Object}: new Promise() and created components on resolve
     */
    async createComponents(componentConfigList) {

         try {
             const componentConfigToCreateList = [];

             for (let componentConfig of componentConfigList) {
                 componentConfigToCreateList.push([componentConfig.name, componentConfig.attributes]);
             }

             return await new Promise((resolve, reject) => {
                 $A.createComponents(
                     componentConfigToCreateList,
                     (components, status, error) => {
                         if (status === 'SUCCESS') {
                             resolve(components);
                         }
                         else if (status === 'INCOMPLETE') {
                             this.showCriticalErrorToast();
                             console.error('$Utils.createComponents() - No response from server or client is offline.');
                         }
                         else if (status === 'ERROR') {
                             reject(error)
                         }
                     }
                 );
             });
         }
         catch (error) {
             this.showCriticalErrorToast();

             if ( !$A.util.isEmpty(error) ) {
                 console.log("Error string: " + JSON.stringify(error));
                 console.error('ERROR - LightningUtils.createComponents()', error);
             }
         }
    }

    /*
    * Converts any value to an array if it is not an array.
    * */
    convertToArrayIfNotArray(value) {

        if ($A.util.isUndefinedOrNull(value)) {
            value = [];
        }
        else if (!$A.util.isArray(value)) {
            value = [value];
        }

        return value;
    }

    /*
    * Check two arrays for equality.
    * You can also specify whether to sort before comparing so that they are compared regardless of the location of the elements.
    * Warning! - two different object instances will never be equal: {x:20} != {x:20}
    * */
    isArrayEqual(fistList, secondList, doSort = false) {
        /* false - if not array */
        if (!$A.util.isArray(fistList) || !$A.util.isArray(secondList)) { return false; }

        /* false - if length is different */
        if (fistList.length !== secondList.length) { return false; }

        /* sort arrays before comparison */
        if (doSort) {
            fistList.sort();
            secondList.sort();
        }

        for (let i = 0, length = fistList.length; i < length; i++) {

             /* Check if we have nested arrays */
            if (fistList[i] instanceof Array && secondList[i] instanceof Array) {
                /* recurse into the nested arrays */
                if ( !this.isArrayEqual(fistList[i], secondList[i], doSort) ) { return false; }
            }
            else if (fistList[i] !== secondList[i]) {
                 /* Warning! - two different object instances will never be equal: {x:20} != {x:20} */
                return false;
            }
        }

        return true;
    }

    handleErrorInPromiseCatch(error) {
        this.showCriticalErrorToast();

        if ( !$A.util.isEmpty(error) ) {
            console.log("Error string: " + JSON.stringify(error));
            console.error('ERROR', Object.assign({}, error));
        }
    }

    /* errors from APEX try-catch */
    handleErrorInResponseFromApex(response, isShowToast = true) {
        if (isShowToast) {
            this.showCriticalErrorToast();
        }

        if (!!response && response.hasOwnProperty('code') && !!response.code) {
            console.error('APEX ERROR CODE:', response.code);
        }

        if (!!response && response.hasOwnProperty('message') && !!response.message) {
            console.error('APEX ERROR MSG:', response.message);
        }
    }

    /*
    * @description: break all references to an object and its nested objects
    * */
    cloneAndBreakAllObjectReferences(cloningObject) {
        return JSON.parse(JSON.stringify(cloningObject));
    }
}

window.$Utils = new Utils();