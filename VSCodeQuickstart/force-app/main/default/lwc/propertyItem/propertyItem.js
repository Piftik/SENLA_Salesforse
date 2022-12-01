import { api, LightningElement } from "lwc";

export default class PropertyItem extends LightningElement {
  @api
  property;

  hendleSelect() {
    const event = new CustomEvent("selectedItem", {
      detail: this.property
    });
    this.dispatchEvent(event);
  }
}