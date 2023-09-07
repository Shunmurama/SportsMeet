class ChangeDatatypenameOfprefectures < ActiveRecord::Migration[6.1]
  def change
    change_column :prefectures, :name, :integer
  end
end
