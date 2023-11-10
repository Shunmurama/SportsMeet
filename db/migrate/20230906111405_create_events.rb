class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.integer :prefecture_id, null: false
      t.string :name, null: false
      t.text :outline, null: false
      t.date :date, null: false
      t.string :place, null: false
      t.integer :number, null: false
      t.string :fee, null: false
      t.integer :how_to_pay, null: false, default: 0

      t.timestamps
    end
  end
end
