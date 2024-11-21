class CarsController < ApplicationController
  def index
    @keyword = params[:keyword]
    @category_id = params[:category_id]

    @cars = Car.all

    # Apply keyword search if provided
    if @keyword.present?
      @cars = @cars.where("make LIKE ? OR model LIKE ? OR features LIKE ?", "%#{@keyword}%", "%#{@keyword}%", "%#{@keyword}%")
    end

    # Filter by category if a category is selected
    if @category_id.present?
      @cars = @cars.joins(:categories).where(categories: { id: @category_id })
    end

    # Paginate the filtered results
    @cars = @cars.page(params[:page]).per(6)
  end

  def show
    @car = Car.find(params[:id])
  end
end
