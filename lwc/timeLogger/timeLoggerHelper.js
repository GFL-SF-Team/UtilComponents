import Utils from './timeLoggerUtils';
import saveLog from '@salesforce/apex/TimeLoggerController.saveLog';

export default new class TimeLoggerHelper {

    timerIntervalId;

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

            cmp.timeSpent = `${minutes}m ${seconds}s`;

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

        cmp.timeSpent = '00m 00s';
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