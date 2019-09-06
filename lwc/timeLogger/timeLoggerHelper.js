import Utils from './timeLoggerUtils';
import saveLog from '@salesforce/apex/TimeLoggerController.saveLog';
import { DEFAULT_TIMER_TEMPLATE } from './timeLoggerConstants';

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

        if (timeLoggerCacheMap && timeLoggerCacheMap.cmpStateInfoMap && timeLoggerCacheMap.timerInfoMap) {

            if (timeLoggerCacheMap.cmpStateInfoMap.isInitialState && !cmp.cmpStateInfoMap.isInitialState) {
                this.updateCmpDataFromCache(cmp, timeLoggerCacheMap);
                this.setCmpStateToInitial(cmp);
            }

            if (timeLoggerCacheMap.cmpStateInfoMap.isTimerState && !cmp.cmpStateInfoMap.isTimerState) {
                this.updateCmpDataFromCache(cmp, timeLoggerCacheMap);
                this.setCmpStateToTimer(cmp);
            }

            if (timeLoggerCacheMap.cmpStateInfoMap.isRecordSaveState && !cmp.cmpStateInfoMap.isRecordSaveState) {
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
        this.resetTimer(cmp);
        this.resetTimerInfo(cmp);
        this.setCmpViewStateToInitial(cmp);
        this.changeCmpStateInfo(cmp, { isInitialState: true });
        this.updateTimeLoggerCache(cmp);
    }


    setCmpStateToTimer(cmp) {
        this.startTimer(cmp);
        this.setCmpViewStateToTimer(cmp);
        this.changeCmpStateInfo(cmp, { isTimerState: true });
        this.updateTimeLoggerCache(cmp);
    }

    setCmpStateToSaveRecord(cmp) {
        this.calculateMinutesSpent(cmp);
        this.resetTimer(cmp);
        this.setCmpViewStateToSaveRecord(cmp);
        this.changeCmpStateInfo(cmp, { isRecordSaveState: true });
        this.updateTimeLoggerCache(cmp);
    }

    setCmpViewStateToInitial(cmp) {
        this.resetCmpElementViewState(cmp);
        this.showTimer(cmp);
        this.showStartBtn(cmp);
        this.disableSaveBtn(cmp);
    }

    setCmpViewStateToTimer(cmp) {
        this.resetCmpElementViewState(cmp);
        this.showTimer(cmp);
        this.showFinishBtn(cmp);
    }

    setCmpViewStateToSaveRecord(cmp) {
        this.resetCmpElementViewState(cmp);
        this.showFields(cmp);
        this.showSaveBtn(cmp);
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
        let cacheInUtf8String = 'false';
        const timeLoggerCacheJSON = localStorage.getItem('time_logger_cache');

        if (timeLoggerCacheJSON) {
            cacheInUtf8String = this.b64_to_utf8(timeLoggerCacheJSON);
        }

        return JSON.parse(cacheInUtf8String);
    }

    updateTimeLoggerCache(cmp) {
        const timeLoggerCacheMap = {
            timerInfoMap: cmp.timerInfoMap,
            cmpStateInfoMap: cmp.cmpStateInfoMap
        }

        const cacheInBase64String = this.utf8_to_b64(JSON.stringify(timeLoggerCacheMap));

        localStorage.setItem('time_logger_cache', cacheInBase64String);
    }

    utf8_to_b64(str) {
        return window.btoa(unescape(encodeURIComponent(str)));
    }

    b64_to_utf8(str) {
        return decodeURIComponent(escape(window.atob(str)));
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

            this.setTimerText(cmp, minutes, seconds);
        }, 1000);
    }

    timeNumberFormat(number) {
        return number < 10 ? '0' + number : '' + number;
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

        this.setDefaultTimerText(cmp);
    }

    setDefaultTimerText(cmp) {
        cmp.timerText = DEFAULT_TIMER_TEMPLATE;
        cmp.timerText = cmp.timerText.replace('%MM%', '00');
        cmp.timerText = cmp.timerText.replace('%SS%', '00');
    }

    setTimerText(cmp, minutes, seconds) {
        cmp.timerText = DEFAULT_TIMER_TEMPLATE;

        minutes = this.timeNumberFormat(minutes);
        seconds = this.timeNumberFormat(seconds);

        cmp.timerText = cmp.timerText.replace('%MM%', minutes);
        cmp.timerText = cmp.timerText.replace('%SS%', seconds);
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