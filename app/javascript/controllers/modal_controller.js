import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["modal"]
  static values = { optionslistid: String }

  close() {
    const modal =  this.modalTarget
    if(!modal) return

    modal.remove()
  }
}
