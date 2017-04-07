class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.integer :number_book
      t.integer :pages_number
      t.references :author, foreign_key: true
      t.references :category, foreign_key: true
      t.references :publisher, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
