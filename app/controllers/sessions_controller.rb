class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash.now[:success] = t "sessions.login_success"
      redirect_to admin_users_path
    else
      flash.now[:danger] = t "sessions.login_error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
