class Commment < ApplicationRecord

  belongs_to :user
  belongs_to :book

  validates :description, presence:true

  # after_create_commit { notify }

  # private

  # def notify
  #   Notification.create( user_id: 6, notified_by_id: 5 )
  #   binding.pry
  # end
end
