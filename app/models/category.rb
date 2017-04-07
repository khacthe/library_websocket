class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true

  scope :search_category_name, -> search {where("name LIKE ?", "%#{search}%")}

  def self.to_xls options = {}
    column_names = ["id", "name", "created_at"]
    CSV.generate(options) do |xls|
      xls << column_names
      all.each do |category|
      xls << category.attributes.values_at(*column_names)
      end
    end
  end
end
