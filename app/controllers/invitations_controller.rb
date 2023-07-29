class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    @invitation = active_invitation
  end

  def show
    return authenticate_user unless user_signed_in?

    return redirect_user_already_member if user_already_member?

    @invitation = invitation
  end

  def update
    registrar = Invitations::Registrar.new(invitation, current_user)
    return redirect_to profile_path(current_user) if registrar.commit

    render :show
  end

  def decline
    redirect_to profile_path(current_user)
  end

  private

  def active_invitation
    current_invitation = workspace_invitation
    return current_invitation if current_invitation&.active

    invitation_creator = Invitations::Creator.new(workspace, current_user)
    invitation_creator.commit
  end

  def workspace_invitation
    invitations = workspace.invitations
    return nil if invitations.empty?

    invitations.last
  end

  def user_already_member?
    workspace = invitation.workspace
    current_user.member?(workspace)
  end

  def redirect_user_already_member
    flash[:alert] = 'You are already a member of this workspace'
    redirect_to profile_path(current_user)
  end

  def authenticate_user
    cookies[:invitation_token] = invitation.token
    authenticate_user!
  end

  def invitation
    @invitation ||= Invitation.find_by(token: params[:token])
  end

  def workspace
    @workspace ||= Workspace.find(params[:workspace_id])
  end
end
