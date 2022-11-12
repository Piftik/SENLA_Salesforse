import { LightningElement, api } from "lwc";

const persons = [
  {
    id: 1,
    firstName: "Olga",
    lastName: "Ivanova",
    gender: "F",
    birthday: new Date(2000, 1, 1),
    email: "ivanova@salesforce.com"
  },
  {
    id: 2,
    firstName: "Slava",
    lastName: "Petrov",
    gender: "M",
    birthday: new Date(2002, 2, 2),
    email: "petrov@salesforce.com"
  },
  {
    id: 3,
    firstName: "Petr",
    lastName: "Sidorov",
    gender: "M",
    birthday: new Date(2003, 3, 3),
    email: "sidorov@salesforce.com"
  },
  {
    id: 4,
    firstName: "Darya",
    lastName: "Zdarova",
    gender: "F",
    birthday: new Date(2004, 4, 4),
    email: "zdarova@salesforce.com"
  },
  {
    id: 5,
    firstName: "Kostia",
    lastName: "Frolov",
    gender: "M",
    birthday: new Date(2000, 5, 5),
    email: "frolov@salesforce.com"
  },
  {
    id: 6,
    firstName: "Eva",
    lastName: "Koroleva",
    gender: "F",
    birthday: new Date(2001, 6, 6),
    email: "koroleva@salesforce.com"
  },
  {
    id: 7,
    firstName: "Tania",
    lastName: "Boldina",
    gender: "F",
    birthday: new Date(2002, 7, 7),
    email: "boldina@salesforce.com"
  },
  {
    id: 8,
    firstName: "Katia",
    lastName: "Sorokina",
    gender: "F",
    birthday: new Date(2003, 8, 8),
    email: "sorokina@salesforce.com"
  },
  {
    id: 9,
    firstName: "Igor",
    lastName: "Seilov",
    gender: "M",
    birthday: new Date(2000, 9, 9),
    email: "seilov@salesforce.com"
  },
  {
    id: 10,
    firstName: "Liuda",
    lastName: "Kaluta",
    gender: "F",
    birthday: new Date(2001, 10, 10),
    email: "kaluta@salesforce.com"
  }
];
const columns = [
  { label: "Firstname", fieldName: "firstName" },
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

export default class PersonsInformation extends LightningElement {
  data = [...persons];
  columns = columns;
  options = options;
  value = "sortBy";
  filterGender = "";
  dateRange = ["", ""];
  @api
  handleChange(event) {
    this.value = event.detail.value;
    const result = JSON.parse(JSON.stringify(this.persons)).sort((a, b) =>
      a[event.detail.value].localeCompare(b[event.detail.value])
    );
    this.data = result;
  }
  @api
  handleChangeFrom(event) {
    const choosedDate = new Date(event.detail.value);
    const result = this.persons.filter((item) => {
      return new Date(item.birthday) >= choosedDate;
    });
    this.persons = result;
  }
  @api
  handleChangeTo(event) {
    const choosedDate = new Date(event.detail.value);
    const result = this.data.filter((item) => {
      return new Date(item.birthday) <= choosedDate;
    });
    this.data = result;
  }
  @api
  handleGenderFilter(event) {
    this.filterGender = "";
    Array.from(this.template.querySelectorAll('[data-id="checkbox"]')).forEach(
      (element) => {
        if (element === event.target && element.checked) {
          this.filterGender = element.name;
        } else element.checked = false;
      }
    );
    let records = [];
    if (this.filterGender !== "") {
      for (let record of this.data) {
        if (record.gender === this.filterGender) {
          records.push(record);
        }
      }
      this.data = records;
    } else this.checkGenders();
  }
  @api
  handleChangeEmail(event) {
    const result = persons.filter((item) => {
      return item.email
        .toLowerCase()
        .includes(event.target.value.toLowerCase());
    });
    this.data = result;
  }
  @api
  handleReset() {
    this.data = [...persons];
    this.filterGender = "";
    this.dateRange = ["", ""];
    this.value = "";

    this.template.querySelector('[data-id="sortByBox"]').value = "";
    this.template.querySelector('[data-id="fromSort"]').value = "";
    this.template.querySelector('[data-id="toSort"]').value = "";
    this.template.querySelector('[data-id="emailInput"]').value = "";
    Array.from(
      this.template.querySelectorAll('[data-id = "checkbox"]')
    ).forEach((element) => {
      element.checked = false;
    });
  }

  checkGenders() {
    const male = this.data.find((person) => person.gender === "M");
    const female = this.data.find((person) => person.gender === "F");
    let checkboxes = Array.from(
      this.template.querySelectorAll('[data-id="checkbox"]')
    );
    checkboxes.forEach((element) => (element.disabled = false));

    if (male === undefined) {
      let element = checkboxes.find((element) => element.name === "M");
      element.disabled = true;
    }

    if (female === undefined) {
      let element = checkboxes.find((element) => element.name === "F");
      element.disabled = true;
    }
  }
}
