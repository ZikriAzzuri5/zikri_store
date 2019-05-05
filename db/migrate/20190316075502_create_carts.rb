class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :user, index: true, null: true
      t.string :uuid, null: false

      t.timestamps
    end
  end
end
