class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    invitation_token = cookies[:invitation_token]
    return show_invitation(invitation_token) if invitation_token

    @workspaces = user.workspaces
  end

  def workspaces
    @workspaces = user.workspaces
  end

  private

  def show_invitation(invitation_token)
    cookies.delete(:invitation_token)
    redirect_to invitation_path(invitation_token)
  end

  def user
    @user ||= User.find(params[:id])
  end
end
