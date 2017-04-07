class Admin::BaseController < ApplicationController
  protect_from_forgery with: :exception
  before_action :verify_admin
  layout "admin"

  def verify_admin
    redirect_to root_url unless logged_in? && current_user.is_admin?
  end
end
