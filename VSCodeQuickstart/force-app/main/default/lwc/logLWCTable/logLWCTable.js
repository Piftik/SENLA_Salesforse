import { LightningElement, wire } from "lwc";
import logs from "@salesforce/apex/LogLWCController.getLogsLWC";
import { LOG_LWC_TABLE_COLUMNS, LOG_LWC_FIELDS } from "c/utils";

export default class LogLWCTable extends LightningElement {
  columns = LOG_LWC_TABLE_COLUMNS;
  defaultSortDirection = "desc";
  sortDirection = "desc";
  @wire(logs, { fields: LOG_LWC_FIELDS.join(", ") })
  logs;
}
