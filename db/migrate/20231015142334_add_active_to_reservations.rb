class AddActiveToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :active, :boolean
  end
end
