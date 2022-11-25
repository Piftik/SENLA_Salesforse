import { api, LightningElement } from "lwc";

export default class PropertyItem extends LightningElement {
  @api
  property;

  hendleSelect(event) {
    event.preventDefault();
    this.dispatchEvent(
      new CustomEvent("selecteItem", {
        detail: { propertyId: event.currentTarget.dataset.propertyId }
      })
    );
  }
}
