({
    openModal: function (component, event, helper) {


        let type = component.get('v.type');
        var cmpTarget;
        if(type === 'modal'){

            cmpTarget = component.find('modal');
        } else if(type === 'welcome-mat'){

            cmpTarget = component.find('modal-welcome');
        }
        var cmpBack = component.find('modal-backdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open');
        var size = component.get("v.size");
        var a = component.find("modal");
        if (size === 'large'){
            $A.util.addClass(a, 'slds-modal_large');
        } else  if (size === 'medium'){
                $A.util.addClass(a, 'slds-modal_medium');
        }
        //overwrite style to make header dark
        component.set("v.cssStyle", ".forceStyle .viewport .oneHeader.slds-global-header_container {z-index:0} .forceStyle.desktop .viewport{overflow:hidden}");
    },


    closeModal: function (component, event, helper) {
        let type = component.get('v.type');
        var cmpTarget;
        if(type === 'modal'){

            cmpTarget = component.find('modal');
        } else if(type === 'welcome-mat'){

            cmpTarget = component.find('modal-welcome');
        }

            var cmpBack = component.find('modal-backdrop');
            $A.util.removeClass(cmpBack, 'slds-backdrop--open');
            $A.util.removeClass(cmpTarget, 'slds-fade-in-open');


    }
})