class WorkspaceChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'workspace_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
