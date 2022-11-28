import { LightningElement, wire } from "lwc";
import getPropertyList from "@salesforce/apex/PropertyController.getPropertyList";
const Propertyfields = "Adress__c,Cost_Sale__c,Owner__r.Name,Name";
export default class PropertyList extends LightningElement {
  totalProperties;
  visibleProperty;
  error;
  showDetails = false;
  selectedProp;

  @wire(getPropertyList, { fields: Propertyfields })
  wiredProperties({ error, data }) {
    if (data) {
      this.totalProperties = data;
      console.log(
        "total properties ---" + JSON.stringify(this.totalProperties)
      );
    }
    if (error) {
      this.error = error;
      console.error(error);
    }
  }
  updatePropertyHandler(event) {
    console.log("Records from child--" + event.detail.records);
    this.visibleProperty = [...event.detail.records];
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
