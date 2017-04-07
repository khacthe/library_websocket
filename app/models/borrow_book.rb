class BorrowBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :date_from, presence:true
  validates :date_to, presence:true

  scope :search_brorrow_by_user, -> search {where("id LIKE ?", "#{search}")}
end
