import consumer from "channels/consumer"

consumer.subscriptions.create('WorkspaceChannel', {
  connected() {
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    this.addMessageToChat(data.containers, data.body)
  },

  addMessageToChat(containersIdsPrefix, message) {
    containersIdsPrefix.forEach(containerIdPrefix => this.addMessageToContainer(containerIdPrefix, message))
  },

  addMessageToContainer(containerIdPrefix, message) {
    const targetContainer = document.getElementById(`${containerIdPrefix}_messages`)
    if (!targetContainer) {
      this.addNotificationIconToContainer(containerIdPrefix)
      return
    }

    targetContainer.insertAdjacentHTML('beforeend', message)
    targetContainer.scrollTop = targetContainer.scrollHeight
  },

  addNotificationIconToContainer(containerIdPrefix) {
    const targetContainer = document.getElementById(`${containerIdPrefix}_new_message_signal`)
    if (!targetContainer) return

    targetContainer.classList.remove('hidden')
  }
});
