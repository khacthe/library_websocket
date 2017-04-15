class Notification < ApplicationRecord
  after_create_commit {CommentbookBroadcastJob.perform_later self}
  belongs_to :user

  scope :num_not_check, ->{where(checked: false).count}
end
