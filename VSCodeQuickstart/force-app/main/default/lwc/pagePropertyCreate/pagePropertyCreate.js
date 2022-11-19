import { LightningElement, api, track } from "lwc";
import PROPERTY_OBJECT from "@salesforce/schema/Property_New__c";
import {
  SUCCESS_TITLE,
  SUCCESS_VARIANT,
  ERROR_TITLE,
  ERROR_VARIANT,
  showNatification
} from "c/utils";

export default class PagePropertyCreate extends LightningElement {
  @api recordId;
  @api propertyObject = PROPERTY_OBJECT;
  keyIndex = 0;

  @track rows = [{ id: 0 }];

  handleSubmit() {
    let isVal = true;
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
      }
    }
  }
  handleCancel() {
    this.keyIndex = 0;
    this.elements = [{ id: 0 }];

    this.dispatchEvent(
      new CustomEvent("typesubmit", {
        detail: {
          isPropertyTypeSubmitted: false
        }
      })
    );
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
}
