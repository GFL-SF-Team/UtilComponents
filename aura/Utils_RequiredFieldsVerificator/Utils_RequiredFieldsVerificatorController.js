/**
 * Created by andriylokotosh on 11/18/18.
 */
({
    init : function(cmp, evt, helper){},

    verifySObject : function(cmp, evt, helper){
        const sObject = cmp.get('v.sObject');
        const requiredFields = cmp.get('v.requiredFields');
        let failedFields = new Array();

        if(requiredFields != undefined && requiredFields != null){


            requiredFields.forEach((field) => {
                if ($A.util.isEmpty(sObject[field.value])) {
                     failedFields.push(field.label);
                }
            });




            if(failedFields.length > 0){
                cmp.set('v.failedFields', failedFields);
                helper.togglePopover(cmp);
                setTimeout(function(){ helper.togglePopover(cmp); },2000);
                return false;


            }


            return true;
        } else {
            return true;
        }
    },

    closePopover : function(cmp,evt,helper){
        helper.togglePopover(cmp);
    }


})