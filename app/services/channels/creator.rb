module Channels
  class Creator
    attr_reader :errors_messages

    def initialize(params, user, workspace)
      @params = params
      @user = user
      @workspace = workspace
      @errors_messages = []
    end

    def commit
      @channel = Channel.new(params)
      channel.workspace = workspace

      check_channel

      add_users_to_channel

      channel.save!
      channel
    rescue StandardError => e
      errors_messages << e.message
      false
    end

    private

    attr_reader :params, :user, :workspace, :channel, :channel_user

    def check_channel
      return if channel.valid?

      message = channel.errors.full_messages.join(', ')
      raise StandardError, message
    end

    def add_users_to_channel
      return add_user_to_channel unless channel.public

      channel.users = workspace.users
    end

    def add_user_to_channel
      channel.users << user
    end
  end
end
