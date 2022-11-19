import { LightningElement, wire } from "lwc";
import { getObjectInfo } from "lightning/uiObjectInfoApi";

import PROPERTY_OBJECT from "@salesforce/schema/Property_New__c";

export default class PropertyRecordType extends LightningElement {
  checkedValue = "";

  @wire(getObjectInfo, { objectApiName: PROPERTY_OBJECT })
  objectInfo;

  get recordTypes() {
    const recordsTypeArray = [];
    const recordTypes = this.objectInfo.data.recordTypeInfos;
    Object.keys(recordTypes).forEach((element) => {
      recordsTypeArray.push({
        name: recordTypes[element].name,
        value: recordTypes[element].recordTypeId,
        checked: false
      });
    });
    recordsTypeArray[0].checked = true;
    this.checkedValue = recordsTypeArray[0].value;
    return recordsTypeArray;
  }

  checkHandle(event) {
    Array.from(
      this.template.querySelectorAll('[data-id="record_type_checkbox"]')
    ).forEach((element) => {
      element.checked = false;
    });
    event.target.checked = true;
    this.checkedValue = event.target.name;
  }

  submitType(event) {
    this.dispatchEvent(
      new CustomEvent("typesubmit", {
        detail: {
          isPropertyTypeSubmitted: true,
          propertyType: this.propertyType
        }
      })
    );
  }
}
