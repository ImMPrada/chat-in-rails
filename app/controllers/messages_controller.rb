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
  end

  private

  def respond_with_success(message)
    broadcaster = Messages::Broadcaster.new(message, self)

    if destination.destination_path == :workspace_user_messages_path
      broadcaster.broadcast_to_user_dm(
        [
          destination.id,
          current_user.id
        ]
      )
    else
      broadcaster.broadcast_to_channel(destination.id)
    end
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
