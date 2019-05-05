class CategoriesController < ApplicationController
  before_action :current_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:category)
  end

  def current_category
    @category = Category.find(params[:id])
  end
end
