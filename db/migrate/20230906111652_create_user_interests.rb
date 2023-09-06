class CreateUserInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :user_interests do |t|

      t.timestamps
    end
  end
end
