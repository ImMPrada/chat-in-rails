module Invitations
  class Registrar
    def initialize(invitation, user)
      @invitation = invitation
      @user = user
    end

    def commit
      return false unless invitation_valid?

      add_user_to_workspace
      add_user_to_general_workspace_channel
      return commit_user_to_workspace if workspace_user.valid? && channel_user.valid?

      false
    end

    private

    attr_reader :invitation, :user, :workspace_user, :channel_user

    def add_user_to_workspace
      @workspace_user = WorkspaceUser.new(workspace:, user:, role:)
    end

    def add_user_to_general_workspace_channel
      channel = workspace.channels.find_by(name: Channel::BASIC_CHANNEL_NAME)
      @channel_user = ChannelUser.new(channel:, user:)
    end

    def commit_user_to_workspace
      workspace_user.save
      channel_user.save
      invitation.update(active: false)

      true
    end

    def workspace
      invitation.workspace
    end

    def role
      Role.find_by(name: 'member')
    end

    def invitation_valid?
      invitation.instance_of?(Invitation) && user.instance_of?(User) && invitation.active?
    end
  end
end
