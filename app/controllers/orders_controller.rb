class OrdersController < ApplicationController
  before_action :authenticate_user! # Ensure only logged-in users can access orders

  def new
    @order = Order.new
    @cart_items = session[:cart] || {}
    @provinces = Province.all
  end

  def create
    @order = current_user.orders.build(order_params)
    @cart_items = session[:cart] || {}

    if @cart_items.blank?
      redirect_to cart_path, alert: "Your cart is empty!"
      return
    end

    # Calculate totals and taxes
    calculate_totals(@order)

    # Add cart items to the order
    @cart_items.each do |car_id, quantity|
      car = Car.find_by(id: car_id)
      if car
        @order.order_items.build(car: car, quantity: quantity, price_at_purchase: car.price)
      end
    end

    if @order.save
      session[:cart] = {} # Clear the cart after checkout
      redirect_to @order, notice: "Order successfully placed!"
    else
      @provinces = Province.all
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:address, :city, :postal_code, :province_id)
  end

  def calculate_totals(order)
    province = Province.find(order.province_id)
    subtotal = @cart_items.sum { |car_id, quantity| Car.find_by(id: car_id)&.price.to_f * quantity }
    order.gst = subtotal * province.gst
    order.pst = subtotal * province.pst
    order.hst = province.hst # Calculated dynamically from GST + PST
    order.total_price = subtotal + order.gst + order.pst + order.hst
  end
end
