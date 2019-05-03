/**
 * Created by akolotii on 08.05.2018.
 * @history: Dmytro Lambru 24.01.19 - Code formatting and refactoring for better readability.
 *           Dmytro Lambru 12.03.19 - Fixed bug in clearLookup()
 */
({

    doInit : function(component, event, helper){
        helper.init(component, event, helper);
    },

	itemSelected : function(component, event, helper) {
		helper.itemSelected(component, event, helper, false);
	},

    serverCall :  function(component, event, helper) {
		helper.serverCall(component, event, helper);
		component.set('v.clearLookup', false);
		helper.serverCall(component, event, helper, false);
		component.set('v.clearLookup',false);
	},

    clearSelection : function(component, event, helper){
        component.set('v.recordId', '');
        helper.clearSelection(component, event, helper);
    },

    addUnderlying : function(component, event, helper){
	    var recordParams =component.get('v.recordParam');
        recordParams.status = component.get('v.status');

        var cmpEvent = component.getEvent("searchRecord");

        cmpEvent.fire({
            'recordId':component.get('v.selectedId'),
            'recordParam' : component.get('v.recordParam')
        });

        component.set('v.selectedId', null);
    },

    clearAutocomplete: function (component, event, helper) {

        if (event.target.getAttribute("autocomplete") !== "off") {
            event.target.setAttribute("autocomplete", "off");
        }
    },

    clearLookup: function (component, event, helper) {

        if (event.getParam('value') === true) {
            helper.clearSelection(component, event, helper);
            helper.clearInputValue(component);
            let variant = component.get('v.variant');
            if(variant === 'field'){
                component.find('unique-id').value = '';
            } else {
                if(document.getElementById('combobox-unique-id') != null && document.getElementById('combobox-unique-id') != undefined){
                    document.getElementById('combobox-unique-id').value = '';
                }
            }

            if (component.get('v.clearSearchText') === true) {
                component.set('v.last_SearchText', null);
            }
        }
    },

    clearLookupWhenNonFocus : function(component, event, helper){
       component.set("v.server_result", null);
    },

   clearLookupWhenNonFocus : function(component, event, helper){
       component.set("v.server_result",null);
   },

   hasRecordIdRefresh : function(component, event, helper) {
        helper.serverCall(component, event, helper, true);
        component.set('v.clearLookup',false);
    },



})