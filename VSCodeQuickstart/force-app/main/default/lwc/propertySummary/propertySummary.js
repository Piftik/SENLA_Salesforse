import { LightningElement, api, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

import {
  subscribe,
  unsubscribe,
  MessageContext
} from "lightning/messageService";
import PROPERTYSELECTEDMC from "@salesforce/messageChannel/PropertySelected__c";
import NAME_FIELD from "@salesforce/schema/Property_New__c.Name";
import PROPERTY_ADDRESS from "@salesforce/schema/Property_New__c.Address__c";
import PROPERTY_COST from "@salesforce/schema/Property_New__c.Cost_Sale__c";
import PROPERTY_NAME from "@salesforce/schema/Property_New__c.Name";
import PROPERTY_OWNER_NAME from "@salesforce/schema/Property_New__c.Property_Owner__r.Name";
import PROPERTY_PICTURE from "@salesforce/schema/Property_New__c.Picture__c";

export default class PropertySummary extends LightningElement {
  propertyId;
  propertyFields = [
    PROPERTY_ADDRESS,
    PROPERTY_COST,
    PROPERTY_NAME,
    PROPERTY_OWNER_NAME,
    PROPERTY_PICTURE
  ];
  subscription = null;

  @wire(MessageContext)
  messageContext;

  @wire(getRecord, {
    recordId: "$propertyId",
    fields: [NAME_FIELD, PROPERTY_PICTURE]
  })
  property;

  @api
  get recordId() {
    return this.propertyId;
  }

  set recordId(propertyId) {
    this.propertyId = propertyId;
  }

  get propertyName() {
    return getFieldValue(this.property.data, NAME_FIELD);
  }

  get pictureURL() {
    return getFieldValue(this.property.data, PROPERTY_PICTURE);
  }

  connectedCallback() {
    this.subscription = subscribe(
      this.messageContext,
      PROPERTYSELECTEDMC,
      (message) => {
        this.handlePropertySelected(message);
      }
    );
  }

  disconnectedCallback() {
    unsubscribe(this.subscription);
    this.subscription = null;
  }

  handlePropertySelected(message) {
    this.propertyId = message.propertyId;
  }
}
