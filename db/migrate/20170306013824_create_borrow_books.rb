class CreateBorrowBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :borrow_books do |t|
      t.datetime :date_from
      t.datetime :date_to
      t.boolean :status
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
