import { LightningElement, api } from "lwc";

export default class PropertyCreation extends LightningElement {
  @api recordId;

  @api objectApiName;

  isPropertyTypeSubmitted = false;
  propertyType;

  handleTypeSubmit(event) {
    this.isPropertyTypeSubmitted = event.detail.isPropertyTypeSubmitted;
    this.propertyType = event.detail.propertyType;
  }
}
