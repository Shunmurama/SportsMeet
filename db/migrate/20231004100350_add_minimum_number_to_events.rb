class AddMinimumNumberToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :minimum_number, :integer
  end
end
