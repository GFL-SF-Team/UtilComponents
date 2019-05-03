({
    doInit: function (cmp, event, helper) {
        try {

            helper.createMapWithResults(cmp);
            helper.checkProfiles(cmp, helper);

        }
        catch (exception) {
            $Utils.showCriticalErrorToast();
            $Utils.showExceptionInConsole(exception);
        }
    }
})