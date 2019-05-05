class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]
  before_action :authenticate_admin!, except: [:show, :add_to_cart]
  before_action :authenticate_only_user!, only: [:add_to_cart]
  before_action :set_category_options, only: [:index, :new, :edit, :create, :update]
  before_action :set_cart, only: [:add_to_cart, :show]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page]).per(2)
  end

  def show

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  def update_stock
  end

  def stock_update
    @product.stock = @product.stock + product_params[:new_stock].to_i

    if @product.save
      redirect_to products_path
    else
      render :update_stock
    end
  end

  def add_to_cart
    @cart.add_product!(@product)
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category_id, :descriptions, :stock, :image, :new_stock)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_category_options
    @category_options = Category.all.map{|c| [c.category, c.id]}
  end
end
