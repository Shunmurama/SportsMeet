class ChangeColumnDefaultToreservations < ActiveRecord::Migration[6.1]
  def change
    change_column_default :reservations, :active, from: false, to: true
  end
end
