class ChannelsController < ApplicationController
  before_action :authenticate_user!

  layout 'workspace_channel'

  include Render

  def show
    @workspace_channels = workspace.channels
    @members = workspace.users
    @channel_members = channel.users
  end

  def index
    render turbo_stream: [
      add_channels_list_tu_stream
    ]
  end

  def new
    @workspace_members = workspace.users
    @channel = Channel.new
  end

  def create
    members_ids = permitted_params[:members_ids_selected] || []
    members_ids << current_user.id
    channel_creator = Channels::Creator.new(channel_params,
                                            current_user,
                                            workspace,
                                            members_ids)
    channel = channel_creator.commit
    return redirect_to workspace_channel_path(workspace, channel) if channel

    flash[:alert] = channel_creator.errors_messages.join(', ')
    redirect_to workspace_path(workspace)
  end

  private

  def channel_params
    params.require(:channel).permit(:name, :description)
  end

  def permitted_params
    params.require(:channel).permit(:name, members_ids_selected: [])
  end

  def workspace
    @workspace ||= Workspace.find(params[:workspace_id])
  end

  def channel
    @channel ||= Channel.find(params[:id])
  end

  def workspace_channels
    @workspace_channels ||= workspace.channels
  end

  def channel_members
    @channel_members ||= channel.users
  end
end
