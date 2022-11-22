import { LightningElement, wire, track } from "lwc";
import getLogsLWC from "@salesforce/apex/LogLWCController.getLogsLWC";
import { LOG_LWC_TABLE_COLUMNS, LOG_LWC_TABLE_FIELDS } from "c/utils";

export default class LogLWCTable extends LightningElement {
  columns = LOG_LWC_TABLE_COLUMNS;
  rowOffset = 0;

  @track data = [];

  @wire(getLogsLWC, { fields: LOG_LWC_TABLE_FIELDS })
  logsList({ error, data }) {
    if (data) {
      this.data = this.sortByDesc(data);
    } else if (error) {
      this.data = [];
    }
  }

  sortByDesc(data) {
    let parseData = JSON.parse(JSON.stringify(data));
    return parseData.sort((a, b) =>
      new Date(a.CreatedDate) > new Date(b.CreatedDate) ? -1 : 1
    );
  }
}
