({
    createMapWithResults: function (cmp) {
        const profileList = cmp.get('v.profileList');
        let profileCheckResultMap = {};

        if ( !$A.util.isEmpty(profileList) ) {
            for (let profileKeyWord of profileList) {
                profileCheckResultMap[profileKeyWord] = false;
            }
        }

        cmp.set('v.profileCheckResultMap', profileCheckResultMap);
    },

    /*
     * @description: if the same set of array values is to be checked, then only one request will be sent to the org for checking
     * */
    checkProfiles: function (cmp, helper) {
        const profileList = cmp.get('v.profileList');

        if ( $A.util.isEmpty(profileList) ) { return; }

        const arrayStringKey = profileList.sort().toString();
        const accessCheckObj = {pending: true, result: {}};

        if ( $Utils.storage.set(arrayStringKey, accessCheckObj) ) {
            /* send one request for the same set of values */
            helper.sendRequestForCheck(cmp, helper, arrayStringKey);
        }
        else {
            helper.setWhenRequestReturns(cmp, helper, arrayStringKey);
        }
    },

    setWhenRequestReturns: function (cmp, helper, keyStorage) {
        const accessCheckObj = $Utils.storage.get(keyStorage);

        if (accessCheckObj.pending === true) {
            /* if the result is still pending, check it later */
            window.setTimeout($A.getCallback(() => {
                helper.setWhenRequestReturns(cmp, helper, keyStorage);
            }), 50);

        }
        else {
            /* set received values from request */
            cmp.set('v.profileCheckResultMap', accessCheckObj.result);
            /* send a signal that the checking of rights is over */
            helper.checkIsFinished(cmp);
        }
    },

    sendRequestForCheck: function (cmp, helper, keyStorage) {
        const params = {
            profileKeyWordList: cmp.get('v.profileList')
        };

        $Utils.sendPromiseRequest(cmp, 'checkProfiles', params)
        .then((result) => {
            if (result.success === true) {
                const data = JSON.parse(result.data);
                /* set result for current cmp */
                cmp.set('v.profileCheckResultMap', data);

                /* refresh obj in storage */
                const accessCheckObj = $Utils.storage.get(keyStorage);
                accessCheckObj.pending = false;
                accessCheckObj.result = data;

                $Utils.storage.override(keyStorage, accessCheckObj);

                /* send a signal that the checking of rights is over */
                helper.checkIsFinished(cmp);
            }
            else if (result.code === 400) {
                $Utils.showCriticalErrorToast(result.code);
                console.error('Utils_PermissionCheckingService - Invalid params!');
            }
            else {
                /* error from apex try-catch */
                $Utils.showCriticalErrorToast('UNKNOWN');
                console.error('ERROR UNKNOWN - Utils_PermissionCheckingService', result.message);
            }
        })
        .catch((errors) => {
            $Utils.showCriticalErrorToast();

            if ( !$A.util.isEmpty(errors) ) {
                console.log("Error string: " + JSON.stringify(errors));
                console.error('ERROR - Utils_PermissionCheckingService', errors);
            }
        });
    },

    checkIsFinished: function (cmp) {
        let compEvent = cmp.getEvent("onAfterChecking");
        compEvent.fire({});
    },
})