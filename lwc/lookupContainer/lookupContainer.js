/* eslint-disable no-console */
import { LightningElement } from 'lwc';

export default class LookupContainer extends LightningElement {
    utilLookupConfig = {
        label: "Label for Lookup :)"
    }

    handleSelectedRecord(event) {
        console.log(JSON.parse(JSON.stringify(event.detail)));
    }
}