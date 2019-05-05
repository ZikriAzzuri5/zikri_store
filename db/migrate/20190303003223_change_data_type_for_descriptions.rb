class ChangeDataTypeForDescriptions < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :descriptions, :text
  end
end
