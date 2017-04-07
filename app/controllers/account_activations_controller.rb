class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "sessions.account_activated"
      redirect_to user
    else
      flash[:danger] = t "sessions.invalid_activation_link"
      redirect_to login_path
    end
  end
end
