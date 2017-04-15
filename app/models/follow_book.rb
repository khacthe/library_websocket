class FollowBook < ApplicationRecord
  after_create_commit {FollowbookBroadcastJob.perform_later self}

  belongs_to :user
  belongs_to :book

  scope :find_all_by_book, ->(book_id){ where(book_id: book_id) }
end
