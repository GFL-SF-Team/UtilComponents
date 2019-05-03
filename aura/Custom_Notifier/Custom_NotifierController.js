/**
 * @Author: Aleksandr Shcherbanyuk
 * @Created Date: 11/01/2018
 */
({
    doAction : function(component, event, helper) {
        let params = event.getParam('arguments');
        if (params && params.hasOwnProperty('dataForAttributes')) {
            helper.initNotifier(component, params.dataForAttributes);
        }
    },

    handleClick : function(component, event, helper) {
        helper.fireNotifierEvent(component, event);
        helper.showAndHideComponent(component.find('customNotifier'));
    },
})