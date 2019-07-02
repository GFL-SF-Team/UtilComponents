import { LightningElement, api, track } from 'lwc';
import helper from './utilLookupHelper';
import { isObject, jsonConverter } from 'c/utils';

export default class UtilLookup extends LightningElement {

    // public properties
    @api get config() {
        return this._configMap;
    }
    set config(configMap) {

        if (!isObject(configMap)) return;

        configMap = jsonConverter(configMap);

        // grab all configs
        this._configMap = { ...this.defaultConfigMap, ...this._configMap, ...configMap };
        // set valid size
        this._configMap.listSize = helper.validateListSize(this._configMap.listSize);

        // copy a number of records for the query from size of list
        this._configMap.searchConfigMap.numberOfRecords = this._configMap.listSize;
    }

    // public methods
    @api removeSelectedRecord() {
        helper.hideInputWithSelectedRecord(this);
    }

    // private tracked
    @track recordList = [];
    @track isLoading = false;
    @track isShowInputWithSelectedRecord = false;
    @track isListOpen = false;

    // private
    _configMap = {}; // config cache (use config() getter and setter)
    selectedRecordInfo = {}; // information about selected record

    focusStateMap = { // to track focused elements of component
        isInputFocused: false,
        isListFocused: false
    };

    defaultConfigMap = {
        label: 'Lookup for', // label text
        isLabelHidden: false, // Is the input field label hidden or not?
        placeholder: 'Lookup for ...', // placeholder for input field
        listSize: 5, // max number of list items (5 or 7 or 10 only)
        isHiddenInputWithSelectedRecord: false, // Is the hidden input field with the selected record?

        icon: { // icon config
            name: 'standard:account', // SLDS icon
            size: 'small',
            alternativeText: 'Account'
        },

        searchConfigMap: { // config for search
            objectName: 'Account',
            fieldForQueryList: ['Name', 'Phone', 'Type', 'Site'], // fields to query
            fieldForSearchList: ['Name', 'Site'], // fields for search through 'Name LIKE %text for search% OR Site ...'
            fieldForOrderList: ['Name'], // optional - fields for 'ORDER BY Name, Site'
            fieldForFilterCriterionList: [ // optional - fields for filtering 'NumberOfEmployees = 8 AND ...'
                { fieldName: 'NumberOfEmployees', condition: '=', value: '8', typeOfValue: 'Integer' },
                { fieldName: 'Type', condition: '=', value: 'Customer - Direct', typeOfValue: 'String' },
            ],
            fieldToShowList: [ // fields to display in the result list
                { fieldName: 'Name', isFieldLabelHidden: true }, // without label
                { fieldLabel: 'Phone number', fieldName: 'Phone', isFieldLabelHidden: false }, // with custom label
                { fieldName: 'Name', isFieldLabelHidden: false }, // with label from org
            ]
        }
    }

    // private methods for markup computed value

    /**
     * @description set generated classes for the main container of the list with a search result.
     * @author Dmytro Lambru
     * @readonly
     */
    get listContainerClass() {
        let classString = 'slds-dropdown slds-dropdown_fluid my-list-container ';
        classString += `slds-dropdown_length-with-icon-${this.config.listSize}`;

        return classString;
    }

    /**
     * @description show the value of the first field to display from the selected record in the input with selected record.
     * @author Dmytro Lambru
     * @readonly
     */
    get valueOfFirstFieldToShowOfSelectedRecord() {
        const [firstFieldToShow] = this.selectedRecordInfo.fieldToShowInfoList;

        return firstFieldToShow.fieldValue;
    }

    // controller functions

    /**
     * @description on change of input value
     * @author Dmytro Lambru
     * @param {object} event
     */
    handleInputChange(event) {
        const stringToSearch = event.target.value.trim();

        if (!stringToSearch) {
            helper.clearInputAndRecords(this);
            return;
        }

        helper.showClearBtn(this);
        helper.doLookup(this, stringToSearch);
    }

    /**
     * @description on 'clear' button click in the input field
     * @author Dmytro Lambru
     */
    handleClearInput() {
        helper.clearInputAndRecords(this);
        helper.changeFocusOnInput(this);
    }

    /**
     * @description focus action on input field element
     * @author Dmytro Lambru
     */
    handleInputFocus() {
        this.focusStateMap.isInputFocused = true;

        helper.openList(this);
    }

    /**
     * @description defocus action on input field element
     * @author Dmytro Lambru
     */
    handleInputBlur() {
        this.focusStateMap.isInputFocused = false;

        helper.respondToStateChange(this);
    }

    /**
     * @description focus action on list with search result
     * @author Dmytro Lambru
     */
    handleListFocus() {
        this.focusStateMap.isListFocused = true;
    }

    /**
     * @description defocus action on list with search result
     * @author Dmytro Lambru
     */
    handleListBlur() {
        this.focusStateMap.isListFocused = false;

        helper.respondToStateChange(this);
    }

    /**
     * @description click action on list item element
     * @author Dmytro Lambru
     * @param {object} event
     */
    handleListItemClick(event) {
        const recordId = event.currentTarget.dataset.recordId;

        helper.setSelectedRecordInfo(this, recordId);
        helper.clearInputAndRecords(this);
        helper.showInputWithSelectedRecord(this);
        helper.fireEventWithSelectedRecord(this);

        this.handleListBlur();
    }

    /**
     * @description 'remove' button click action on input field with selected record
     * @author Dmytro Lambru
     */
    handleRemoveSelectedRecord() {
        helper.fireEventSelectedRecordRemoved(this);
        helper.hideInputWithSelectedRecord(this);
    }
}