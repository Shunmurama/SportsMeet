class RemoveMessageFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :message, :text
  end
end
