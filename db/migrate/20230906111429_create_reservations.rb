class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.date :date, null: false
      t.integer :reserved_number
      t.boolean :status, default:"FALSE"

      t.timestamps
    end
  end
end
