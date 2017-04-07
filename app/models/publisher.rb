class Publisher < ApplicationRecord
  has_many :books

  validates :name, presence:true, uniqueness: true

  scope :search_publisher_name, -> search {where("name LIKE ?", "%#{search}%")}

  def self.to_xls options = {}
    column_names = ["id", "name", "created_at"]
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |publisher|
        csv << publisher.attributes.values_at(*column_names)
      end
    end
  end

end
