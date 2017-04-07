class Commment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :description, presence:true
  validates :rate, presence:true
end
