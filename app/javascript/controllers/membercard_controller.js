import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["newMessageSignal"]

  remove_new_message_signal(event) {
    const memberCard =  this.newMessageSignalTarget
    memberCard.classList.add('hidden')
  }
}
