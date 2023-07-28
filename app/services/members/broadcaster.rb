module Members
  class Broadcaster
    def initialize(channel_user, current_user, controller)
      @channel_user = channel_user
      @controller = controller
      @current_user = current_user
    end

    def boradcast_to_channel_members_list_add_member
      WorkspaceChannel.broadcast_to(
        'workspace_channel',
        {
          state: 'MEMBER_ADDED',
          container: "channel_#{channel.id}_members_list",
          body: build_channel_member_card
        }
      )
    end

    def boradcast_to_channel_members_list_remove_member
      WorkspaceChannel.broadcast_to(
        'workspace_channel',
        {
          state: 'MEMBER_REMOVED',
          container: "channel_#{channel.id}_members_list",
          body: "user_#{current_user.id}_user_#{member.id}_member_card"
        }
      )
    end

    private

    attr_reader :channel_user, :controller, :current_user

    def build_channel_member_card
      controller.render_to_string(
        partial: 'partials/workspace_channel/member_card',
        locals: {
          workspace:,
          member:,
          user: current_user,
          channel:
        }
      )
    end

    def workspace
      @workspace ||= channel.workspace
    end

    def channel
      @channel ||= channel_user.channel
    end

    def member
      @member ||= channel_user.user
    end
  end
end
