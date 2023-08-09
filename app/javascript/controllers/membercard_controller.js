import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["newMessageSignal"]
  static values = { optionslistid: String }

  remove_new_message_signal() {
    const memberCard =  this.newMessageSignalTarget
    memberCard.classList.add('hidden')

    this.loading_new_dm_chat()
  }

  loading_new_dm_chat() {
    const toolBar = document.getElementById('tool_sidebar')
    toolBar.innerHTML = `<div class='flex
    justify-center
    items-center
    flex-col
    h-full
    w-[600px]
    max-lg:w-full
    max-lg:absolute
    max-lg:top-0
    max-lg:right-0
    bg-black-soft
    max-lg:bg-opacity-75
    max-lg:z-40
    text-white'>
      <div class='w-16
      h-16
      border-4
      border-dashed
      rounded-full
      animate-spin-slow
      dark:border-grey-soft'></div>
    </div>`;

    console.log({toolBar})
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

  hideSidebar() {
    const toolBar = document.getElementById('channel_sidebar')
    toolBar.classList.add('max-xl:hidden')
  }
}
