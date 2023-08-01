module Channels
  class Broadcaster
    def initialize(channel, controller)
      @channel = channel
      @controller = controller
    end

    def remove_channel_from_channels_list
      WorkspaceChannel.broadcast_to(
        'workspace_channel',
        {
          state: 'CHANNEL_REMOVED',
          container: "channel_#{channel.id}_card",
          body: nil
        }
      )
    end

    def update_channel_from_channels_list
      WorkspaceChannel.broadcast_to(
        'workspace_channel',
        {
          state: 'CHANNEL_CARD_UPDATED',
          container: "channel_#{channel.id}_card",
          body: build_channel_member_card
        }
      )
    end

    private

    attr_reader :channel, :controller

    def build_channel_member_card
      controller.render_to_string(
        partial: 'partials/workspace_channel/channel_card',
        locals: {
          workspace:,
          channel:
        }
      )
    end

    def workspace
      @workspace ||= channel.workspace
    end
  end
end
