class CartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true, null: false
      t.references :product, index: true, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
