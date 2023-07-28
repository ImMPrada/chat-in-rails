import consumer from "channels/consumer"

consumer.subscriptions.create('WorkspaceChannel', {
  connected() {
    console.log('connected')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    if(data.state === 'MEMBER_ADDED') { return this.addMemberToChannelMembersList(data.containers, data.body) }

    this.addMessageToChat(data.containers, data.body)
  },

  addMemberToChannelMembersList(container, memberCard) {
    const targetContainer = document.getElementById(container)
    if (!targetContainer) return

    targetContainer.insertAdjacentHTML('beforeend', memberCard)
    targetContainer.scrollTop = targetContainer.scrollHeight
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
