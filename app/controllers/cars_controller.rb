class CarsController < ApplicationController
  def index
    @cars = Car.page(params[:page]).per(3)
  end

  def search
    @query = params[:query]
    @cars = Car.where("make LIKE ? OR model LIKE ?", "%#{@query}%", "%#{@query}%")
  end

  def show
    @car = Car.find(params[:id])
  end
end
