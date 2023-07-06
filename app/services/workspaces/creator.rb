module Workspaces
  class Creator
    def initialize(params, user)
      @workspace = Workspace.new(params)
      @user = user
    end

    def workspace_valid?
      workspace.valid?
    end

    def errors
      return unless workspace.errors.any?

      workspace.errors
    end

    def name
      workspace.name
    end

    def commit
      raise return_error unless workspace.valid?

      workspace.save!
      return workspace if workspace_user.save && workspace_basic_channel.save && channel_user.save

      raise return_error
    end

    private

    attr_reader :user, :workspace

    def return_error
      StandardError.new 'Something went wrong, please try again'
    end

    def workspace_user
      WorkspaceUser.new(user:, workspace:, role: Role.find_by(name: 'owner'))
    end

    def workspace_basic_channel
      @workspace_basic_channel ||= Channel.new(name: 'general', workspace:)
    end

    def channel_user
      ChannelUser.new(user:, channel: workspace_basic_channel)
    end
  end
end
