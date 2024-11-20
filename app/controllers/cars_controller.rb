class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def search
    @query = params[:query]
    @cars = Car.where("make LIKE ? OR model LIKE ?", "%#{@query}%", "%#{@query}%")
  end
end
