import { LightningElement, track } from 'lwc';
import Helper from './timeLoggerHelper';
import { DEFAULT_TIMER_TEMPLATE } from './timeLoggerConstants';

export default class TimeLogger extends LightningElement {

    @track timerText;

    @track isShowTimer = false;
    @track isShowStartBtn = false;
    @track isShowFinishBtn = false;
    @track isShowSaveBtn = false;
    @track isShowFields = false;

    @track isDisabledSaveBtn = true;

    timerInfoMap = {
        startTime: 0,
        endTime: 0
    };

    cmpStateInfoMap = {
        isInitialState: true,
        isTimerState: false,
        isRecordSaveState: false,
    };

    fieldInfoMap = {
        TimeSpent__c: 0,
        TypeOfInquiry__c: undefined
    };

    connectedCallback() {
        Helper.setDefaultTimerText(this);
        Helper.setCmpViewStateToInitial(this);
        Helper.startCacheCheck(this);
    }

    get typeOfInquiryOptionList() {
        return [
            { label: 'Call', value: 'Call' },
            { label: 'Walk-In', value: 'Walk-In' },
            { label: 'Website', value: 'Website' },
        ];
    }

    get timeSpentInMinutes() {
        return this.fieldInfoMap.TimeSpent__c;
    }

    handleStartBtn() {
        Helper.setCmpStateToTimer(this);
    }

    handleFinishBtn() {
        Helper.setCmpStateToSaveRecord(this);
    }

    handleSaveBtn() {
        Helper.saveLogRecord(this);
        Helper.setCmpStateToInitial(this);
    }

    handleCancelBtn() {
        Helper.setCmpStateToInitial(this);
    }

    handleChangeTypeOfInquiry(event) {
        const value = event.detail.value;
        Helper.disableSaveBtn(this);

        if (value) {
            this.fieldInfoMap.TypeOfInquiry__c = value;

            Helper.activateSaveBtn(this);
        }
    }
}