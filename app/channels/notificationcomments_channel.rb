class NotificationcommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "commentbook_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
