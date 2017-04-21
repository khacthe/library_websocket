class Commment < ApplicationRecord

  belongs_to :user
  belongs_to :book

  validates :description, presence:true
end
