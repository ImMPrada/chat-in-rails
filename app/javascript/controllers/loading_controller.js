import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { turboTarget: String }

  start() {
    console.log(this.turboTargetValue)
    const turboTarget = document.getElementById("new-channel-modal")
    this.showLoadingSpinner(turboTarget)
  }

  showLoadingSpinner(turboTarget) {
    const spinner = `
      <div class="flex
                  flex-col
                  justify-center
                  items-center
                  absolute
                  w-screen
                  h-screen
                  top-0
                  right-0
                  bg-black-soft
                  bg-opacity-75
                  z-50
                  text-white"
        id="loading"
      >
        <div class='w-16
                    h-16
                    border-4
                    border-dashed
                    rounded-full
                    animate-spin-slow
                    dark:border-grey-soft'
        >
        </div>
      </div>
    `
    turboTarget.innerHTML = spinner
  }
}
