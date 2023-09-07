class ChangeDatatypenameOfcategories < ActiveRecord::Migration[6.1]
  def change
    change_column :categories, :name, :integer
  end
end
