module Messages
  class Broadcaster
    def initialize(message, controller)
      @message = message
      @controller = controller
    end

    def broadcast_to_user_dm(userd_ids)
      containers = [
        "user_#{userd_ids.first}_user_#{userd_ids.second}_messages",
        "user_#{userd_ids.second}_user_#{userd_ids.first}_messages"
      ]

      broadcast_to(containers)
    end

    def broadcast_to_channel(channel_id)
      containers = ["channel_#{channel_id}_messages"]
      broadcast_to(containers)
    end

    private

    def broadcast_to(containers)
      WorkspaceChannel.broadcast_to(
        'workspace_channel',
        {
          containers:,
          body: controller.render_to_string(
            partial: 'partials/workspace_channel/message', locals: { message: }
          )
        }
      )
    end

    attr_reader :message, :controller
  end
end
