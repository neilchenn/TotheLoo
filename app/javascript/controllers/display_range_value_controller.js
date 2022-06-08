import { Controller } from "stimulus"

export default class extends Controller {
  static targets= ["rangeCounter"]

  updateValue(event) {
    // console.log(event.currentTarget.value)
    // this.rangeCounterTarget.insertAdjacentHTML("afterbegin", event.currentTarget.value)

  }
}
