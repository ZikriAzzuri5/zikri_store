class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, index: true, null: false
      t.float :shipping_price, null: false
      t.string :shipping_vendor, null: false

      t.timestamps
    end
  end
end
