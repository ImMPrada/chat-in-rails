class ChannelsController < ApplicationController
  before_action :authenticate_user!

  layout 'workspace_channel'

  include Render

  def show
    workspace_channels
    @members = workspace.users
    @channel_members = channel.users
  end

  def index
    render turbo_stream: [
      add_channels_list_to_stream
    ]
  end

  def new
    @workspace_members = workspace.users
    @channel = Channel.new
  end

  def create
    channel_creator = Channels::Creator.new(channel_params,
                                            current_user,
                                            workspace,
                                            [current_user.id])
    channel = channel_creator.commit
    return redirect_to workspace_channel_path(workspace, channel) if channel

    redirect_to workspace_path(workspace)
  end

  private

  def channel_params
    params.require(:channel).permit(:name, :description)
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
end
