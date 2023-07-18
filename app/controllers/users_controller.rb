class UsersController < ApplicationController
  def show
    @receiver = User.find(params[:id])
    @messages = Message.where(classifiable: @receiver, author: current_user)
                       .or(Message.where(classifiable: current_user, author: @receiver))
                       .order(created_at: :asc)
    @workspace = Workspace.find(params[:workspace_id])
  end
end
