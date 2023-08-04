import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { memberId: String }

  showOptions() {
    const optionsListElement = document.getElementById(this.memberIdValue)
    if(!optionsListElement) return

    optionsListElement.classList.toggle("hidden")
  }

  hideOptions() {
    const optionsListElement = document.getElementById(this.memberIdValue)
    if(!optionsListElement) return

    optionsListElement.classList.toggle("hidden")
    optionsListElement.innerHTML = ""
  }
}
