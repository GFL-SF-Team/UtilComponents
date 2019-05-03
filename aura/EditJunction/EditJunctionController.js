/**
 * Created by akolotii on 11.05.2018.
 */
({
    doInit : function(component, event, helper) {
        var oldStrike1 = component.get('v.fieldsForUpdate');
        var fieldsForUpdate = component.get('v.fieldsForUpdate');
        var recordDataForUpdate ='';

        var newRecordData = JSON.parse(JSON.stringify(component.get('v.recordData')));

 
        for(var i in fieldsForUpdate.fieldsForEdit){
            for(var j in newRecordData){
                if(newRecordData[j].field == fieldsForUpdate.fieldsForEdit[i]){
                    newRecordData[j].show = 'edit';
                }
            }
            if(fieldsForUpdate.fieldsForEdit.length -1 == i){
                recordDataForUpdate += fieldsForUpdate.fieldsForEdit[i];
            }else{
                recordDataForUpdate += fieldsForUpdate.fieldsForEdit[i] + ',';
            }
        }

        component.set('v.recordDataForUpdate',recordDataForUpdate);
        component.set('v.newRecordData',newRecordData);
    },

    handleSaveRecord: function(component, event, helper) {

        var updatedData = component.get('v.newRecordData');
        var data = component.get('v.recordData')
        var fieldsForUpdate = component.get('v.fieldsForUpdate');

        var updatedObjectParams =[]
        for(var i in fieldsForUpdate.fieldsForEdit){
            for(var k in updatedData){
                if(updatedData[k].field == fieldsForUpdate.fieldsForEdit[i] && updatedData[k].value != data[k].value){
                    var params = {'field' : fieldsForUpdate.fieldsForEdit[i],
                                  'value' : updatedData[k].value};
                                updatedObjectParams.push(params);
                                  component.set('v.simpleRecord.' + fieldsForUpdate.fieldsForEdit[i],updatedData[k].value);
                }
            }
        }

        var params = event.getParam('arguments');
        var callback;
        if (params) {
            callback = params.callback;
        }

        var key = component.get('v.key');
        var newData = {};
        component.find("recordEditor").saveRecord($A.getCallback(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {

                newData.key = key;
                newData.data = updatedObjectParams;
                newData.status = 'success';
                if (callback){
                    callback(newData);
                }
            } else if (saveResult.state === "INCOMPLETE") {
                // console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
               newData.status = 'error';
               newData.key = key;
               newData.data = component.get('v.recordData');
                if (callback){
                    callback(newData);
                }
            }
        }));
    }
})