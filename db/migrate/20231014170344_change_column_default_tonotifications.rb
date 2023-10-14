class ChangeColumnDefaultTonotifications < ActiveRecord::Migration[6.1]
  def change
    change_column_default :notifications, :read, from: nil, to: "0"
  end
end
