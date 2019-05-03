/**
 * @History: INT 207  Aleksandr Shcherbanyuk 11/06/18: added Trade Step Logic
 * @History: INT 281  Aleksandr Shcherbanyuk 11/15/18: added Trade Step Logic
 * @History: INT-332  Aleksandr Shcherbanyuk 12/19/18: removed method fireApplicationEventComponentChanged and calls from helper methods
 */
({
    getDataForComponent : function(component, recordId){
        var self = this;
        var action = component.get('c.generateDataForComponent');
        action.setParams({
            'recordId' : recordId,
            'relatedObject' : component.get('v.relatedObjectName')
        });
        action.setCallback(this,function(response){
            if (response.getState() === 'SUCCESS') {

                var serverResponse = response.getReturnValue();
                var searchParams = JSON.parse(serverResponse.searchParams);

                var relatedParams = JSON.parse(serverResponse.relatedParams);
                var recordsData = JSON.parse(serverResponse.recordsData);
                var fieldsForUpdate = JSON.parse(serverResponse.fieldsForUpdate);
                var fieldsForShow = JSON.parse(serverResponse.fieldsForShow);

                component.set('v.searchParams',searchParams);
                component.set('v.relatedRecords',relatedParams);
                component.set('v.recordData',recordsData);
                component.set('v.fieldsForUpdate',fieldsForUpdate);
                component.set('v.fieldsForShow',fieldsForShow);

                var labels = [];

                if(recordsData.length > 0){
                    for(var i in recordsData[0].recordsData){
                        if(recordsData[0].recordsData[i].show == 'show'){
                            labels.push(recordsData[0].recordsData[i].label);
                        }
                    }
                }

                component.set('v.labels',labels);

            }else if (response.getState() === 'ERROR'){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        self.showToast(component, errors[0].message,'error','Error!');
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },

    addRecordToJunctionObject : function(component, recordId, relatedRecordId){
        var self = this;
        var action = component.get('c.addRecordToJuncionObject');
        let isTradeStep = component.get('v.isTradeStep');
        action.setParams({
            'currentRecordId' : recordId,
            'relatedRecordId' : relatedRecordId,
            'relatedRecords' : JSON.stringify(component.get('v.relatedRecords')),
            'fieldsForUpdate' : JSON.stringify(component.get('v.fieldsForUpdate')),
            'fieldsForShow' : JSON.stringify(component.get('v.fieldsForShow'))
        });
        action.setCallback(this,function(response){
            if (response.getState() === 'SUCCESS') {
                var newRecord = JSON.parse(response.getReturnValue());
                var recordsData = component.get('v.recordData');
                recordsData.push(newRecord[0]);
                component.set('v.recordData',recordsData);

                var labels = [];

                if(recordsData.length > 0){
                    for(var i in recordsData[0].recordsData){
                        if(recordsData[0].recordsData[i].show == 'show'){
                            labels.push(recordsData[0].recordsData[i].label);
                        }
                    }
                }
                var objectName = component.get('v.relatedObjectName');
                self.fireRecordChangeEvent('create',recordsData[0].recordsData[0].junctionObjectId,objectName);
                component.set('v.labels',labels);
                if (!isTradeStep) {
                    self.showToast(component, 'Successfully added','success','Success!');
                }
                self.toggleSpinner(component);
            }else if (response.getState() === 'ERROR'){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        self.showToast(component, errors[0].message,'error','Error!');
                        self.toggleSpinner(component);
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },

    deleteRecordFomJunction : function(component, junctionRecordId){
        let isTradeStep = component.get('v.isTradeStep');
       var self = this;
       var action = component.get('c.deleteRecordFromJunctionObject');

       action.setParams({
           'junctionRecordId' : junctionRecordId,
       });
       action.setCallback(this,function(response){
           if (response.getState() === 'SUCCESS') {
            var recorsdData = component.get('v.recordData');

            for(var i in recorsdData){
                if(recorsdData[i].recordsData[0].junctionObjectId == junctionRecordId){
                     recorsdData.splice(i, 1);
                }
            }

            component.set('v.recordData',recorsdData);

            var objectName = component.get('v.relatedObjectName');

            self.fireRecordChangeEvent('delete',junctionRecordId,objectName);
           if (!isTradeStep) {
               self.showToast(component, 'Underlying has been successfully deleted','success','Success!');
           }
            self.toggleSpinner(component);
           }else if (response.getState() === 'ERROR'){
               var errors = response.getError();
               if (errors) {
                   if (errors[0] && errors[0].message) {
                       self.showToast(component, errors[0].message,'error','Error!');
                       self.toggleSpinner(component);
                   }
               }
           }
       });
       $A.enqueueAction(action);
   },

// INT 214  Aleksandr Shcherbanyuk 9/28/18
    showToast : function(component,message,variant,title) {
        var isModal = component.get('v.isModal');
        var objectName = component.get('v.relatedObjectName');
        if (!isModal) {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : title,
                message: message,
                duration:'2000',
                type: variant,
                mode: 'dismissible'
            });
            toastEvent.fire();
        } else {
            $A.createComponent(
                "c:ShowToastForModal",
                {
                    "title": title,
                    "variant" : variant,
                    "message" : message
                },
                function(toast, status, errorMessage){
                    if (status === "SUCCESS") {
                        var targetCmp = component.find('placeForToast');
                        var body = targetCmp.get("v.body");
                        body.push(toast);
                        targetCmp.set("v.body", body);
                    }
                }
            );
        }
    },

    toggleSpinner : function(component) {
            var spinner = component.find('spinner');
            $A.util.toggleClass(spinner, "slds-hide");
    },

    fireRecordChangeEvent : function(status, junctionRecordId, objectName){
        var appEvent = $A.get("e.c:actionWithRelatedRecordEvent");
        appEvent.setParams({
            "status" : status,
            "relatedObjectId" : junctionRecordId,
            "objectName" : objectName});
        appEvent.fire();
    },
})