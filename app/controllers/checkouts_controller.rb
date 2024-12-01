class CheckoutsController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in
  before_action :initialize_cart

  def show
    @cart_items = session[:cart] || {}
    @total = calculate_total
    @taxes = calculate_taxes(@total)
  end

  def create
    if session[:cart].blank?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    unless current_user.province
      redirect_to edit_user_registration_path, alert: "Please update your address and province before checkout."
      return
    end

    ActiveRecord::Base.transaction do
      subtotal = calculate_total
      taxes = calculate_taxes(subtotal)

      order = current_user.orders.create!(
        total_price: subtotal + taxes[:total],
        gst: taxes[:gst],
        pst: taxes[:pst],
        status: "new",
      )

      car_ids = session[:cart].keys
      cars = Car.where(id: car_ids).index_by(&:id)

      session[:cart].each do |car_id, quantity|
        car = cars[car_id.to_i]
        next unless car # Skip invalid or missing cars

        order.order_items.create!(
          car: car,
          quantity: quantity,
          price_at_purchase: car.price,
        )
      end
    end

    session[:cart] = {} # Clear the cart after checkout
    redirect_to user_profile_path, notice: "Order placed successfully!"
  rescue StandardError => e
    redirect_to checkout_path, alert: "Checkout failed: #{e.message}"
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart_items = session[:cart]
  end

  def calculate_total
    car_ids = @cart_items.keys
    cars = Car.where(id: car_ids).index_by(&:id)

    @cart_items.sum do |car_id, quantity|
      car = cars[car_id.to_i]
      car.present? ? car.price * quantity : 0
    end
  end

  def calculate_taxes(subtotal)
    province = current_user.province
    gst_rate = province&.gst || 0
    pst_rate = province&.pst || 0

    gst = subtotal * gst_rate
    pst = subtotal * pst_rate
    { gst: gst, pst: pst, total: gst + pst }
  end
end
