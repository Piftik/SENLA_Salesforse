import { LightningElement, wire } from "lwc";
import getPropertyList from "@salesforce/apex/PropertyController.getPropertyList";
import { PROPERTY_FIELDS } from "c/utils";

export default class PropertyList extends LightningElement {
  totalProperties;
  visibleProperty;
  error;
  spinner = true;
  isError = false;
  showDetails = false;
  selectedProperty;
  totalPages;
  currentPage = 1;
  recordsPage = 8;

  @wire(getPropertyList, { fields: PROPERTY_FIELDS.join(", ") })
  wiredProperties({ error, data }) {
    if (data) {
      this.totalProperties = data;
      this.totalPages = Math.ceil(
        this.totalProperties.length / this.recordsPage
      );
      this.visibleProperty = this.totalProperties.slice(0, this.recordsPage);
      this.error = undefined;
      this.spinner = false;
    }
    if (error) {
      this.error = {
        header: "Get properties error",
        message: error.message
      };
      this.isError = true;

      console.error(error);
    }
  }

  updatePropertyHandler(event) {
    this.currentPage = event.detail;
    const start = (this.currentPage - 1) * this.recordsPage;
    const end = this.recordsPage * this.currentPage;
    this.visibleProperty = this.totalProperties.slice(start, end);
  }

  openDetails(event) {
    console.log(event.detail);
    this.selectedProperty = event.detail;
    this.spinner = true;
    this.showDetails = true;
  }

  hideDetails() {
    this.showDetails = false;
    this.spinner = true;
  }
}
