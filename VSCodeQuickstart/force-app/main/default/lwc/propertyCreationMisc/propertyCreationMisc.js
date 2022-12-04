import { LightningElement, api, track, wire } from "lwc";
import propertyCreationMisc from "./propertyCreationMisc.html";
import pagePropertyCreate from "./pagePropertyCreate.html";
import PROPERTY_OBJECT from "@salesforce/schema/Property_New__c";
import createLogLWC from "@salesforce/apex/LogLWCController.createLogLWC";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import {
  SUCCESS_TITLE,
  SUCCESS_VARIANT,
  ERROR_TITLE,
  ERROR_VARIANT,
  showNatification
} from "c/utils";

export default class PropertyCreationMisc extends LightningElement {
  showPropertyRecordType = true;

  keyIndex = 0;
  checkedValue = "";

  @track rows = [{ id: 0 }];

  @api recordId;
  @api propertyObject = PROPERTY_OBJECT;

  @wire(getObjectInfo, { objectApiName: PROPERTY_OBJECT })
  objectInfo;

  render() {
    return this.showPropertyRecordType
      ? propertyCreationMisc
      : pagePropertyCreate;
  }

  switchTemplate() {
    this.showPropertyRecordType = !this.showPropertyRecordType;
  }

  handleSubmit() {
    let isVal = true;
    let logDescription = ` ${this.rows.length}  Proprty has been created`;
    let errorMessage = "";
    this.template
      .querySelectorAll("lightning-input-field")
      .forEach((element) => {
        isVal = isVal && element.reportValidity();
      });
    if (isVal) {
      try {
        this.template
          .querySelectorAll("lightning-record-edit-form")
          .forEach((element) => {
            element.submit();
          });

        this.displaySuccess();
        this.handleCancel();
      } catch (error) {
        this.displayError(error);
      } finally {
        this.createLog("Insert", logDescription, errorMessage);
      }
    }
  }
  handleCancel() {
    this.keyIndex = 0;
    this.elements = [{ id: 0 }];

    this.switchTemplate();
  }

  displaySuccess() {
    showNatification(SUCCESS_TITLE, "create property", SUCCESS_VARIANT);
  }

  displayError(error) {
    showNatification(ERROR_TITLE, error.getMessage(), ERROR_VARIANT);
  }

  addRow() {
    if (this.rows.length < 3) {
      ++this.keyIndex;
      let newElement = { id: this.keyIndex };
      this.rows.push(newElement);

      if (this.rows.length === 2) {
        Array.from(
          this.template.querySelectorAll('lightning-button-icon[name="delete"]')
        ).forEach((element) => {
          element.disabled = false;
        });
      }

      if (this.rows.length === 3) {
        Array.from(
          this.template.querySelectorAll('lightning-button-icon[name="add"]')
        ).forEach((element) => {
          element.disabled = true;
        });
      }
    }
  }

  deleteRow(event) {
    if (this.rows.length > 1) {
      this.rows = this.rows.filter(function (element) {
        return element.id !== parseInt(event.target.accessKey, 10);
      });

      if (this.rows.length === 1) {
        this.template.querySelector(
          'lightning-button-icon[name="delete"]'
        ).disabled = true;
      }

      if (this.rows.length === 2) {
        Array.from(
          this.template.querySelectorAll('lightning-button-icon[name="add"]')
        ).forEach((element) => {
          element.disabled = false;
        });
      }
    }
  }

  get recordTypes() {
    const recordsTypeArray = [];
    const recordTypes = this.objectInfo.data.recordTypeInfos;
    Object.keys(recordTypes).forEach((element) => {
      recordsTypeArray.push({
        name: recordTypes[element].name,
        value: recordTypes[element].recordTypeId,
        checked: false
      });
    });
    recordsTypeArray[0].checked = true;
    this.checkedValue = recordsTypeArray[0].value;
    return recordsTypeArray;
  }

  checkHandle(event) {
    Array.from(
      this.template.querySelectorAll('[data-id="record_type_checkbox"]')
    ).forEach((element) => {
      element.checked = false;
    });
    event.target.checked = true;
    this.checkedValue = event.target.name;
  }

  submitType() {
    this.switchTemplate();
  }

  createLog(actionType, logDescription, errorMessage) {
    createLogLWC({
      logObjectType: PROPERTY_OBJECT.objectApiName,
      logActionType: actionType,
      logDescription: logDescription,
      logErrorMessage: errorMessage
    });
  }
}
