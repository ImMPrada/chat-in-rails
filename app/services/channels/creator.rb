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
      @channel = Channel.new(params)
      channel.workspace = workspace

      check_channel
      add_user_to_channel

      channel.save!
      channel_user.save!
      channel
    rescue StandardError => e
      errors_messages << e.message
      false
    end

    private

    attr_reader :params, :user, :workspace, :user_id, :channel, :channel_user

    def check_channel
      return if channel.valid?

      message = channel.errors.full_messages.join(', ')
      raise StandardError, message
    end

    def add_user_to_channel
      @channel_user = ChannelUser.new(user_id:, channel:)
      return if channel_user.valid?

      message = channel_user.errors.full_messages.join(', ')
      raise StandardError, message
    end
  end
end
