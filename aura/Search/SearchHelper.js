({


    init : function(component, event, helper) {
        let recordId = component.get('v.recordId');

        if(!$A.util.isEmpty(recordId) && !$A.util.isUndefinedOrNull(recordId)){
            helper.findRecordById(component, event, helper, recordId);
        }
    },

    findRecordById : function(component, event, helper) {
       //let action = component.get('c.getRecordById');
       //let whereClause = component.get('v.whereClauseMap');
       //whereClause['Id'] = component.get('v.recordId');
       //component.set('v.whereClauseMap', whereClause);
       helper.serverCall(component, event, helper, true);
    },

	itemSelected : function(component, event, helper, init) {
        var serverResult = component.get("v.server_result");
        var target;
        var selectedIndex;

       if (init){
            selectedIndex = 0;
        } else {
             target = event.target;
           selectedIndex = this.getIndexFrmParent(target, helper, "data-selectedIndex");
        }


            var selectedItem = serverResult[selectedIndex];

            if (selectedItem.id) {
                component.set("v.selItem", selectedItem);
                component.set("v.last_ServerResult", serverResult);
            }

            component.set("v.server_result", null);


        component.set('v.selectedId', selectedItem.id);
        component.set('v.recordParam', selectedItem);

        if (component.get('v.variant') === 'field') {
            this.broadcastSelectedId(component);
        }
	},

    serverCall: function (component, event, helper, init) {
        var target;
        var searchText;
        var last_SearchText = component.get("v.last_SearchText");

       if(init){
          searchText = component.get('v.recordId');
        } else {
            target = event.target;
            searchText = target.value;
        }


        if (component.get('v.variant') === 'field' && !init) {
            searchText = event.getSource().get('v.value');
        }

        component.set("v.last_SearchText", searchText);

        if (event.which === 27 || !searchText) {
            helper.clearSelection(component, event, helper);
        }
        else if (init ||  searchText !== last_SearchText) {
            searchText = searchText.trim();
            component.set("v.last_SearchText", searchText);

            var objectName = component.get("v.objectName");
            var fieldForSearch = component.get("v.field_For_Search");
            var field_API_search = component.get("v.field_API_search");
            var limit = component.get("v.limit");

            var action = component.get('c.searchDB');
            action.setStorable();
            action.setParams({
                recordId : component.get('v.recordId'),
                objectName: objectName,
                fieldForSearchLists: fieldForSearch,
                lim: limit,
                fieldForShow: field_API_search,
                searchText: searchText,
                prefix: component.get('v.prefix'),
                filterRecordType: component.get('v.filterFields'),
                filterFields: component.get('v.whereClauseMap'),
                sortRecordFields: component.get('v.sortRecordFields'),
            });

            action.setCallback(this, function (result) {
                this.handleResponse(result, component, helper, init);
            });

            $A.enqueueAction(action);
        } else if (searchText && last_SearchText && searchText === last_SearchText) {
            component.set("v.server_result", component.get("v.last_ServerResult"));
        }
    },

    handleResponse : function (res ,component, helper, init){

        if (res.getState() === 'SUCCESS') {
            var retObj = JSON.parse(res.getReturnValue());
            var noResult = [];
            noResult.push({'resultParams': ["No Results Found"]});

            if (retObj.length <= 0) {
                component.set("v.server_result", noResult);
                component.set("v.last_ServerResult", noResult);
            } else {
                component.set("v.server_result", retObj);
                component.set("v.last_ServerResult", retObj);

                if(init){
                    helper.itemSelected(component, undefined, helper, init);
                }
            }
        } else if (res.getState() === 'ERROR') {
            var errors = res.getError();

            if (errors) {
                if (errors[0] && errors[0].message) {
//                    alert(errors[0].message);
                }
            }
        }
    },

    getIndexFrmParent: function (target, helper, attributeToFind) {
        var selectedIndex = target.getAttribute(attributeToFind);

        while (!selectedIndex) {
            target = target.parentNode;
            selectedIndex = helper.getIndexFrmParent(target, helper, attributeToFind);
        }

        return selectedIndex;
    },

    broadcastSelectedId : function(component){
        var cmpEvent = component.getEvent("searchRecord");

        cmpEvent.fire({
            'recordId': component.get('v.selectedId'),
            'fieldApi': component.get('v.onObjectFieldAPI'),
            'recordParam': component.get('v.recordParam')
        });
    },

    clearSelection: function(component, event, helper){
        component.set("v.selItem", null);
        component.set("v.server_result", null);
    },

    clearInputValue: function(component) {
        let variant = component.get('v.variant');

        if (variant === 'field') {
            const findResult = component.find('unique-id');

            if (!!findResult && $A.util.isArray(findResult)) {
                for (const inputCmp of findResult) {
                    inputCmp.set('v.value', '');
                }
            }
            else {
                findResult.set('v.value', '');
            }
        }
        else if (document.getElementById('combobox-unique-id') !== null && document.getElementById('combobox-unique-id') !== undefined) {
            document.getElementById('combobox-unique-id').value = '';
        }
    },
})