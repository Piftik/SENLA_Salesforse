import { LightningElement } from "lwc";
import { persons, columns, options } from "c/utils";

export default class PersonsInformation extends LightningElement {
  data = persons;
  columns = columns;
  value = "sortBy";
  options = options;

  optionsGender = [
    { label: "Male", value: "Male", checked: null },
    { label: "Female", value: "Female", checked: null }
  ];

  handleSortBy(event) {
    this.value = event.detail.value;
    const resultSort = JSON.parse(JSON.stringify(this.data)).sort((a, b) =>
      a[event.detail.value].localeCompare(b[event.detail.value])
    );
    this.data = resultSort;
  }

  handleChangeDateFrom(event) {
    const choosedDate = new Date(event.detail.value);
    const resultDateFilter = this.data.filter((item) => {
      return new Date(item.birthday) >= choosedDate;
    });
    this.data = resultDateFilter;
  }

  handleChangeDateTo(event) {
    const choosedDate = new Date(event.detail.value);
    const resultDateToFilter = this.data.filter((item) => {
      return new Date(item.birthday) <= choosedDate;
    });
    this.data = resultDateToFilter;
  }

  handleChangeGender(e) {
    const valueGender = e.target.name;
    if (valueGender === "Male") {
      this.optionsGender[1].checked = 0;
      this.optionsGender[0].checked = 1;
    } else {
      this.optionsGender[0].checked = 0;
      this.optionsGender[1].checked = 1;
    }
    const resultFilterByGender = persons.filter((item) => {
      return item.gender === valueGender;
    });
    this.data = resultFilterByGender;
  }

  handleChangeEmail(event) {
    const resultFilterByEmail = persons.filter((item) => {
      return item.email
        .toLowerCase()
        .includes(event.target.value.toLowerCase());
    });
    this.data = resultFilterByEmail;
  }

  handleReset() {
    this.value = "";
    this.template.querySelectorAll("lightning-input").forEach((element) => {
      if (element.type === "checkbox") {
        element.checked = false;
      } else {
        element.value = null;
      }
      this.data = persons;
    });
  }
}
