import { LightningElement, wire, api } from "lwc";
import getPropertyList from "@salesforce/apex/PropertyController.getPropertyList";
const Propertyfields = "Adress__c,Cost_Sale__c,Owner__r.Name,Name";
export default class PropertyList extends LightningElement {
  totalProperties;
  visibleRecords;
  error;
  showDetails = false;
  totalPages;
  currentPage = 1;
  selectedProp;
  @api recordsSize = 8;

  @wire(getPropertyList, { fields: Propertyfields })
  wiredProperties({ error, data }) {
    if (data) {
      this.totalProperties = data;
      this.totalPages = Math.ceil(data.length / this.recordsSize);
      this.visibleRecords = this.totalProperties.slice(0, this.recordsSize);
      this.error = undefined;
    }
    if (error) {
      this.error = error;
      console.error(error);
    }
  }

  updateRecords() {
    const start = (this.currentPage - 1) * this.recordSize;
    const end = this.recordsSize * this.currentPage;
    this.visibleRecords = this.totalRecords.slice(start, end);
    console.log("visibleRecords 2 -- " + JSON.stringify(this.visibleRecords));
  }

  openDetails(event) {
    let selectedPropId = event.detail;
    this.selectedProp = this.totalProperties.find(
      (property) => property.Id === selectedPropId
    );
    this.showDetails = true;
  }

  hideDetails() {
    this.showDetails = false;
  }
}
