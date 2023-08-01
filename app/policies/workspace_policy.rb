class WorkspacePolicy < ApplicationPolicy
  attr_reader :user, :workspace

  def initialize(user, workspace)
    @user = user
    @workspace = workspace
    super(user, workspace)
  end

  def create_invitation?
    user.admin?(workspace)
  end

  def add_member?(channel)
    return false if channel.name == 'general'

    user.admin?(workspace)
  end

  def add_channel?
    user.admin?(workspace)
  end

  def modify_member_role?(member)
    user.owner?(workspace) && user != member
  end

  def remove_member_from_channel?(channel, member)
    return false if channel.public || @user == member

    user.admin?(workspace)
  end

  def leave_channel?(channel)
    return false if channel.public || user.owner?(workspace)

    user.member?(workspace)
  end

  def delete_channel?(channel)
    return false if channel.name == 'general'

    user.admin?(workspace)
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
