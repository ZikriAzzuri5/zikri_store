class CartsController < ApplicationController
  before_action :authenticate_only_user!
  before_action :authenticate_user!, only: :checkout
  before_action :set_cart
  before_action :check_cart

  def show

  end

  def checkout
    @order = Order.new
    @order.build_address
    @order.build_from_cart(@cart)
  end

  private

  def check_cart
    unless @cart.has_items?
      redirect_to root_path, notice: 'Please add something to cart'
    end
  end
end