class Author < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :books

  validates :name, presence: true, uniqueness: true

  scope :search_author_name, -> search {where("name LIKE ?", "%#{search}%")}

  mount_uploader :authorimage, AuthorimageUploader

  def self.to_xls options = {}
    column_names = ["id", "name", "description" "created_at"]
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |author|
        csv << author.attributes.values_at(*column_names)
      end
    end
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
