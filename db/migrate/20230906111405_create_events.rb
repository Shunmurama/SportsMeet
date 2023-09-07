class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false
      t.references :favorite, foreign_key: true, null: false
      t.references :comment, foreign_key: true, null: false
      t.references :prefecture, foreign_key: true, null: false
      t.string :name, null: false
      t.text :outline, null: false
      t.date :date, null: false
      t.string :place, null: false
      t.string :fee, null: false
      t.integer :how_to_pay, null: false, default: 0

      t.timestamps
    end
  end
end
