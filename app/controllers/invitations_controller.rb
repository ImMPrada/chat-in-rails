class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @invitation = active_invitation
  end

  private

  def workspace
    @workspace ||= Workspace.find(params[:workspace_id])
  end

  def active_invitation
    current_invitation = workspace_invitation
    return current_invitation if current_invitation&.active?

    invitation_creator = Invitations::Creator.new(workspace, current_user)
    invitation_creator.commit
  end

  def workspace_invitation
    invitations = workspace.invitations
    return nil if invitations.empty?

    invitations.last
  end
end
