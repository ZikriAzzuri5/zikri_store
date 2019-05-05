class CartItemsController < ApplicationController
  before_action :current_cart_item, only: [:destroy, :update]
  before_action :set_cart, only: [:update]

  def destroy
    @cart_item.destroy
    redirect_to cart_path
  end

  def update
    @cart_item.update(cart_item_params)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

  def current_cart_item
     @cart_item = CartItem.find(params[:id])
  end
end

