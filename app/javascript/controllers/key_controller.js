import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';


// Connects to data-controller="key"
export default class extends Controller {

  static targets = ["key", "show", "copy"];

  connect() {
    console.log('Connected key controller');
  }
  copy() {
    const keyElement = this.keyTarget;
    const key = keyElement.getAttribute("data-key");
    navigator.clipboard.writeText(key).then(() => {
      swal('Copied to clipboard')
    }).catch((error) => {
      console.error('Failed to copy to clipboard', error);
    });
  }
  toggle() {
    console.log('toggling')
    const keyElement = this.keyTarget;
    const showElement = this.showTarget;
    const isHidden = keyElement.getAttribute("data-key-attribute") === "hidden";
    const key = keyElement.getAttribute("data-key");
    const hidden = keyElement.getAttribute("data-hidden");
    console.log(key)

    if (isHidden) {

      // Replace 'your_key_value' with the actual key value or fetch it dynamically
      keyElement.textContent = key
      keyElement.setAttribute("data-key-attribute", "visible");
      showElement.className = showElement.className.replace('fa-eye-slash', 'fa-eye')
    } else {
      keyElement.textContent = hidden;
      keyElement.setAttribute("data-key-attribute", "hidden");
      showElement.className = showElement.className.replace('fa-eye', 'fa-eye-slash')

    }
  }
}
