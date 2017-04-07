class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "sessions.reset_sent_pass_success"
      redirect_to login_path
    else
      flash.now[:danger] = t "sessions.reset_sent_pass_error"
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("password_resets.can_not_empty"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t "password_resets.password_has_been_reset"
      redirect_to login_path
    else
      render :edit
    end
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def get_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    unless (@user && @user.activated? &&
      @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "password_resets.password_reset_has_expired"
      redirect_to new_password_reset_url
    end
  end
end
