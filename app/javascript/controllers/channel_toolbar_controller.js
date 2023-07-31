import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  close() {
    const channelToolbar = document.getElementById('tool_sidebar')
    channelToolbar.innerHTML = "";
  }
}
