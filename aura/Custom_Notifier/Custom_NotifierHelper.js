/**
 * @Author: Aleksandr Shcherbanyuk
 * @Created Date: 11/01/2018
 */
({
    initNotifier : function(component, dataForAttributes) {
        if (Object.keys(dataForAttributes).length === 0) {
            console.log('Invalid Data-Object.');
            return;
        }
        for (let key in dataForAttributes) {
            switch (key) {
                case 'notifierType':
                    component.set('v.notifierType', dataForAttributes[key]);
                    break;
                case 'title':
                    component.set('v.title', dataForAttributes[key]);
                    break;
                case 'message':
                    component.set('v.message', dataForAttributes[key]);
                    break;
                case 'styleForMessage':
                    component.set('v.styleForMessage', dataForAttributes[key]);
                    break;
                case 'buttonName':
                    component.set('v.buttonName', dataForAttributes[key]);
                    break;
                default:
                    console.log('Invalid param given.');
                    break;
            }
        }
        this.showAndHideComponent(component.find('customNotifier'));
    },

    showAndHideComponent: function(foundComponent) {
        $A.util.toggleClass(foundComponent, 'slds-hide');
    },

    fireNotifierEvent : function (component, event) {
        let compEvent = component.getEvent('Custom_NotifierEvent');
        compEvent.setParams({
            'isButtonPressed' : true
        });
        compEvent.fire();
    }
})