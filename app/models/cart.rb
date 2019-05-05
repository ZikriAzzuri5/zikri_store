# == Schema Information
#
# Table name: carts
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  uuid       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ApplicationRecord
  before_validation do
    self.uuid = SecureRandom.uuid
  end

  validates :uuid, presence: true

  has_many :cart_items

  belongs_to :user, required: false

  def total_items
    cart_items.count
  end

  def has_items?
    !total_items.zero?
  end

  def grand_total
    cart_items.sum(&:total_price)
  end

  def add_product!(product)
    existing_cart_item = cart_items.find_by(product: product)

    if existing_cart_item
      existing_cart_item.update!(quantity: existing_cart_item.quantity + 1)
    else
      cart_items.create!(product: product, quantity: 1)
    end
  end
end
