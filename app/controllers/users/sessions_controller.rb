# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  SIGN_IN_ERRORS = Struct.new(:username_or_email, :password)

  SIGN_ING_STRUCT = Struct.new(:username_or_email, :password, :errors) do
    def valid?
      return true unless username_or_email.nil? || password.nil?

      self.errors = SIGN_IN_ERRORS.new
      errors.username_or_email = 'you need the username or the email' if username_or_email.nil?
      errors.password = 'you need the username or the email' if password.nil?
    end
  end

  # GET /resource/sign_in
  def new
    @user = User.new
    super
  end

  # POST /resource/sign_in
  def create
    return incomplete_info if incomplete_info?

    user = find_user
    return wrong_credentials unless user

    if user.valid_password?(user_password)
      set_flash_message :notice, :signed_in
      sign_in(user)
    else
      wrong_credentials
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username_or_email])
  end

  private

  def user_username_or_email
    params[:user][:username_or_email]
  end

  def user_password
    params[:user][:password]
  end

  def incomplete_info?
    user_username_or_email.blank? || user_password.blank?
  end

  def find_user
    User.find_by(username: user_username_or_email) || User.find_by(email: user_username_or_email)
  end

  def incomplete_info
    flash[:alert] = 'You need to fill in all the fields'
    redirect_to new_user_session_path
  end

  def wrong_credentials
    flash[:alert] = 'Wrong credentials'
    redirect_to new_user_session_path
  end
end
