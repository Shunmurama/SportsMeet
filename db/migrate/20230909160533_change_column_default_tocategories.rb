class ChangeColumnDefaultTocategories < ActiveRecord::Migration[6.1]
  def change
    change_column_default :categories, :name, from: "0", to: nil
  end
end
