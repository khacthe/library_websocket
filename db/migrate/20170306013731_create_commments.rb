class CreateCommments < ActiveRecord::Migration[5.0]
  def change
    create_table :commments do |t|
      t.text :description
      t.float :rate
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
