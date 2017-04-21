class Notification < ApplicationRecord
  after_create_commit {CommentbookBroadcastJob.perform_later self}
  belongs_to :user

  default_scope {order(created_at: :desc)}
  scope :num_not_check, ->{where(checked: false).count}
  scope :notification_not_checked, ->{where(checked: false)}
end
