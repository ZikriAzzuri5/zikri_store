class RemoveAndChangeAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :country
    remove_column :addresses, :subdistrict_or_village

    rename_column :addresses, :district, :subdistrict
    rename_column :addresses, :state_or_province, :province
  end
end
