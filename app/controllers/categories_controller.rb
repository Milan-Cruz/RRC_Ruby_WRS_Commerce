class CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per(9) # Paginate categories on the index page
  end

  def show
    @category = Category.find_by(id: params[:id])
    if @category.nil?
      redirect_to categories_path, alert: "Category not found."
    else
      @cars = @category.cars.page(params[:page]).per(22) # Paginate cars in the category
    end
  end
end
