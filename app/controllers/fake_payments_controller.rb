class FakePaymentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_user.orders.last # Simula o último pedido criado
  end

  def confirm
    order = current_user.orders.last
    order.update!(status: "paid") # Marca o pedido como "pago"
    redirect_to user_profile_path, notice: "Fake Payment confirmed! Your order is now marked as paid."
  end

  def cancel
    redirect_to checkout_path, alert: "Fake Payment was canceled. Please try again."
  end
end
