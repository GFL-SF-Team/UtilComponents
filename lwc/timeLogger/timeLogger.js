import { LightningElement, track } from 'lwc';
import Helper from './timeLoggerHelper';
import { DEFAULT_TIMER_TEXT } from './timeLoggerConstants';

export default class TimeLogger extends LightningElement {

    @track timerText = DEFAULT_TIMER_TEXT;

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
        Helper.showTimer(this);
        Helper.showStartBtn(this);

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
        Helper.resetTimerInfo(this);
        Helper.setCmpStateToInitial(this);
    }

    handleChangeTypeOfInquiry(event) {
        Helper.disableSaveBtn(this);
        const value = event.detail.value;

        console.log('selected value', value);

        if (value) {
            this.fieldInfoMap.TypeOfInquiry__c = value;

            Helper.activateSaveBtn(this);
        }
    }
}