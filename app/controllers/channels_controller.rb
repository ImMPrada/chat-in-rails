class ChannelsController < ApplicationController
  before_action :authenticate_user!

  layout 'channel'

  def show
    channels
    @members = workspace.users
    @channel_members = channel.users
    @messages = channel.messages.order(created_at: :asc)
  rescue ActiveRecord::RecordNotFound => _e
    general_channel = workspace.channels.find_by(name: Channel::BASIC_CHANNEL_NAME)
    redirect_to workspace_channel_path(workspace, general_channel)
  end

  def index
    render turbo_stream: [
      turbo_stream.update(:channel_sidebar,
                          partial: 'partials/workspace_channel/channels_list',
                          locals: {
                            workspace:,
                            user: current_user,
                            channels:
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
                                            workspace)
    channel = channel_creator.commit
    return succeed_channel_creation(channel) if channel

    failed_channel_creation(channel_creator.errors_messages.join(', '))
  end

  def update
    channel_updater = Channels::Updater.new(channel_params,
                                            channel)
    @channel = channel_updater.commit
  end

  def destroy
    channel.destroy
  end

  def options
    @channel = Channel.find(params[:channel_id])
    workspace
  end

  private

  def channel_params
    params.require(:channel).permit(:name, :description, :public)
  end

  def workspace
    @workspace ||= Workspace.find(params[:workspace_id])
  end

  def channel
    @channel ||= Channel.find(params[:id])
  end

  def channels
    @channels ||= workspace.channels
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
