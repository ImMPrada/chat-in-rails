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
    @channel_user = ChannelUser.new(channel:, user: member)
    return unless channel_user.save

    broadcaster = Members::Broadcaster.new(channel_user, current_user, self)
    broadcaster.boradcast_to_channel_members_list_add_member
  end

  def destroy
    @member = User.find(params[:id])
    broadcaster = Members::Broadcaster.new(channel_user, current_user, self)
    return unless channel_user.destroy

    broadcaster.boradcast_to_channel_members_list_remove_member
  end

  def update
    @member = User.find(params[:id])
    workspace_user.update(role: toogle_member_role)
    broadcaster = Members::Broadcaster.new(channel_user, current_user, self)
    broadcaster.boradcast_to_channel_members_list_update_member_role
  end

  def options
    @member = User.find(params[:member_id])
    @user = current_user
    channel
    workspace
  end

  private

  def channel_user
    @channel_user ||= ChannelUser.find_by(channel:, user: member)
  end

  def workspace_user
    @workspace_user ||= WorkspaceUser.find_by(workspace:, user: member)
  end

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

  def toogle_member_role
    return Role.find_by(name: 'admin') unless member.admin?(workspace)

    Role.find_by(name: 'member')
  end
end
