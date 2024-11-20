class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
    if @category.nil?
      redirect_to categories_index_path, alert: "Category not found."
    else
      @cars = @category.cars
    end
  end
end
