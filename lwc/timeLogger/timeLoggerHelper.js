import Utils from './timeLoggerUtils';
import saveLog from '@salesforce/apex/TimeLoggerController.saveLog';
import { DEFAULT_TIMER_TEXT } from './timeLoggerConstants';

export default new class TimeLoggerHelper {

    timerIntervalId;

    startCacheCheck(cmp) {
        this.cacheCheck(cmp);

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setInterval(() => {
            this.cacheCheck(cmp);
        }, 1000);
    }

    cacheCheck(cmp) {
        const timeLoggerCacheMap = this.getTimeLoggerCache();

        console.log('interval >>> timeLoggerCacheMap', timeLoggerCacheMap);

        if (timeLoggerCacheMap && timeLoggerCacheMap.cmpStateInfoMap && timeLoggerCacheMap.timerInfoMap) {

            if (timeLoggerCacheMap.cmpStateInfoMap.isInitialState && !cmp.cmpStateInfoMap.isInitialState) {
                console.log('setCmpStateToInitial()');

                this.updateCmpDataFromCache(cmp, timeLoggerCacheMap);
                this.setCmpStateToInitial(cmp);
            }

            if (timeLoggerCacheMap.cmpStateInfoMap.isTimerState && !cmp.cmpStateInfoMap.isTimerState) {
                console.log('setCmpStateToTimer()');

                this.updateCmpDataFromCache(cmp, timeLoggerCacheMap);
                this.setCmpStateToTimer(cmp);
            }

            if (timeLoggerCacheMap.cmpStateInfoMap.isRecordSaveState && !cmp.cmpStateInfoMap.isRecordSaveState) {
                console.log('setCmpStateToSaveRecord()');

                this.updateCmpDataFromCache(cmp, timeLoggerCacheMap);
                this.setCmpStateToSaveRecord(cmp);
            }
        }
    }

    updateCmpDataFromCache(cmp, timeLoggerCacheMap) {
        cmp.timerInfoMap = timeLoggerCacheMap.timerInfoMap;
        cmp.cmpStateInfoMap = timeLoggerCacheMap.cmpStateInfoMap;
    }

    setCmpStateToInitial(cmp) {
        this.resetCmpElementViewState(cmp);
        this.showTimer(cmp);
        this.showStartBtn(cmp);
        this.disableSaveBtn(cmp);

        this.changeCmpStateInfo(cmp, { isInitialState: true });

        this.updateTimeLoggerCache(cmp);
    }

    setCmpStateToTimer(cmp) {
        this.startTimer(cmp);

        this.resetCmpElementViewState(cmp);
        this.showTimer(cmp);
        this.showFinishBtn(cmp);

        this.changeCmpStateInfo(cmp, { isTimerState: true });

        this.updateTimeLoggerCache(cmp);
    }

    setCmpStateToSaveRecord(cmp) {
        this.calculateMinutesSpent(cmp);
        this.resetTimer(cmp);

        this.resetCmpElementViewState(cmp);
        this.showFields(cmp);
        this.showSaveBtn(cmp);

        this.changeCmpStateInfo(cmp, { isRecordSaveState: true });

        this.updateTimeLoggerCache(cmp);
    }

    resetCmpElementViewState(cmp) {
        this.hideTimer(cmp);
        this.hideStartBtn(cmp);
        this.hideFinishBtn(cmp);
        this.hideFields(cmp);
        this.hideSaveBtn(cmp);
    }

    changeCmpStateInfo(cmp, stateInfoMap) {
        const {
            isInitialState = false,
            isTimerState = false,
            isRecordSaveState = false
        } = stateInfoMap;

        cmp.cmpStateInfoMap = {
            isInitialState,
            isTimerState,
            isRecordSaveState
        };
    }

    getTimeLoggerCache() {
        const timeLoggerCacheJSON = localStorage.getItem('time_logger_cache');

        return JSON.parse(timeLoggerCacheJSON);
    }

    updateTimeLoggerCache(cmp) {
        const timeLoggerCacheMap = {
            timerInfoMap: cmp.timerInfoMap,
            cmpStateInfoMap: cmp.cmpStateInfoMap
        }

        localStorage.setItem('time_logger_cache', JSON.stringify(timeLoggerCacheMap));
    }

    startTimer(cmp) {

        if (cmp.timerInfoMap.startTime === 0) {
            cmp.timerInfoMap.startTime = Date.now() / 1000;
        }

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.timerIntervalId = setInterval(() => {
            const timeNow = Date.now() / 1000;

            // Find the distance between now and the count down date
            const diff = timeNow - cmp.timerInfoMap.startTime;

            // does the same job as parseInt truncates the float
            let minutes = (diff / 60) | 0;
            let seconds = (diff % 60) | 0;

            minutes = this.timeNumberFormat(minutes);
            seconds = this.timeNumberFormat(seconds);

            cmp.timerText = `${minutes}m ${seconds}s`;

        }, 1000);
    }

    timeNumberFormat(number) {
        return number < 10 ? "0" + number : number;
    }

    calculateMinutesSpent(cmp) {

        if (cmp.timerInfoMap.endTime === 0) {
            cmp.timerInfoMap.endTime = Date.now() / 1000;
        }

        // Find the distance between now and start
        const diff = cmp.timerInfoMap.endTime - cmp.timerInfoMap.startTime;

        // does the same job as parseInt truncates the float
        let minutes = (diff / 60) | 0;
        let seconds = (diff % 60) | 0;

        cmp.fieldInfoMap.TimeSpent__c = minutes + (seconds > 0 ? 1 : 0);
    }

    resetTimer(cmp) {
        clearInterval(this.timerIntervalId);

        cmp.timerText = DEFAULT_TIMER_TEXT;
    }

    resetTimerInfo(cmp) {
        cmp.timerInfoMap.startTime = 0;
        cmp.timerInfoMap.endTime = 0;
    }

    saveLogRecord(cmp) {

        saveLog({
            recordJsonString: JSON.stringify(cmp.fieldInfoMap)
        })
            .then((response) => {

                if (response.success) {
                    const data = JSON.parse(response.data);

                    console.log('data', data);

                    Utils.showToast(cmp, 'Your log saved successfully!');
                } else {
                    Utils.handleErrorInResponseFromApex(cmp, response);
                }
            })
            .catch((error) => {
                Utils.handleErrorInResponse(cmp, error);
            })
    }

    showTimer(cmp) {
        cmp.isShowTimer = true;
    }

    hideTimer(cmp) {
        cmp.isShowTimer = false;
    }

    showStartBtn(cmp) {
        cmp.isShowStartBtn = true;
    }

    hideStartBtn(cmp) {
        cmp.isShowStartBtn = false;
    }

    showFinishBtn(cmp) {
        cmp.isShowFinishBtn = true;
    }

    hideFinishBtn(cmp) {
        cmp.isShowFinishBtn = false;
    }

    showSaveBtn(cmp) {
        cmp.isShowSaveBtn = true;
    }

    hideSaveBtn(cmp) {
        cmp.isShowSaveBtn = false;
    }

    showFields(cmp) {
        cmp.isShowFields = true;
    }

    hideFields(cmp) {
        cmp.isShowFields = false;
    }

    activateSaveBtn(cmp) {
        cmp.isDisabledSaveBtn = false;
    }

    disableSaveBtn(cmp) {
        cmp.isDisabledSaveBtn = true;
    }
}