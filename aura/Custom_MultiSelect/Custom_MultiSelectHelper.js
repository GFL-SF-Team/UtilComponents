({
    init: function(cmp, helper) {
        cmp.dropDownName = cmp.get('v.name');
        cmp.isAllEnable = cmp.get('v.isAllEnable');
        cmp.isAllByDefault = cmp.get('v.isAllByDefault');
        cmp.isMultiselectEnable = cmp.get('v.isMultiselectEnable');
        cmp.isAlwaysMultiselect = cmp.get('v.isAlwaysMultiselect');
        cmp.isAutoHideList = cmp.get('v.isAutoHideList');
        cmp.isShowSearchByOptions = cmp.get('v.isShowSearchByOptions');

        /* set new size and position for fixed list on window events */
        window.addEventListener('scroll', () => {
            helper.setPositionForDropDownList(cmp)
        });
        window.addEventListener('resize', () => {
            helper.setPositionForDropDownList(cmp)
        });

        helper.buildDropDownList(cmp, helper);
    },

    buildDropDownList: function(cmp, helper) {
        const options = cmp.get("v.options");

        if ( !$A.util.isUndefinedOrNull(options) ) {
            const clonedOptionList = $Utils.cloneAndBreakAllObjectReferences(options);

            helper.createPrivateOptionList(cmp, helper, clonedOptionList);
            helper.setInfoText(cmp, helper, clonedOptionList);
        }
    },

    createPrivateOptionList: function(cmp, helper, options) {
        /*
         * note, we get options and set options_
         * this is to allow us to sort the options array before rendering
         * options_ is the private version and we use this from now on
         * */

        if (cmp.isAllEnable) {
            const allOption = helper.createAllOption(cmp, helper, options);
            //add 'All' to options
            options.push(allOption);
        }

        helper.sortOptionListByOptionValueType(cmp, helper, options);

        /* Translate all the values in the options to the type of 'String' */
        for (const option of options) {
            option.value = '' + option.value;
        }

        //set sorted options
        cmp.set("v.options_", options);
    },

    sortOptionListByOptionValueType: function(cmp, helper, optionList) {
        const optionValueType = cmp.get('v.optionValueType');

        if (optionValueType === 'string') {
            optionList.sort(helper.compareStringOptionValue);
        }
        else if (optionValueType === 'integer') {
            optionList.sort(helper.compareIntegerOptionValue);
        }
    },

    compareStringOptionValue: function(a, b) {
        //'All' - always at the top of the list
        if (a.value === 'All') { return -1; }

        const aStringValue = '' + a.value;
        const bStringValue = '' + b.value;

        if (aStringValue < bStringValue) { return -1; }
        if ( aStringValue > bStringValue ) { return 1; }

        return 0;
    },

    compareIntegerOptionValue: function(a, b) {
        //'All' - always at the top of the list
        if (a.value === 'All') { return -1; }

        const aIntegerValue = (+a.value);
        const bIntegerValue = (+b.value);

        if ( aIntegerValue < bIntegerValue ) { return -1; }
        if ( aIntegerValue > bIntegerValue ) { return 1; }

        return 0;
    },

    createAllOption: function(cmp, helper, options) {
        const labelForAll = cmp.get('v.labelForAll');
        let allOption = options.find((optionMap) => optionMap.value === 'All');

        if (!!allOption === false) {
            allOption = {label: labelForAll, value: 'All'};
        }

        //if 'All' selected by default and other options not selected
        if ( cmp.isAllByDefault && helper.isNothingSelected(options) ) {
            allOption.selected = true;
        }

        return allOption;
    },

    /*
    * @description: determine info text for input placeholder from selected values
    * */
    setInfoText: function(cmp, helper, optionList) {
        const labelList = helper.getSelectedLabels(cmp, optionList);

        if (labelList.length === 0) {
            cmp.set( "v.infoText", cmp.get('v.defaultInfoText') );
        }
        else if (labelList.length === 1) {
            //set selected value label
            cmp.set("v.infoText", labelList[0]);
        }
        else if (labelList.length > 1) {
            //show number of selected labels
            cmp.set("v.infoText", `${labelList.length} options selected`);
        }
    },

    getSelectedValues: function (cmp, options) {
        let values = [];

        for (let option of options) {
            if (option.selected === true) {
                values.push(option.value);
            }
        }

        return values;
    },

    getSelectedLabels: function (cmp, options) {
        let labels = [];

        for (let option of options) {
            if (option.selected === true) {
                labels.push(option.label);
            }
        }

        return labels;
    },

    dispatchSelectChangeEvent: function (cmp, values) {
        const compEvent = cmp.getEvent("onSelectChange");

        /* create object for event with key => drop-down name | value => array with selected values */
        const mapObject = {};
        mapObject[cmp.dropDownName] = values;

        compEvent.fire({"map": mapObject});
    },

    dispatchMultiSelectChangeEvent: function (cmp, helper, optionList) {
        const compEvent = cmp.getEvent("onMultiSelectChange");

        /* create object for event with full info */
        const mapObject = {
            fieldName: cmp.get('v.name'),
            selectedOptionList: helper.getSelectedOptionList(cmp, helper, optionList),
        };

        compEvent.fire({"map": mapObject});
    },

    getSelectedOptionList: function (cmp, helper, optionList) {
        let selectedOptionList = [];

        if ( cmp.isAllEnable && helper.isAllSelected(optionList) ) {
            /* select all options except the "All" option */
            for (const optionMap of optionList) {

                if (optionMap.value === 'All') {
                    continue;
                }

                selectedOptionList.push(optionMap);
            }
        }
        else {
            /* select all selected options */
            for (const optionMap of optionList) {

                if (optionMap.selected === true) {
                    selectedOptionList.push(optionMap);
                }
            }
        }

        selectedOptionList = helper.optionValueCastingToSpecifiedDataType(cmp, selectedOptionList);

        return selectedOptionList;
    },

    /*
    * @description: To cast the data type for each option in the list.
    *               The option values have already been cast to the 'string' data type, so there is no implementation for this data type.
    * */
    optionValueCastingToSpecifiedDataType: function (cmp, optionList) {
        const clonedOptionList = $Utils.cloneAndBreakAllObjectReferences(optionList);
        const optionValueType = cmp.get('v.optionValueType');

        if (optionValueType === 'integer') {
            for (const optionMap of clonedOptionList) {
                optionMap.value = (+optionMap.value);
            }
        }

        return clonedOptionList;
    },

    onOptionSelect: function(cmp, event, helper) {

        if (cmp.get('v.disabled')) { return; }

        //get <li> element from event
        const item = event.currentTarget;

        if (!item && !item.dataset) {
            return;
        }

        let value = item.dataset.value;
        let selected = item.dataset.selected;
        let options = cmp.get("v.options_");

        //deselect 'All' option if another value is selected
        if ( cmp.isAllEnable && value !== 'All' ) {
            for (let option of options) {
                if (option.value === 'All') {
                    option.selected = false;
                }
            }
        }

        //if shift button hold down for multiple selection (or mobile phone)
        if (cmp.isMultiselectEnable && (cmp.isAlwaysMultiselect || event.shiftKey || helper.isPhone()) ) {

            for (let option of options) {

                if (option.value === value) {
                    //set 'true' if 'false' or vice versa
                    option.selected = selected !== "true";
                }
            }
        }
        else {

            for (let option of options) {
                //set 'true' on selected value and set other values to 'false' in options
                option.selected = option.value === value;
            }

            //hide drop-down list
            cmp.set('v.isDropDownOpen', false);
        }

        if ( cmp.isAllEnable && helper.isAllSelected(options) ) {
            //deselect all option except 'All'
            for (let option of options) {
                if (option.value !== 'All') {
                    option.selected = false;
                }
            }
        }

        if ( cmp.isAllEnable && cmp.isAllByDefault && helper.isNothingSelected(options) ) {
            //make 'All' selected if nothing selected from options
            for (let option of options) {
                if (option.value === 'All') {
                    option.selected = true;
                    break;
                }
            }
        }

        cmp.set("v.options_", options);

        let values = helper.getSelectedValues(cmp, options);

        helper.setInfoText(cmp, helper, options);
        //send selected values
        helper.dispatchSelectChangeEvent(cmp, values);
        helper.dispatchMultiSelectChangeEvent(cmp, helper, options);
    },

    isNothingSelected: function(options) {
        let isNothingSelected = true;

        for (let option of options) {
            if (option.value !== 'All' && option.selected === true) {
                isNothingSelected = false;
                break;
            }
        }

        return isNothingSelected;
    },

    isAllSelected: function(options) {
        let isAllSelected = false;

        //check - is 'All' selected or not
        for (let option of options) {
            if (option.value === 'All') {
                isAllSelected = option.selected;
                break;
            }
        }

        return isAllSelected;
    },

    isPhone: function() {
        const device = $A.get("$Browser.formFactor");

        return device === 'PHONE';
    },

    /*
    * @description: open on a first click or closes the drop-down list if it was a second click on the button
    *               or if the focus was lost from the drop-down and drop-down list
    * */
    delayedOpenOrCloseDropDownList: function(cmp) {
        /* hide drop-down list if there is no focus on drop-down or drop-down list  */
        window.setTimeout(
            $A.getCallback(() => {
                const isDropDownOpen = cmp.get('v.isDropDownOpen');
                const isFocusedDropDown = cmp.get('v.isFocusedDropDown');
                const isFocusedDropDownList = cmp.get('v.isFocusedDropDownList');

                if (isDropDownOpen && !isFocusedDropDown && !isFocusedDropDownList ) {
                    cmp.set('v.isDropDownOpen', false);
                }
            })
        );
    },

    filterOptions: function (cmp, inputValue) {
        const options_ = cmp.get('v.options_');

        for (let option of options_) {
            option.isHidden = !option.label.trim().toLowerCase().includes(inputValue);
        }

        cmp.set('v.options_', options_);
    },

    clearSearchByOptionsInputValueAndFocusInput: function(cmp) {
        /* clear input value and attribute for input value */
        const inputElement = cmp.find('searchByOptionInput').getElement();
        inputElement.value = '';
        inputElement.focus();
    },

    setPositionForDropDownList: function (cmp) {

        if (cmp.get('v.isDropDownOpen') === true) {
            const inputRect = cmp.find('#main_input').getElement().getBoundingClientRect();
            const fixedDropDownList = cmp.find('#fixed_drop_down_list').getElement();
            const distanceFromInputToBottom = window.innerHeight - inputRect.bottom;

            /* set input width for list */
            fixedDropDownList.style.width = `${inputRect.width}px`;
            /* list is hidden before setting position */
            fixedDropDownList.style.visibility = 'hidden';

            window.setTimeout(
                $A.getCallback(() => {
                    /* fresh list height */
                    const fixedDropDownListHeight = fixedDropDownList.getBoundingClientRect().height;

                    /* if the list does not have enough space from the input field to the bottom of the window,
                     * then it will open at the top of the input field
                     *  */
                    if ( distanceFromInputToBottom < (fixedDropDownListHeight + 1) ) {
                        fixedDropDownList.style.top = `${inputRect.top - fixedDropDownListHeight - 1}px`;
                    }
                    else {
                        fixedDropDownList.style.top = `${inputRect.bottom + 1}px`;
                    }

                    fixedDropDownList.style.visibility = 'visible';
                })
            );
        }
    },

    hideDropDownListIfMouseNotHover: function (cmp) {

        if (cmp.isAutoHideList) {
            window.setTimeout(
                $A.getCallback(function() {
                    if (cmp.get('v.mouseHover') === false) {
                        //hide drop-down list
                        cmp.set('v.isDropDownOpen', false);
                    }
                }), 200
            );
        }
    },

    resetSelectionForAllOptions: function (cmp) {
        const optionList = cmp.get('v.options_');

        for (const optionMap of optionList) {
            optionMap.selected = false;
        }

        cmp.set('v.options', optionList);
    },
})