class AddCategoryToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :category, foreign_key: true, index: true, after: :id
  end
end
