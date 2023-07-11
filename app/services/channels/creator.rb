module Channels
  class Creator
    attr_reader :errors_messages

    def initialize(params, user, workspace, user_id)
      @params = params
      @user = user
      @workspace = workspace
      @user_id = user_id
      @errors_messages = []
    end

    def commit
      @workspace_channel = WorkspaceChannel.new(params)
      workspace_channel.workspace = workspace

      check_channel
      add_user_to_channel

      workspace_channel.save!
      workspace_channel_user.save!
      workspace_channel
    rescue StandardError => e
      errors_messages << e.message
      false
    end

    private

    attr_reader :params, :user, :workspace, :user_id, :workspace_channel, :workspace_channel_user

    def check_channel
      return if workspace_channel.valid?

      message = workspace_channel.errors.full_messages.join(', ')
      raise StandardError, message
    end

    def add_user_to_channel
      @workspace_channel_user = WorkspaceChannelUser.new(user_id:, workspace_channel:)
      return if workspace_channel_user.valid?

      message = workspace_channel_user.errors.full_messages.join(', ')
      raise StandardError, message
    end
  end
end
