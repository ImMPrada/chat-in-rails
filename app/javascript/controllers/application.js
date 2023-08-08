import { Application } from "@hotwired/stimulus"

const isDevtEnvironment = () => {
  const headInfo = document.head.querySelector("meta[name=rails_env]")
  if(!headInfo) return false

  return headInfo.content === "development"
}

const application = Application.start()

// Configure Stimulus development experience
application.debug = isDevtEnvironment()
window.Stimulus   = application

export { application }
