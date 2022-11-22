import { LightningElement, wire } from "lwc";
import logs from "@salesforce/apex/LogLWCController.getLogsLWC";
import { LOG_LWC_TABLE_COLUMNS } from "c/utils";

const fields =
  "CreatedDate, ObjectType__c, ActionType__c, Description__c, IsSuccessful__c, ErrorMessage__c";

export default class LogLWCTable extends LightningElement {
  columns = LOG_LWC_TABLE_COLUMNS;
  defaultSortDirection = "desc";
  sortDirection = "desc";
  @wire(logs, { fields: fields })
  logs;
}
