class ChangeColumnNotifications < ActiveRecord::Migration[6.1]
  def change
    change_column_default :notifications, :read, nil
  end
end
