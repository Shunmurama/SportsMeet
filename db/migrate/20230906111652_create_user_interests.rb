class CreateUserInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :user_interests do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
