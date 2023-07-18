class MessagesController < ApplicationController
  def create
    @workspace = Workspace.find(params[:workspace_id])

    message_creator = Messages::Creator.new(
      permitted_params,
      destination,
      current_user
    )
    message = message_creator.commit

    message ? respond_with_success(message) : respond_with_failure(message_creator)

    respond_to { |format| format.turbo_stream }
  end

  private

  def respond_with_success(message)
    @message_creation_result = :success
    @message = message
  end

  def respond_with_failure(message_creator)
    @message_creation_result = :failure
    @message = message_creator.errors_messages.join(', ')
  end

  def permitted_params
    params.require(:message).permit(:content)
  end

  def destination
    @destination ||= find_destination
  end

  def find_destination
    return Channel.find(params[:channel_id]) if params[:channel_id]

    User.find(params[:user_id])
  end
end
