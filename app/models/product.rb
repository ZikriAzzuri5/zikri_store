# == Schema Information
#
# Table name: products
#
#  id           :bigint(8)        not null, primary key
#  category_id  :bigint(8)
#  name         :string(255)
#  price        :float(24)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  descriptions :text(65535)
#  stock        :integer
#

class Product < ApplicationRecord
  attr_accessor :new_stock

  validates :name, presence: true
  validates :price, presence: true
  validates :category, presence: true, if: :category_id?
  has_one_attached :image

  belongs_to :category, required: false

  def price
    super.try(:round)
  end
end
