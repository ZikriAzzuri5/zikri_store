class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.belongs_to :addressable, polymorphic: true
      t.string :country
      t.string :state_or_province
      t.string :city
      t.string :district
      t.string :subdistrict_or_village
      t.string :detail
      t.string :contact
      t.string :name


      t.timestamps
    end

    add_index :addresses, [:addressable_id, :addressable_type]
  end
end
