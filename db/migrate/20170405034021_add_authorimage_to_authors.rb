class AddAuthorimageToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :authorimage, :string
  end
end
