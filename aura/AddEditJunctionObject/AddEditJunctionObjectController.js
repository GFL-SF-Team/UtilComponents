/**
 * @History: INT 207  Aleksandr Shcherbanyuk 11/06/18: added Trade Step Logic
 * @History: INT 281  Aleksandr Shcherbanyuk 11/15/18: added Trade Step Logic
 * @History: INT-332  Aleksandr Shcherbanyuk 12/19/18: removed helper.fireApplicationEventComponentChanged(component) call from editConfirm method
 */
({
	closeModal: function(component, event, helper){
		$A.get("e.force:closeQuickAction").fire();
	},

	addRecordToJunction : function(component, event, helper){
		var relatedRecordId = event.getParam("recordId");
		var recordId = component.get('v.recordId');
		helper.addRecordToJunctionObject(component, recordId, relatedRecordId);
		component.set('v.clearLookup', true);
		helper.toggleSpinner(component);
	},

	doInit : function(component, event, helper){
		var recordId = component.get('v.recordId');
		helper.getDataForComponent(component,recordId);
	},

	deleteJunctionObjectRecord : function(component, event, helper){
	   helper.toggleSpinner(component);
		var junctionRecordId = event.getSource().get('v.value');
	   helper.deleteRecordFomJunction(component,junctionRecordId);
	},

	editJunctionObject: function(component, event, helper){
		var junctionObjectId = event.getSource().get('v.value');
		component.set('v.junctionObjectId',junctionObjectId);
	},

	editConfirm : function (component, event, helper){
		let isTradeStep = component.get('v.isTradeStep');
		component.set('v.junctionObjectId',false);
		var childCmp = component.find("editComponent");
		var junctionObjectId = event.getSource().get('v.value');
		helper.toggleSpinner(component);
		childCmp.handleSaveRecord(function(result) {

			var recordData = component.get('v.recordData');

			for(var c in result.data){
				for(var i in recordData[result.key].recordsData){
					if(recordData[result.key].recordsData[i].field == result.data[c].field){
						recordData[result.key].recordsData[i].value = result.data[c].value
					}
				}
			}

			component.set('v.recordData',recordData);

			if(result.status == 'success') {

				var objectName = component.get('v.relatedObjectName');

				helper.fireRecordChangeEvent('update',junctionObjectId,objectName);
				if (!isTradeStep) {
					helper.showToast(component, 'Successful edited','success','Success!');
				}
				helper.toggleSpinner(component);
			}else if(result.status == 'error'){
				helper.showToast(component, 'Update Error','error','Error!');
				helper.toggleSpinner(component);
			}
		});
	}
})