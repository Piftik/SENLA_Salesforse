import { LightningElement, api, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

import FIRST_NAME_FIELD from "@salesforce/schema/Prorerty_New__c.Property_Owner__r.FirstName";
import LAST_NAME_FIELD from "@salesforce/schema/Prorerty_New__c.Property_Owner__r.LastName";
import PHONE_FIELD from "@salesforce/schema/Prorerty_New__c.Property_Owner__r.Phone";
import HOME_PHONE_FIELD from "@salesforce/schema/Prorerty_New__c.Property_Owner__r.HomePhone";
import EMAIL_FIELD from "@salesforce/schema/Property_New__c.Property_Owner__r.Email";
import TOTAL_PRICE_FIELD from "@salesforce/schema/Prorerty_New__c.Property_Owner__r.Total_Property_price__c";

import PROPERTY_ID from "@salesforce/schema/Property_New__c.Id";
import PROPERTY_OWNER from "@salesforce/schema/Property_New__c.Property_Owner__r.Id";

const fields = [
  FIRST_NAME_FIELD,
  LAST_NAME_FIELD,
  PHONE_FIELD,
  HOME_PHONE_FIELD,
  EMAIL_FIELD,
  TOTAL_PRICE_FIELD
];

export default class ProrertyOwnerCard extends LightningElement {
  @api recordId;

  @wire(getRecord, {
    recordId: "$recordId",
    fields: [PROPERTY_ID, PROPERTY_OWNER]
  })
  property;

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

  get propertyOwnerId() {
    return getFieldValue(this.property.data, PROPERTY_OWNER);
  }

  navigateToViewContactPage() {
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.ownerId,
        objectApiName: "Contact",
        actionName: "view"
      }
    });
  }
}
