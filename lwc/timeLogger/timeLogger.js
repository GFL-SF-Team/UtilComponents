import { LightningElement, track } from 'lwc';
import Helper from './timeLoggerHelper';

export default class TimeLogger extends LightningElement {

    @track timeSpent = '00m 00s';

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
        Helper.showStartBtn(this);
        Helper.showTimer(this);

        this.startCacheCheck();
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

    startCacheCheck() {
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setInterval(() => {

            const timeLoggerCacheMap = JSON.parse(localStorage.getItem('time_logger_cache'));

            console.log('timeLoggerCacheMap', timeLoggerCacheMap);


            if (timeLoggerCacheMap && timeLoggerCacheMap.cmpStateInfoMap && timeLoggerCacheMap.timerInfoMap) {

                if (timeLoggerCacheMap.cmpStateInfoMap.isInitialState && !this.cmpStateInfoMap.isInitialState) {
                    // this.setCmpStateToInitial();
                    console.log('setCmpStateToInitial()');

                    this.timerInfoMap = timeLoggerCacheMap.timerInfoMap;
                    this.cmpStateInfoMap = timeLoggerCacheMap.cmpStateInfoMap;

                    this.resetCmpState();
                    Helper.showStartBtn(this);
                    Helper.showTimer(this);
                }

                if (timeLoggerCacheMap.cmpStateInfoMap.isTimerState && !this.cmpStateInfoMap.isTimerState) {
                    // this.setCmpStateToTimer();
                    console.log('setCmpStateToTimer()');

                    this.timerInfoMap = timeLoggerCacheMap.timerInfoMap;
                    this.cmpStateInfoMap = timeLoggerCacheMap.cmpStateInfoMap;

                    this.resetCmpState();

                    Helper.showTimer(this);

                    this.handleStartBtn();
                }

                if (timeLoggerCacheMap.cmpStateInfoMap.isRecordSaveState && !this.cmpStateInfoMap.isRecordSaveState) {
                    // this.setCmpStateToSaveRecord();
                    console.log('setCmpStateToSaveRecord()');

                    this.timerInfoMap = timeLoggerCacheMap.timerInfoMap;
                    this.cmpStateInfoMap = timeLoggerCacheMap.cmpStateInfoMap;

                    this.resetCmpState();
                    this.handleFinishBtn();
                }

            }
        }, 1000);
    }

    resetCmpState() {
        this.isShowTimer = false;
        this.isShowStartBtn = false;
        this.isShowFinishBtn = false;
        this.isShowSaveBtn = false;
        this.isShowFields = false;
    }

    handleStartBtn() {
        this.cmpStateInfoMap = {
            isInitialState: false,
            isTimerState: true,
            isRecordSaveState: false,
        };

        Helper.startTimer(this);

        const timeLoggerCacheMap = {
            timerInfoMap: this.timerInfoMap,
            cmpStateInfoMap: this.cmpStateInfoMap
        }

        console.log('timeLoggerCacheMap >>>', timeLoggerCacheMap);

        localStorage.setItem('time_logger_cache', JSON.stringify(timeLoggerCacheMap));

        Helper.hideStartBtn(this);
        Helper.showFinishBtn(this);
    }

    handleFinishBtn() {
        this.cmpStateInfoMap = {
            isInitialState: false,
            isTimerState: false,
            isRecordSaveState: true,
        };

        Helper.hideTimer(this);

        Helper.calculateMinutesSpent(this);
        Helper.resetTimer(this);

        const timeLoggerCacheMap = {
            timerInfoMap: this.timerInfoMap,
            cmpStateInfoMap: this.cmpStateInfoMap
        }

        localStorage.setItem('time_logger_cache', JSON.stringify(timeLoggerCacheMap));

        Helper.hideFinishBtn(this);

        Helper.showFields(this);
        Helper.showSaveBtn(this);
    }

    handleSaveBtn() {
        Helper.resetTimerInfo(this);

        this.cmpStateInfoMap = {
            isInitialState: true,
            isTimerState: false,
            isRecordSaveState: false,
        };

        const timeLoggerCacheMap = {
            timerInfoMap: this.timerInfoMap,
            cmpStateInfoMap: this.cmpStateInfoMap
        }

        localStorage.setItem('time_logger_cache', JSON.stringify(timeLoggerCacheMap));

        Helper.saveLogRecord(this);

        Helper.hideFields(this);
        Helper.disableSaveBtn(this);
        Helper.hideSaveBtn(this);

        Helper.showTimer(this);
        Helper.showStartBtn(this);
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