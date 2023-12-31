import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  close() {
    const channelSidebar = document.getElementById('channel_sidebar')
    channelSidebar.classList.add('max-xl:hidden')
  }

  open() {
    const channelSidebar = document.getElementById('channel_sidebar')
    channelSidebar.classList.remove('max-xl:hidden')
  }
}
