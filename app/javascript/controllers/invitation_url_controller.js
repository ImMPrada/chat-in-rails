import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: String,
    invitationurl: String
  }

  close() {
    const urlCard = document.getElementById(this.idValue)
    urlCard.remove()
  }

  copy() {
    const invitationUrl = this.invitationurlValue
    const notificationBar = document.getElementById("notifications_bar")

    navigator.clipboard.writeText(invitationUrl);
    if(!notificationBar) return

    notificationBar.innerHTML = '<p class="notice">Copied to clipboard</p>'
  }
}
