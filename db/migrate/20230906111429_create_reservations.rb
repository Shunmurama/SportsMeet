class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :event, foreign_key: true, null: false
      t.date :date, null: false
      t.integer :reserved_number
      t.boolean :status, default:"FALSE"

      t.timestamps
    end
  end
end
