class MessagesController < ApplicationController
  def create
    message_creator = Messages::Creator.new(
      permitted_params,
      channel_destination,
      current_user
    )
    message = message_creator.commit
    return suceed_messaged(message) if message

    failed_messaged(message_creator)
  end

  private

  def suceed_messaged(message)
    render turbo_stream: [
      turbo_stream.append(:workspace_channel_messages,
                          partial: 'partials/workspace_channel/message',
                          locals: {
                            message:
                          }),
      turbo_stream.update(:new_message_box,
                          partial: 'partials/workspace_channel/new_message',
                          locals: {
                            workspace_channel: channel_destination,
                            workspace:
                          }),
      turbo_stream.update(:notifications_bar, '')
    ]
  end

  def failed_messaged(message_creator)
    render turbo_stream: [
      turbo_stream.update(:new_message_box,
                          partial: 'partials/workspace_channel/new_message',
                          locals: {
                            workspace_channel: channel_destination,
                            workspace:
                          }),
      turbo_stream.update(:notifications_bar,
                          "<p class='alert'>#{message_creator.errors_messages.join(', ')}</p>")
    ]
  end

  def permitted_params
    params.require(:message).permit(:content)
  end

  def workspace
    @workspace ||= Workspace.find(params[:workspace_id])
  end

  def channel_destination
    @channel_destination ||= WorkspaceChannel.find(params[:channel_id])
  end
end
