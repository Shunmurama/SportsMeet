class ChangeDatatypenameOfPrefectures < ActiveRecord::Migration[6.1]
  def change
    change_column :Prefectures, :name, :integer
  end
end
