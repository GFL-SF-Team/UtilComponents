/**
 * @Author: Aleksandr Shcherbanyuk
 * @Created Date: 11/13/2018
 * @History: modified by Aleksandr Sherbanyuk INT-531 09/07/19
 */
({
    handlerCurrentStep: function (component, event, helper) {
        helper.setCurrentStep(component, helper, component.get('v.currentStep'));
    },

    handlerSteps: function (component, event, helper) {
        helper.setStepsParams(component, helper, component.get('v.steps'));
    },

    onStepSelect: function (component, event, helper) {

        var element = event.currentTarget;
        var pathValue = element.getAttribute('name');
        var stepIndex = element.getAttribute('data-index');
        if(component.get('v.isHandleStepSelect')){
//            debugger;
            if(stepIndex < component.get('v.pathBorder') && !component.get('v.isLeftLocked')){
//                   debugger;
                   let pathData = component.get('v.stepsWithParams');
                   pathData.forEach(function(step){
                       step.isActive = false;
                   });

                   pathData[stepIndex].isActive = true;
                   component.set('v.currentStep', pathValue);
            }
        }

        let border = component.get('v.pathBorder');
        if(stepIndex > border){
            debugger;
            component.set('v.isLeftLocked', true);
        }
    },

    handlerButton: function (component, event, helper) {
        helper.goToNextStep(component);
    },
    
    moveToNextStep : function (component, event, helper) {
        helper.goToNextStep(component);
    },
    
    getCurrentStep : function (component, event, helper) {
		return component.get('v.currentStep');
    },

    buttonDefinition : function (component, event, helper) {
        helper.setButtonName(component, event.getParam('arguments'));
    },

    setSpinnerAction : function (component, event, helper) {
        helper.showHideComponent(component.find('custSpinner'));
    },

    handleIsFocus : function (component, event, helper) {
        helper.setValueForOnblurOnFocus(component);
    },

    getButtonName : function (component, event, helper) {
        return component.get('v.buttonName');
    },

    showHideButton : function (component, event, helper) {
        helper.showHideButton(component);
    },

    moveToPreviousStep : function (component, event, helper) {
        return helper.goToPreviousStep(component, helper);
    }
})