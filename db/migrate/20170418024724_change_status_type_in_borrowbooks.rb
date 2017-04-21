class ChangeStatusTypeInBorrowbooks < ActiveRecord::Migration[5.0]
  def change
    change_column :borrow_books, :status, :string
  end
end
