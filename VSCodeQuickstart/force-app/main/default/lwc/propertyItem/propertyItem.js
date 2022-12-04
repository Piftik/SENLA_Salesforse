import { api, LightningElement } from "lwc";

export default class PropertyItem extends LightningElement {
  @api
  property;

  handlePropertySelected() {
    const selectedEvent = new CustomEvent("selected", {
      detail: this.property.Id
    });
    this.dispatchEvent(selectedEvent);
  }
}
