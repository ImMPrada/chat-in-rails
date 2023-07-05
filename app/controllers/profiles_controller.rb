class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
  end
end
