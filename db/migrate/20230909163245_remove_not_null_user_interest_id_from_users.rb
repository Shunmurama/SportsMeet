class RemoveNotNullUserInterestIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :user_interest_id, :integer, null: true
  end
end
