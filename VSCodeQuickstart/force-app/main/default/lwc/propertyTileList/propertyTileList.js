import { LightningElement, wire } from "lwc";
import { publish, MessageContext } from "lightning/messageService";

import PROPERTYSELECTEDMC from "@salesforce/messageChannel/PropertySelected__c";
import getPagedPropertyList from "@salesforce/apex/PropertyController.getPagedPropertyList";

const PAGE_SIZE = 8;

export default class PropertyTileList extends LightningElement {
  pageNumber = 1;
  pageSize = PAGE_SIZE;

  @wire(MessageContext)
  messageContext;

  @wire(getPagedPropertyList, {
    pageSize: "$pageSize",
    pageNumber: "$pageNumber"
  })
  properties;

  handlePreviousPage() {
    this.pageNumber = this.pageNumber - 1;
  }

  handleNextPage() {
    this.pageNumber = this.pageNumber + 1;
  }

  handlePropertySelected(event) {
    const message = { propertyId: event.detail };
    publish(this.messageContext, PROPERTYSELECTEDMC, message);
  }
}
