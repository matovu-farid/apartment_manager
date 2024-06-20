import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="number-field"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.inputTarget.addEventListener('input', this.validate.bind(this));
  }

  /**
    * Validates the input value and sets it to the max value if it exceeds it.
    * @param {Event} Event
    * @return {void}
    */
  validate(event) {
    const max = parseFloat(this.inputTarget.dataset.max);
    if (parseFloat(this.inputTarget.value) > max) {
      this.inputTarget.value = max;
    }
  }
}
