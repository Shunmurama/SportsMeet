class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null:false
      t.integer :event_id, null:false
      t.text :message, foreign_key: true, null:false
      t.integer :read, null: false, default: 0

      t.timestamps
    end
  end
end
