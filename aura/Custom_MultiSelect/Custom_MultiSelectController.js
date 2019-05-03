({
    init: function(cmp, event, helper) {
        try {

            helper.init(cmp, helper);

        }
        catch (exception) {
            $Utils.showCriticalErrorToast();
            $Utils.showExceptionInConsole(exception);
        }
    },

    reInit: function(cmp, event, helper) {
        try {

            helper.buildDropDownList(cmp, helper);

        }
        catch (exception) {
            $Utils.showCriticalErrorToast();
            $Utils.showExceptionInConsole(exception);
        }
    },

    handleSelection: function(cmp, event, helper) {
        try {

            helper.onOptionSelect(cmp, event, helper);

        }
        catch (exception) {
            $Utils.showCriticalErrorToast();
            $Utils.showExceptionInConsole(exception);
        }
    },

    handleDropDownClick: function(cmp, event, helper) {
        /* switch state 'open' or 'close' on the next definition of action */
        cmp.set('v.isDropDownOpen', !cmp.get('v.isDropDownOpen'));

        helper.setPositionForDropDownList(cmp);
        helper.delayedOpenOrCloseDropDownList(cmp);
    },

    handleDropDownFocusChange: function(cmp, event, helper) {
        cmp.set('v.isFocusedDropDown', !cmp.get('v.isFocusedDropDown'));
        helper.delayedOpenOrCloseDropDownList(cmp);
    },

    handleDropDownListOnFocus: function(cmp, event, helper) {
        cmp.set('v.isFocusedDropDownList', true);
        helper.delayedOpenOrCloseDropDownList(cmp);
    },

    handleDropDownListOnBlur: function(cmp, event, helper) {
        cmp.set('v.isFocusedDropDownList', false);
        helper.delayedOpenOrCloseDropDownList(cmp);
    },

    handleMouseEnter: function(cmp) {
        cmp.set('v.mouseHover', true);
    },

    handleMouseLeave: function(cmp, event, helper) {
        cmp.set('v.mouseHover', false);
        helper.hideDropDownListIfMouseNotHover(cmp);
    },

    handleSearchByOptionsOnInput: function(cmp, event, helper) {
        const inputValue = event.currentTarget.value.trim().toLowerCase();

        cmp.set('v.isShowSearchByOptionsClearButton', inputValue.length > 0);

        helper.filterOptions(cmp, inputValue);
    },

    onBtnClearSearchByOptionsInputValue: function(cmp, event, helper) {
        helper.clearSearchByOptionsInputValueAndFocusInput(cmp);

        cmp.set('v.isShowSearchByOptionsClearButton', false);

        helper.filterOptions(cmp, '');
    },

    getListWithSelectedOptions: function(cmp, event, helper) {
        return helper.getSelectedOptionList(cmp, helper, cmp.get('v.options_'));
    },

    deselectAllOptions: function(cmp, event, helper) {
        helper.resetSelectionForAllOptions(cmp);
    },

})