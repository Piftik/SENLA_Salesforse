import { ShowToastEvent } from "lightning/platformShowToastEvent";
import PROPERTY_OBJECT from "@salesforce/schema/Property_New__c";

import PROPERTY_ID from "@salesforce/schema/Property_New__c.id";
import PROPERTY_ADDRESS from "@salesforce/schema/Property_New__c.Address__c";
import PROPERTY_COST from "@salesforce/schema/Property_New__c.Cost_Sale__c";
import PROPERTY_NAME from "@salesforce/schema/Property_New__c.Name";
import PROPERTY_OWNER_NAME from "@salesforce/schema/Property_New__c.Property_Owner__r.Name";
import PROPERTY_PICTURE from "@salesforce/schema/Property_New__c.Picture__c";

const SUCCESS_TITLE = "Succes submit";
const SUCCESS_VARIANT = "succes";
const ERROR_TITLE = "Error submit";
const ERROR_VARIANT = "error";

import DATE_CREATED from "@salesforce/schema/LogLWC__c.CreatedDate";
import OBJECT_TYPE from "@salesforce/schema/LogLWC__c.ObjectType__c";
import ACTION_TYPE from "@salesforce/schema/LogLWC__c.ActionType__c";
import DESCRIPTION from "@salesforce/schema/LogLWC__c.Description__c";
import IS_SUCCESSFUL from "@salesforce/schema/LogLWC__c.IsSuccessful__c";
import ERROR_MESSAGE from "@salesforce/schema/LogLWC__c.ErrorMessage__c";

const PROPERTY_FIELDS = [
  PROPERTY_ID.fieldApiName,
  PROPERTY_NAME.fieldApiName,
  PROPERTY_ADDRESS.fieldApiName,
  PROPERTY_OWNER_NAME.fieldApiName,
  PROPERTY_COST.fieldApiName,
  PROPERTY_PICTURE.fieldApiName
];

const LOG_LWC_FIELDS=[
  DATE_CREATED.fieldApiName,
  OBJECT_TYPE.fieldApiName,
  ACTION_TYPE.fieldApiName,
  DESCRIPTION.fieldApiName,
  IS_SUCCESSFUL.fieldApiName,
  ERROR_MESSAGE.fieldApiName,
]
const LOG_LWC_TABLE_COLUMNS = [
  {
    label: "Created date",
    fieldName: DATE_CREATED.fieldApiName,
    type: "date",
    sortable: true
  },
  { label: "Type object", fieldName: OBJECT_TYPE.fieldApiName, type: "text" },
  { label: "Type action", fieldName: ACTION_TYPE.fieldApiName, type: "text" },
  { label: "Description", fieldName: DESCRIPTION.fieldApiName, type: "text" },
  { label: "Successful", fieldName: IS_SUCCESSFUL.fieldApiName, type: "text" },
  { label: "Error", fieldName: ERROR_MESSAGE.fieldApiName, type: "text" }
];

const showNatification = (title, message, variant) => {
  const toastEvent = new ShowToastEvent({
    title,
    message,
    variant
  });
  dispatchEvent(toastEvent);
};
const persons = [
  {
    id: 1,
    firstName: "Olga",
    lastName: "Ivanova",
    gender: "Female",
    birthday: new Date(2000, 1, 1),
    email: "ivanova@salesforce.com"
  },
  {
    id: 2,
    firstName: "Slava",
    lastName: "Petrov",
    gender: "Male",
    birthday: new Date(2002, 2, 2),
    email: "petrov@salesforce.com"
  },
  {
    id: 3,
    firstName: "Petr",
    lastName: "Sidorov",
    gender: "Male",
    birthday: new Date(2003, 3, 3),
    email: "sidorov@salesforce.com"
  },
  {
    id: 4,
    firstName: "Darya",
    lastName: "Zdarova",
    gender: "Female",
    birthday: new Date(2004, 4, 4),
    email: "zdarova@salesforce.com"
  },
  {
    id: 5,
    firstName: "Kostia",
    lastName: "Frolov",
    gender: "Male",
    birthday: new Date(2000, 5, 5),
    email: "frolov@salesforce.com"
  },
  {
    id: 6,
    firstName: "Eva",
    lastName: "Koroleva",
    gender: "Female",
    birthday: new Date(2001, 6, 6),
    email: "koroleva@salesforce.com"
  },
  {
    id: 7,
    firstName: "Tania",
    lastName: "Boldina",
    gender: "Female",
    birthday: new Date(2002, 7, 7),
    email: "boldina@salesforce.com"
  },
  {
    id: 8,
    firstName: "Katia",
    lastName: "Sorokina",
    gender: "Female",
    birthday: new Date(2003, 8, 8),
    email: "sorokina@salesforce.com"
  },
  {
    id: 9,
    firstName: "Igor",
    lastName: "Seilov",
    gender: "Male",
    birthday: new Date(2000, 9, 9),
    email: "seilov@salesforce.com"
  },
  {
    id: 10,
    firstName: "Liuda",
    lastName: "Kaluta",
    gender: "Female",
    birthday: new Date(2001, 10, 10),
    email: "kaluta@salesforce.com"
  }
];
const columns = [
  { label: "FirstName", fieldName: "firstName" },
  { label: "LastName", fieldName: "lastName" },
  { label: "Gender", fieldName: "gender" },
  { label: "Birthday", fieldName: "birthday", type: "date" },
  { label: "Email", fieldName: "email", type: "email" }
];
const options = [
  { value: "firstName", label: "FirstName" },
  { value: "lastName", label: "LastName" },
  { value: "email", label: "Email" }
];

export {
  persons,
  columns,
  options,
  PROPERTY_OBJECT,
  LOG_LWC_FIELDS,
  PROPERTY_FIELDS,
  SUCCESS_TITLE,
  SUCCESS_VARIANT,
  ERROR_TITLE,
  ERROR_VARIANT,
  LOG_LWC_TABLE_COLUMNS,
  showNatification
};
