
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["payment"]

  connect() {
    console.log('Connected');
    this.paymentTarget.addEventListener('input', this.validate.bind(this));
  }

  log() {
    console.log('Logging');
  }

  /**
    * Validates the input value and sets it to the max value if it exceeds it.
    * @param {Event} Event
    * @return {void}
    */
  validate(event) {
    console.log('Event', event);
    const max = parseFloat(this.paymentTarget.dataset.max);
    console.log('Max', max);
    if (parseFloat(this.paymentTarget.value) > max) {
      this.paymentTarget.value = max;
    }
  }
}
