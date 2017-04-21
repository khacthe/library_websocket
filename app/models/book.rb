class Book < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :borrow_books
  has_many :commments
  has_many :like_actives
  has_many :follow_books
  has_many :passive_followbooks, class_name: "FollowBook",
    foreign_key: "book_id", dependent: :destroy
  has_many :followers_book, through: :passive_followbooks, source: :user_id
  

  belongs_to :user
  belongs_to :category
  belongs_to :author
  belongs_to :publisher

  validates :name, presence: true
  validates :number_book, presence: true

  scope :search_book_name, -> search {where("name LIKE ?", "%#{search}%")}

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :author, :publisher

  def self.to_xls options = {}
    column_names = ["id", "name", "description", "created_at"]
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |book|
        csv << book.attributes.values_at(*column_names)
      end
    end
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
