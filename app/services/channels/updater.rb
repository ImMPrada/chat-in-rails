module Channels
  class Updater
    attr_reader :errors_messages

    def initialize(params, channel)
      @params = params
      @channel = channel
      @errors_messages = []
    end

    def commit
      update_members
      return channel if update_channel

      false
    rescue errors => e
      errors_messages << e.message
      false
    end

    private

    attr_reader :params, :channel

    def update_members
      return if params[:public] == 'false' || channel.public

      ChannelUser.where(channel:).destroy_all
      channel.users = workspace.users
    end

    def update_channel
      channel.update(params)
    end

    def workspace
      @workspace ||= channel.workspace
    end
  end
end
