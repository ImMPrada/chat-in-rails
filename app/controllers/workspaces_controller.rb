class WorkspacesController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace_creator = Workspaces::Creator.new(workspace_params, current_user)
    return invalid_workspace unless workspace_creator.workspace_valid?

    valid_workspace
  rescue StandardError => e
    return_by_error(e.message)
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

  def valid_workspace
    new_workspace = workspace_creator.commit
    flash.now[:notice] = "#{workspace_creator.name} created successfully"

    update_user_workspaces(new_workspace)
  end

  def return_by_error(message)
    flash[:alert] = message
    redirect_to profile_path(current_user)
  end

  def update_user_workspaces(workspace)
    render turbo_stream: [
      turbo_stream.append(:my_workspaces_list,
                          partial: 'partials/workspaces/list_card',
                          locals: { workspace: }),
      turbo_stream.update(:new_workspace_form, '')
    ]
  end
end
