class WorkspacesController < ApplicationController
  before_action :authenticate_user!

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
      notify_message(
        {
          classes: 'alert',
          message: message || workspace_creator.errors.full_messages.join(', ')
        }
      )
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
      turbo_stream.update(:new_workspace_form, ''),
      notify_message(
        {
          classes: 'notice',
          message:
        }
      )
    ]
  end

  def notify_message(notification)
    turbo_stream.update(
      :notifications_bar,
      partial: 'partials/bar_notification',
      locals: notification
    )
  end

  def update_workspaces_list(workspaces)
    turbo_stream.update(
      :my_workspaces_list,
      partial: 'partials/workspaces/list',
      locals: { workspaces: }
    )
  end
end
