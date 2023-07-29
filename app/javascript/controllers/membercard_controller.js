import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["newMessageSignal"]
  static values = { optionslistid: String }

  remove_new_message_signal(event) {
    const memberCard =  this.newMessageSignalTarget
    memberCard.classList.add('hidden')
  }

  showOptions() {
    const optionsList = document.getElementById(this.optionslistidValue)
    if(!optionsList) return

    optionsList.classList.remove('hidden')
  }

  closeOptions() {
    const optionsList = document.getElementById(this.optionslistidValue)
    if(!optionsList) return

    optionsList.classList.add('hidden')
  }
}
