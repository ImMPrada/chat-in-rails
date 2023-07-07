module Channels
  class Creator
    attr_reader :errors_messages

    def initialize(params, user, workspace, users_ids)
      @params = params
      @user = user
      @workspace = workspace
      @users_ids = users_ids
      @errors_messages = []
    end

    def commit
      @channel = Channel.new(params)
      channel.workspace = workspace

      check_channel
      add_users_to_channel

      channel.save!
      chanel_users.each(&:save!)
      channel
    rescue StandardError => e
      errors_messages << e.message
      false
    end

    private

    attr_reader :params, :user, :workspace, :users_ids, :channel, :chanel_users

    def check_channel
      return if channel.valid?

      message = channel.errors.full_messages.join(', ')
      raise StandardError, message
    end

    def add_users_to_channel
      @chanel_users = users_ids.map do |user_id|
        check_chanel_user(ChannelUser.new(user_id:, channel:))
      end
    end

    def check_chanel_user(channel_user)
      return channel_user if channel_user.valid?

      message = channel_user.errors.full_messages.join(', ')
      raise StandardError, message
    end
  end
end
