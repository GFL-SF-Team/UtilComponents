/**
 * @Author: Aleksandr Shcherbanyuk
 * @Created Date: 11/13/2018
 * @History: modified by Aleksandr Sherbanyuk INT-531 09/07/19
 */
({
    setStepsParams: function (component, helper, steps) {
        component.set('v.stepsWithParams', []);
        let modifiedSteps = [];
        if (Array.isArray(steps)) {
            steps.forEach((item) => {
                let modifyStep = item;
                modifyStep.classes = helper.getClassesStringForSteps(item.isActive, item.isComplete);
                modifyStep.selected = helper.getSelectedValue(item.isActive);
                modifiedSteps.push(modifyStep);
            });
        }
        component.set('v.stepsWithParams', modifiedSteps);
    },

    setCurrentStep : function (component, helper, currentStep) {
        let steps = component.get('v.steps'); 
        let currentCount;
        for (let i=0; i < steps.length; i++) {
            if (steps[i].pathValue === currentStep){
                if (!steps[i].isActive){
                    currentCount = i;
                }
                break;
            }
        }
        if (!$A.util.isUndefinedOrNull(currentCount)) {
            helper.recalculateStepsProporties(component, steps, currentCount);
        }
    },

    recalculateStepsProporties : function(component, steps, currentCount) {
        steps.forEach((item, i) => {
            if (i === currentCount) {
                item.isActive = true;
                item.isComplete = false;
            } else if (i < currentCount) {
                item.isActive = false;
                item.isComplete = true;
            } else {
                item.isActive = false;
                item.isComplete = false;
            }
        });
        component.set('v.steps', steps);
    },

    goToNextStep : function(component) {
        let steps = component.get('v.steps');
        let indexOfNextStep;
        for (let i=0; i < steps.length; i++) {
            if (steps[i].isActive) {
                indexOfNextStep = i + 1;
                break;
            }
        }

        this.checkBarrier(component, indexOfNextStep);
        
        if (!$A.util.isUndefinedOrNull(indexOfNextStep)) {
            if (indexOfNextStep < steps.length) {
                component.set('v.currentStep', steps[indexOfNextStep].pathValue);
            } else {
                steps[indexOfNextStep-1].isActive = false;
                steps[indexOfNextStep-1].isComplete = true;
                component.set('v.steps', steps);
                component.set('v.showButton', false);
            }
        }

    },
    
    getClassesStringForSteps : function (isActive, isComplete) {
        let resultString = 'slds-path__item';
        let addString = '';
        if (isActive && !isComplete) {
            addString += ' slds-is-current slds-is-active';
        } else if (!isActive && isComplete) {
            addString += ' slds-is-complete';
        } else {
            addString += ' slds-is-incomplete';
        }
        return resultString + addString;
    },

    getSelectedValue : function (isActive) {
        let result = false;
        if (isActive) {
            result = true;
        }
        return result;
    },

    setButtonName : function (component, params) {
        if (params) {
            if (params.hasOwnProperty('buttonNameParam') && params.buttonNameParam !== '') {
                component.set('v.buttonName', params.buttonNameParam);
            }
        }
    },

    setValueForOnblurOnFocus : function(component) {
        let isFocus = !component.get('v.isFocus');
        component.set('v.isFocus', isFocus);
        component.set('v.isFocusButton', {'button' : isFocus});
    },

    showHideComponent : function (foundCmp) {
        $A.util.toggleClass(foundCmp, 'slds-hide');
    },

    checkBarrier : function(component, stepIndex){

          // debugger;
          if(stepIndex >= component.get('v.pathBorder')){

              component.set('v.isLeftLocked', true);
          }
    },

    goToPreviousStep : function (component, helper) {
        let steps = component.get('v.steps');
        let indexOfPreviousStep;

        for (let i=0; i < steps.length; i++) {

            if (steps[i].isActive) {
                indexOfPreviousStep = i - 1;
                break;
            }
        }

        if (steps[indexOfPreviousStep]) {
            component.set('v.currentStep', steps[indexOfPreviousStep].pathValue);
        }

        return (indexOfPreviousStep === 0);
    },

    showHideButton : function (component) {
        component.set('v.showButton', !component.get('v.showButton'));
    }
})