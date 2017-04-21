class AddSlugToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :slug, :string
  end
end
