import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  close(event) {
    const channelSidebar = document.getElementById('channel_sidebar')
    channelSidebar.classList.add('max-xl:hidden')
  }

  open(event) {
    const channelSidebar = document.getElementById('channel_sidebar')
    console.log({ channelSidebar })
    channelSidebar.classList.remove('max-xl:hidden')
  }
}
