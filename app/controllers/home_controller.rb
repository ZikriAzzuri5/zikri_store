class HomeController < ApplicationController
  before_action :set_cart

  def index
    @products = Product.all
  end
end
