class ChangeDataTypeForStock < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :stock, :integer
  end
end
