class CommentbookBroadcastJob < ApplicationJob
  queue_as :default

  def perform notification
    ActionCable.server.broadcast "commentbook_channel" ,
     user_id: notification.user_id,
       notification: notification.notification,
        notification_link: notification.notification_link
  end
end
