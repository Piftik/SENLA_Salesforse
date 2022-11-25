import { LightningElement, api } from "lwc";

export default class Pagination extends LightningElement {
  currentPage = 1;

  @api
  totalPages = 0;

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
        new CustomEvent("updatepagerecords", { detail: this.currentPage })
      );
    }
  }

  nextHandler() {
    if (this.currentPage < this.totalPage) {
      console.log("total page paginator -" + this.totalPage);
      this.currentPage += 1;
      this.dispatchEvent(
        new CustomEvent("updatepagerecords", { detail: this.currentPage })
      );
    }
  }
}
