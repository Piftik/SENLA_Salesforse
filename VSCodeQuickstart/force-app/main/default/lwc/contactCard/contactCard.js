import { LightningElement, api, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

import FIRST_NAME_FIELD from "@salesforce/schema/Property_New__c.Property_Owner__r.FirstName";
import LAST_NAME_FIELD from "@salesforce/schema/Property_New__c.Property_Owner__r.LastName";
import PHONE_FIELD from "@salesforce/schema/Property_New__c.Property_Owner__r.Phone";
import HOME_PHONE_FIELD from "@salesforce/schema/Property_New__c.Property_Owner__r.HomePhone";
import EMAIL_FIELD from "@salesforce/schema/Property_New__c.Property_Owner__r.Email";
import TOTAL_PRICE_FIELD from "@salesforce/schema/Property_New__c.Property_Owner__r.Total_Property_price__c";
import PROPERTY_OWNER from "@salesforce/schema/Property_New__c.Property_Owner__c";
import PROPERTY from "@salesforce/schema/Property_New__c.Property_Owner__r.id";

const fields = [
  FIRST_NAME_FIELD,
  LAST_NAME_FIELD,
  PHONE_FIELD,
  HOME_PHONE_FIELD,
  EMAIL_FIELD,
  TOTAL_PRICE_FIELD,
  PROPERTY_OWNER,
  PROPERTY
];

export default class ProrertyOwnerCard extends NavigationMixin(
  LightningElement
) {
  @api recordId;

  @wire(getRecord, { recordId: "$recordId", fields })
  owner;

  get firstName() {
    return getFieldValue(this.owner.data, FIRST_NAME_FIELD);
  }

  get lastName() {
    return getFieldValue(this.owner.data, LAST_NAME_FIELD);
  }
  get phone() {
    return getFieldValue(this.owner.data, PHONE_FIELD);
  }
  get homePhone() {
    return getFieldValue(this.owner.data, HOME_PHONE_FIELD);
  }

  get email() {
    return getFieldValue(this.owner.data, EMAIL_FIELD);
  }

  get total() {
    return getFieldValue(this.owner.data, TOTAL_PRICE_FIELD);
  }
  get ownerContact() {
    return getFieldValue(this.owner.data, PROPERTY_OWNER);
  }

  navigateToViewContactPage() {
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.ownerContact,
        objectApiName: "Contact",
        actionName: "view"
      }
    });
  }
}
