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
    if(data.state === 'MEMBER_UPDATED') {
      return this.updateMemberInChannelMembersList(data.container, data.body)
    }
    if(data.state === 'CHANNEL_REMOVED') {
      return this.removeChannelFromChannelsList(data.container)
    }
    if(data.state === 'CHANNEL_CARD_UPDATED') {
      return this.updateChannelCard(data.container, data.body)
    }


    this.addMessageToChat(data.containers, data.body)
  },

  updateChannelCard(container, channelCard) {
    const targetContainer = document.getElementById(container)
    if (!targetContainer) return

    const temporalDiv = document.createElement('div')
    temporalDiv.innerHTML = channelCard
    targetContainer.replaceWith(temporalDiv.children[0])
  },

  removeChannelFromChannelsList(container) {
    const targetContainer = document.getElementById(container)
    if (!targetContainer) return

    targetContainer.remove()
  },

  removeMemberFromChannelMembersList(container, memberCardId) {
    const targetContainer = document.getElementById(container)
    if (!targetContainer) return

    const memberCard = document.getElementById(memberCardId)
    if (!memberCard) return

    targetContainer.removeChild(memberCard)
  },

  addMemberToChannelMembersList(container, memberCard) {
    const targetContainer = document.getElementById(container)
    if (!targetContainer) return

    targetContainer.insertAdjacentHTML('beforeend', memberCard)
    targetContainer.scrollTop = targetContainer.scrollHeight
  },

  updateMemberInChannelMembersList(container, membersCards) {
    const targetContainer = document.getElementById(container)
    if (!targetContainer) return
    
    const temporalDiv = document.createElement('div')
    temporalDiv.innerHTML = membersCards
    targetContainer.replaceWith(temporalDiv.children[0])
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
