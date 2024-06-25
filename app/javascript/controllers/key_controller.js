import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="key"
export default class extends Controller {

  static targets = ["key"];

  connect() {
    console.log('Connected key controller');
  }
  toggle() {
    console.log('toggling')
    const keyElement = this.keyTarget;
    const isHidden = keyElement.getAttribute("data-key-attribute") === "hidden";
    const key = keyElement.getAttribute("data-key");
    const hidden = keyElement.getAttribute("data-hidden");
    console.log(key)

    if (isHidden) {

      // Replace 'your_key_value' with the actual key value or fetch it dynamically
      keyElement.textContent = key
      keyElement.setAttribute("data-key-attribute", "visible");
    } else {
      keyElement.textContent = hidden;
      keyElement.setAttribute("data-key-attribute", "hidden");
    }
  }
}
