class ChangeDatatypefeeOfEvents < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :fee, :integer
  end
end
