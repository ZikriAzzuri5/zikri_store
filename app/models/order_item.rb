# == Schema Information
#
# Table name: order_items
#
#  id         :bigint(8)        not null, primary key
#  order_id   :bigint(8)        not null
#  product_id :bigint(8)        not null
#  quantity   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderItem < ApplicationRecord
  before_validation do
    self.quantity = 1 if self.quantity.to_i.zero?
  end

  validates :order, presence: true
  validates :product, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :order
  belongs_to :product

  def name
    product.name
  end

  def price
    product.price
  end

  def total_price
    quantity * product.price
  end
end
