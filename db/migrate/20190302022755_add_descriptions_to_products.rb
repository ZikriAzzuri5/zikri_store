class AddDescriptionsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :descriptions, :string
  end
end
