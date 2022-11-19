import { ShowToastEvent } from "lightning/platformShowToastEvent";

const SUCCESS_TITLE = "Succes submit";
const SUCCESS_VARIANT = "succes";
const ERROR_TITLE = "Error submit";
const ERROR_VARIANT = "error";

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
  SUCCESS_TITLE,
  SUCCESS_VARIANT,
  ERROR_TITLE,
  ERROR_VARIANT,
  showNatification
};
