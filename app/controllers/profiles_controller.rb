class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @workspaces = user.workspaces
  end

  def workspaces
    @workspaces = user.workspaces
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
