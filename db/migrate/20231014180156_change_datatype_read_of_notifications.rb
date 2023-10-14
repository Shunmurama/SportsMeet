class ChangeDatatypeReadOfNotifications < ActiveRecord::Migration[6.1]
  def change
    change_column :notifications, :read, :boolean
  end
end
