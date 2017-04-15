class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :notification_type
      t.string :notification
      t.string :notification_link
      t.boolean :read, default: false
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
