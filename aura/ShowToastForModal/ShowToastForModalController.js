/**
 * Created by akolotii on 11.05.2018.
 */
({
    doInit : function(component, event, helper){
        var duration = component.get('v.duration');
        var variant = component.get('v.variant');
        var toast = component.find('toast');

        switch(variant) {
            case 'error':
              $A.util.removeClass(toast, 'slds-theme--info');
              $A.util.addClass(toast, 'slds-theme--error');
              break;
            case 'success':
              $A.util.removeClass(toast, 'slds-theme--info');
              $A.util.addClass(toast, 'slds-theme--success');
              break;
            case 'warning':
              $A.util.removeClass(toast, 'slds-theme--info');
              $A.util.addClass(toast, 'slds-theme--warning');
              break;
          }
        window.setTimeout(
            $A.getCallback(function() {
                component.destroy();
            }), duration
        );
    },
    closeToast : function(component, event, helper){
        component.destroy();
    }
})