class CreateEventCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :event_categories do |t|
      t.references :event, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end
  end
end
