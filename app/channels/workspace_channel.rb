class WorkspaceChannel < ApplicationCable::Channel
  def subscribed
    byebug
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
