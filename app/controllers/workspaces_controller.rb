class WorkspacesController < ApplicationController
  before_action :authenticate_user!

  layout 'workspace', only: %i[show]

  def show
    @workspace = Workspace.find(params[:id])
    @members = @workspace.users
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

  attr_reader :workspace_creator

  def workspace_params
    params.require(:workspace).permit(:name)
  end

  def return_by_error(message: nil)
    locals = {
      classes: 'alert',
      message: message || workspace_creator.errors.full_messages.join(', ')
    }

    render turbo_stream: [
      turbo_stream.update(:notifications_bar,
                          partial: 'partials/bar_notification',
                          locals:)
    ]
  end

  def valid_workspace
    workspace_creator.commit

    update_user_workspaces(
      current_user.workspaces,
      {
        classes: 'notice',
        message: "#{workspace_creator.name} created successfully"
      }
    )
  end

  def update_user_workspaces(workspaces, notification)
    render turbo_stream: [
      turbo_stream.update(:my_workspaces_list,
                          partial: 'partials/workspaces/list',
                          locals: { workspaces: }),
      turbo_stream.update(:new_workspace_form, ''),
      turbo_stream.update(:notifications_bar,
                          partial: 'partials/bar_notification',
                          locals: notification)
    ]
  end
end
