import { LightningElement, api } from "lwc";

export default class PropertyCreation extends LightningElement {
  @api recordId;

  @api objectApiName;

  isTypesCurrentPage = true;
  propertyType;

  @api
  next(event) {
    this.isTypesCurrentPage = event.detail.isTypesPageCurrent;
    this.propertyType = event.detail.propertyType;
  }
}
