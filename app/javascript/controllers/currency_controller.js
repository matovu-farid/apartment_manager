
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["currency"]

  connect() {
    console.log('Connected currency');
    const currency = 'UGX' // https://www.currency-iso.org/dam/downloads/lists/list_one.xml

    // format inital value
    onBlur({ target: this.currencyTarget })

    // bind event listeners
    this.currencyTarget.addEventListener('focus', onFocus)
    this.currencyTarget.addEventListener('blur', onBlur)


    function localStringToNumber(s) {
      const stripped = String(s).replace(/[^0-9.]+/g, "")
      console.log({ stripped })
      return Number(stripped)
    }

    function onFocus(e) {
      const value = e.target.value;
      e.target.value = value ? localStringToNumber(value) : ''
    }

    function onBlur(e) {
      const value = e.target.value

      const options = {
        maximumFractionDigits: 2,
        currency: currency,
        style: "currency",
        currencyDisplay: "symbol"
      }

      e.target.value = (value || value === 0)
        ? localStringToNumber(value).toLocaleString(undefined, options)
        : ''
    }
  }




}
