class AddFixedNumberToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :fixed_number, :integer
  end
end
