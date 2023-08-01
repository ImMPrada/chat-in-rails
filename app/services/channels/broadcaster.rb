module Channels
  class Broadcaster
    def initialize(channel, current_user, controller)
      @channel = channel
      @controller = controller
      @current_user = current_user
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

    private

    attr_reader :channel, :controller, :current_user

    # def build_channel_member_card
    #   controller.render_to_string(
    #     partial: 'partials/workspace_channel/member_card',
    #     locals: {
    #       workspace:,
    #       member:,
    #       user: current_user,
    #       channel:
    #     }
    #   )
    # end

    def workspace
      @workspace ||= channel.workspace
    end
  end
end
