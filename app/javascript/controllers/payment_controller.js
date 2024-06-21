
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["payment", "balance"]

  connect() {
    console.log('Connected');
    this.paymentTarget.addEventListener('input', this.validate.bind(this));
  }

  onEditPayment() {
    this.validate()
    const payment = parseFloat(this.paymentTarget.value);
    const balance = parseFloat(this.balanceTarget.dataset.balance);
    if (!payment) return balance
    const left = balance - payment
    this.balanceTarget.textContent = `UGX ${left}`;
    const max = parseFloat(this.paymentTarget.dataset.max);
    if (parseFloat(this.paymentTarget.value) > max) {
      this.paymentTarget.value = max;
    }
  }

  /**
    * Validates the input value and sets it to the max value if it exceeds it.
    * @param {Event} Event
    * @return {void}
    */
  validate(event) {
    const max = parseFloat(this.paymentTarget.dataset.max);
    if (parseFloat(this.paymentTarget.value) > max) {
      this.paymentTarget.value = max;
    }
  }
}
