class AddColumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :shipping_number, :string, after: :shipping_vendor
    add_column :orders, :status, :string, after: :shipping_number
  end
end
