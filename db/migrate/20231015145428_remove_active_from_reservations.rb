class RemoveActiveFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :active, :boolean
  end
end
