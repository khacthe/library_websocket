class FollowbookBroadcastJob < ApplicationJob
  queue_as :default

  def perform follow_book
    ActionCable.server.broadcast "followbook_channel" ,
      username: follow_book.user.fullname, bookname: follow_book.book.name
  end
end
