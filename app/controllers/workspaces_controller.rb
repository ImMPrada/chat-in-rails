class WorkspacesController < ApplicationController
  before_action :authenticate_user!

  include Render

  def show
    workspace = Workspace.find(params[:id])
    channel = workspace.channels.first
    redirect_to workspace_channel_path(workspace, channel)
  end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace_creator = Workspaces::Creator.new(workspace_params, current_user)
    return return_by_error unless workspace_creator.workspace_valid?

    valid_workspace
  rescue StandardError => e
    return_by_error(message: e.message)
  end

  private

  attr_reader :workspace_creator, :workspace

  def workspace_params
    params.require(:workspace).permit(:name)
  end

  def return_by_error(message: nil)
    render turbo_stream: [
      alert_message(message || workspace_creator.errors.full_messages.join(', ')),
    ]
  end

  def valid_workspace
    workspace_creator.commit

    update_user_workspaces(
      current_user.workspaces,
      "#{workspace_creator.name} created successfully"
    )
  end

  def update_user_workspaces(workspaces, message)
    render turbo_stream: [
      update_workspaces_list(workspaces),
      remove_new_workspace_form,
      notice_message(message)
    ]
  end
end
