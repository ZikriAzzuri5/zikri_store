# == Schema Information
#
# Table name: orders
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)        not null
#  shipping_price  :float(24)        not null
#  shipping_vendor :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Order < ApplicationRecord
  STATUSES = ['Packing', 'Shipped']

  before_validation do
    if self.shipping_vendor.present?
      _shipping_vendor = SHIPPING_VENDORS.detect{|sv| sv[:name] == self.shipping_vendor}
      self.shipping_price = _shipping_vendor.try(:[], :base_price)
    end
  end

  validates :shipping_price, presence: true
  validates :user, presence: true
  validates :shipping_vendor, presence: true, :inclusion => { :in => SHIPPING_VENDORS.map{|sv| sv[:name]} }

  belongs_to :user, required: false

  has_one :address, as: :addressable

  has_many :order_items

  accepts_nested_attributes_for :address

  def is_payment_failed?
    payment_status.to_s.include?('Payment Failed')
  end

  def payment_success!
    update(payment_status: 'Payment Successful')
  end

  def payment_fail!(reason)
    update(payment_status: "Payment Failed : #{reason}")
  end

  def full_address
    "#{address.detail}, #{address.subdistrict}, #{address.city}, #{address.province}"
  end

  def shipping_price
    super.try(:round) || 0
  end

  def build_from_cart(cart)
    self.user_id = cart.user_id

    cart.cart_items.each do |cart_item|
      self.order_items.new(
        product_id: cart_item.product_id,
        quantity: cart_item.quantity
      )
    end
  end

  def total_items
    order_items.count
  end

  def has_items?
    !total_items.zero?
  end

  def total_price
    order_items.sum do |order_item|
      order_item.total_price
    end
  end

  def grand_total
    total_price + shipping_price
  end
end
