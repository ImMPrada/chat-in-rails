import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["newChannelWindow", "publicButton", "privateButton", "publicInput"]

  close() {
    const modal = this.newChannelWindowTarget
    if(!modal) return

    modal.remove()
  }

  makeItPublic() {
    const privateButton = this.privateButtonTarget
    const publicButton = this.publicButtonTarget
    const checkbox = this.publicInputTarget
    if(!checkbox) return

    checkbox.checked = true
    checkbox.value = true
    privateButton.classList.remove('hidden')
    publicButton.classList.add('hidden')
  }

  makeItPrivate() {
    const publicButton = this.publicButtonTarget
    const privateButton = this.privateButtonTarget
    const checkbox = this.publicInputTarget
    if(!checkbox) return

    checkbox.checked = false
    checkbox.value = false
    publicButton.classList.remove('hidden')
    privateButton.classList.add('hidden')
  }
}
