class CreateLikeActives < ActiveRecord::Migration[5.0]
  def change
    create_table :like_actives do |t|
      t.boolean :is_like
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
