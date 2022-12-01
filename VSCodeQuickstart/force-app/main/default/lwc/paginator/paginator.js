import { LightningElement, api } from "lwc";

export default class Pagination extends LightningElement {
  @api totalPages = 0;
  currentPage = 1;

  get disablePrevious() {
    return this.currentPage <= 1;
  }
  get disableNext() {
    return this.currentPage >= this.totalPage;
  }

  previousHandler() {
    if (this.currentPage > 1) {
      this.currentPage = this.currentPage - 1;
      this.dispatchEvent(
        new CustomEvent("updaterecords", { detail: this.currentPage })
      );
    }
  }

  nextHandler() {
    if (this.currentPage < this.totalPage) {
      this.currentPage += 1;
      this.dispatchEvent(
        new CustomEvent("updaterecords", { detail: this.currentPage })
      );
    }
  }
}
