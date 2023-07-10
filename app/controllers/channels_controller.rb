class ChannelsController < ApplicationController
  before_action :authenticate_user!

  layout 'workspace_channel'

  def show
    workspace_channels
    @members = workspace.users
    @channel_members = channel.users
  end

  def index
    render turbo_stream: [
      turbo_stream.update(:workspace_channel_sidebar,
                          partial: 'partials/workspace_channel/channels_list',
                          locals: {
                            workspace:,
                            user: current_user,
                            workspace_channels:
                          })
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
                                            current_user.id)
    channel = channel_creator.commit
    return succeed_channel_creation(channel) if channel

    failed_channel_creation(channel_creator.errors_messages.join(', '))
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

  def failed_channel_creation(message)
    flash[:alert] = message
    redirect_to workspace_path(workspace)
  end

  def succeed_channel_creation(channel)
    flash[:notice] = 'Channel created successfully'
    redirect_to workspace_channel_path(workspace, channel)
  end
end
