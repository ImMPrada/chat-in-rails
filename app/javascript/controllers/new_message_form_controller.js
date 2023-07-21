import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("keydown", this.handleKeyDown.bind(this));
  }

  handleKeyDown(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault()
      this.clickSubmitButton()
    }
  }

  clickSubmitButton() {
    const form = this.element
    const submitButton = form.querySelector('[type="submit"]')

    if (submitButton) { submitButton.click() }
  }
}
