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

  def add_member?
    user.admin?(workspace)
  end

  def add_channel?
    user.admin?(workspace)
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
