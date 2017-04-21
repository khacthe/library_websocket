class FollowBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :find_all_by_book, ->(book_id){ where(book_id: book_id) }
end
