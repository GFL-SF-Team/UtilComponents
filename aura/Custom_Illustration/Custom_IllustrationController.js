({
    show : function(cmp) {
        let element = cmp.find('illustration');
        $A.util.removeClass(element, 'slds-hide');
    },

    hide : function(cmp) {
        let element = cmp.find('illustration');
        $A.util.addClass(element, 'slds-hide');
    }
})