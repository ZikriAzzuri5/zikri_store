# == Schema Information
#
# Table name: addresses
#
#  id               :bigint(8)        not null, primary key
#  addressable_type :string(255)
#  addressable_id   :bigint(8)
#  province         :string(255)
#  city             :string(255)
#  subdistrict      :string(255)
#  detail           :string(255)
#  contact          :string(255)
#  name             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :province, presence: true
  validates :city, presence: true
  validates :subdistrict, presence: true
  validates :detail, presence: true
  validates :contact, presence: true
end
