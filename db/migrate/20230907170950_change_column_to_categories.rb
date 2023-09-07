class ChangeColumnToCategories < ActiveRecord::Migration[6.1]
  def change
    change_column_default :categories, :name, from: nil, to: "0"
  end
end
