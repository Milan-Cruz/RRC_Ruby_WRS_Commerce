class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @cart_items = session[:cart] || {}
  end

  def add_item
    car_id = params[:car_id].to_s
    quantity = params[:quantity].to_i

    session[:cart][car_id] ||= 0
    session[:cart][car_id] += quantity

    redirect_to cart_path, notice: "Item added to cart!"
  end

  def update_item
    car_id = params[:car_id].to_s
    quantity = params[:quantity].to_i

    if session[:cart][car_id]
      session[:cart][car_id] = quantity
    end

    redirect_to cart_path, notice: "Cart updated!"
  end

  def remove_item
    car_id = params[:car_id].to_s

    session[:cart].delete(car_id)

    redirect_to cart_path, notice: "Item removed from cart!"
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end
end
