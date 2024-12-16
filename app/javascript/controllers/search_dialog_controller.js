import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dialog"];

  connect() {
    console.log("Connected search dialog");
  }

  open() {
    this.dialogTarget.showModal();
  }

  close() {
    this.dialogTarget.close();
  }

  closeOnSubmit(event) {
    // Close dialog after form submission
    this.close();
    // Reset the form
  }
}
