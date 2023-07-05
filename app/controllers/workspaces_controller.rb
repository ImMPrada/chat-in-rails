class WorkspacesController < ApplicationController
  before_action :authenticate_user!

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace_creator = Workspaces::Creator.new(workspace_params, current_user)
    return invalid_workspace unless workspace_creator.workspace_valid?
  end

  private

  attr_reader :workspace_creator

  def workspace_params
    params.require(:workspace).permit(:name)
  end

  def invalid_workspace
    flash[:alert] = workspace_creator.errors.full_messages.join(', ')
    redirect_to profile_path(current_user)
  end
end
