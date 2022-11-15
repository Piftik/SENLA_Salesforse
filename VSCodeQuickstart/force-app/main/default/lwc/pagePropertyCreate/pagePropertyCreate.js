import { LightningElement, api, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import PROPERTY_OBJECT from "@salesforce/schema/Property_New__c";

export default class PagePropertyCreate extends LightningElement {
  @api recordId;
  @api propertyObject = PROPERTY_OBJECT;
  @track rows = [{ uuid: this.createUUID() }];

  handleSuccess() {
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Success",
        message: "Records created.",
        variant: "success"
      }) //&&
      // new CustomEvent("next", {
      //   detail: {
      //     isTypesCurrentPage: true
      //   }
      // })
    );
  }

  handleError(error) {
    const toastEvent = new ShowToastEvent({
      title: "Creation error",
      message: error.getMessage(),
      variant: "destructive"
    });
    this.dispatchEvent(toastEvent);
  }

  @api
  handleClose() {
    this.dispatchEvent(
      new CustomEvent("next", {
        detail: {
          isTypesCurrentPage: true
        }
      })
    );
  }

  createUUID() {
    return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(
      /[xy]/g,
      function (c) {
        var r = (Math.random() * 16) | 0,
          v = c === "x" ? r : (r & 0x3) | 0x8;
        return v.toString(16);
      }
    );
  }
  removeRow(event) {
    if (this.rows.length > 1) {
      this.rows.splice(event.target.value, 1);
    }
  }

  addRow() {
    if (this.rows.length === 3) {
      Array.from(
        this.template.querySelectorAll('lightning-button-icon[name="add"]')
      ).forEach((element) => {
        element.disabled = true;
      });
    }
    if (this.rows.length < 3) {
      this.rows.push({ uuid: this.createUUID() });
    }
  }
}
