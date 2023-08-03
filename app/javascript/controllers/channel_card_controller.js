import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["optionsList"]
  static values = { channelId: Number }

  showOptions() {
    const optionsListElementId = `channel_${this.channelIdValue}_card_options`
    const optionsListElement = document.getElementById(optionsListElementId)
    if(!optionsListElement) return

    optionsListElement.classList.toggle("hidden")
  }

  hideOptions() {
    const optionsListElementId = `channel_${this.channelIdValue}_card_options`
    const optionsListElement = document.getElementById(optionsListElementId)
    if(!optionsListElement) return

    optionsListElement.classList.toggle("hidden")
    optionsListElement.innerHTML = ""
  }
}
