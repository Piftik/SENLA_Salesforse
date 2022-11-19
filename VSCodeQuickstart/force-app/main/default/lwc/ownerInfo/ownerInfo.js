import { LightningElement, wire, api } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

import PROPERTY_ID from "@salesforce/schema/Property_New__c.Id";
import PROPERTY_CONTACT from "@salesforce/schema/Property_New__c.Property_Owner__c";

export default class PropertyOwner extends NavigationMixin(LightningElement) {
  @api recordId;

  @wire(getRecord, {
    recordId: "$recordId",
    fields: [PROPERTY_ID, PROPERTY_CONTACT]
  })
  property;

  get owner() {
    return getFieldValue(this.property.data, PROPERTY_CONTACT);
  }

  navigateToOwnerPage(event) {
    event.preventDefault();
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.owner,
        actionName: "view",
        objectApiName: "Contact__c"
      }
    });
  }
}
