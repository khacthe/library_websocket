class NotificationsController < ApplicationController
  before_action :find_notification, only: [:update]

  def update
    @notification.update_columns read: true
  end

  def notification_checked
    current_user.notifications.notification_not_checked.each do |notification|
      notification.update_columns checked: true
    end
  end
  
  private

  def find_notification
    @notification = Notification.find_by id: params[:id]
    unless @notification.present?
      flash[:alert] = "don't find notification"
      redirect_to root_path
    end
  end
end
