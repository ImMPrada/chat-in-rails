class MessagesController < ApplicationController
  def create
    @message_box_turbo_tag = message_box_turbo_tag
    @url = url

    message_creator = Messages::Creator.new(
      permitted_params,
      destination,
      current_user
    )
    message = message_creator.commit

    message ? respond_with_succes(message) : respond_with_failure(message_creator)

    respond_to { |format| format.turbo_stream }
  end

  private

  def respond_with_succes(message)
    @message_succed = true
    @messages_turbo_tag = messages_turbo_tag
    @message = message
  end

  def respond_with_failure(message_creator)
    @message_succed = false
    @message = message_creator.errors_messages.join(', ')
  end

  def permitted_params
    params.require(:message).permit(:content)
  end

  def workspace
    @workspace ||= Workspace.find(params[:workspace_id])
  end

  def destination
    @destination ||= find_record
  end

  def find_record
    return WorkspaceChannel.find(params[:channel_id]) if params[:channel_id]

    User.find(params[:user_id])
  end

  def url
    return workspace_channel_path(workspace, destination) if destination.instance_of? WorkspaceChannel

    workspace_user_messages_path(workspace, destination)
  end

  def message_box_turbo_tag
    return "workspace_channel_#{destination.id}_message_box" if workspace_channel?

    "user_#{destination.id}_message_box"
  end

  def messages_turbo_tag
    return "workspace_channel_#{destination.id}_messages" if workspace_channel?

    "user_#{destination.id}_messages"
  end

  def workspace_channel?
    destination.instance_of? WorkspaceChannel
  end
end
