class MembersController < ApplicationController
  def new
    query = "LEFT JOIN channel_users ON users.id = channel_users.user_id AND channel_users.channel_id = #{channel.id}"
    @available_users = workspace.users
                                .joins(query)
                                .where('channel_users.id IS NULL')
                                .order(:username)
  end

  def create
    workspace
    channel_user = ChannelUser.new(channel:, user: member)
    return unless channel_user.save

    broadcaster = Members::Broadcaster.new(channel_user, current_user, self)
    broadcaster.boradcast_to_channel_members_list
  end

  private

  def workspace
    @workspace ||= Workspace.find(params[:workspace_id])
  end

  def channel
    @channel ||= Channel.find(params[:channel_id])
  end

  def member
    @member ||= User.find(member_params)
  end

  def member_params
    params.require(:user_id)
  end
end
