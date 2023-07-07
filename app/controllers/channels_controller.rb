class ChannelsController < ApplicationController
  before_action :authenticate_user!

  def new
    @workspace_members = workspace.users
    @channel = Channel.new
  end

  def create
    channel_creator = Channels::Creator.new(channel_params, current_user, workspace, users_ids)
    channel = channel_creator.commit
    return redirect_to workspace_path(workspace) if channel

    flash[:alert] = channel_creator.errors_messages.join(', ')
    redirect_to workspace_path(workspace)
  end

  private

  def channel_params
    params.require(:channel).permit(:name)
  end

  def users_ids
    params[:members_ids][:selected]
  end

  def workspace
    @workspace ||= Workspace.find(params[:workspace_id])
  end
end
