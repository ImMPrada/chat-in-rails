import consumer from "channels/consumer"

consumer.subscriptions.create('WorkspaceChannel', {
  connected() {
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if(data.state === 'MEMBER_ADDED') { 
      return this.addMemberToChannelMembersList(data.container, data.body)
    }
    if(data.state === 'MEMBER_REMOVED') {
      return this.removeMemberFromChannelMembersList(data.container, data.body)
    }

    this.addMessageToChat(data.containers, data.body)
  },

  removeMemberFromChannelMembersList(container, data) {
    const targetContainer = document.getElementById(container)
    if (!targetContainer) return

    const activeChannelId = targetContainer.dataset.channelId
    const senderId = targetContainer.dataset.senderId
    const currentUserIsSender = data.member_id == senderId
    const currentChannelIsUpdating = activeChannelId == data.channel_id

    if((currentUserIsSender || this.globalCurrentUserId() == data.member_id) && currentChannelIsUpdating) {
      return window.location.href = data.redirect_url
    }

    if(currentChannelIsUpdating) { targetContainer.remove() }
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
  },

  globalCurrentUserId() {
    const currentUserElement = document.getElementById('singleton_global_data')
    currentUserElement.dataset.currentUserId
  }
});
