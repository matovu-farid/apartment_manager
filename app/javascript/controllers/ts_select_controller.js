import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";
import "tom-select/dist/css/tom-select.bootstrap5.css";

export default class extends Controller {
  connect() {
    console.log("in ts controller");
    new TomSelect(this.element, {
      create: true,
      sortField: {
        field: "text",
        direction: "asc",
      },
      placeholder: "Select or type a category",
    });
  }
}
