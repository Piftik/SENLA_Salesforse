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

export {
  SUCCESS_TITLE,
  SUCCESS_VARIANT,
  ERROR_TITLE,
  ERROR_VARIANT,
  showNatification
};
