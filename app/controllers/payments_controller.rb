class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Calcula subtotal e taxas
    subtotal = calculate_total
    taxes = calculate_taxes(subtotal)
    total = subtotal + taxes[:total]

    # Inicializa o pagamento no PayPal
    pay_pal_client = PayPalClient.new
    result = pay_pal_client.create_payment(total, current_user)

    if result[:status] == "CREATED"
      # Redireciona para a página do PayPal
      redirect_to result[:approval_url]
    else
      redirect_to checkout_path, alert: "Failed to initialize PayPal payment: #{result[:error]}"
    end
  rescue StandardError => e
    redirect_to checkout_path, alert: "An error occurred: #{e.message}"
  end

  def success
    # Verifica o pagamento no PayPal
    payment_id = params[:paymentId]
    payer_id = params[:PayerID]

    pay_pal_client = PayPalClient.new
    capture_result = pay_pal_client.capture_payment(payment_id, payer_id)

    if capture_result[:status] == "COMPLETED"
      # Cria o pedido somente após o pagamento ser confirmado
      ActiveRecord::Base.transaction do
        subtotal = calculate_total
        taxes = calculate_taxes(subtotal)

        order = current_user.orders.create!(
          total_price: subtotal + taxes[:total],
          gst: taxes[:gst],
          pst: taxes[:pst],
          status: "paid",
        )

        # Adiciona itens ao pedido
        car_ids = session[:cart].keys
        cars = Car.where(id: car_ids).index_by(&:id)
        session[:cart].each do |car_id, quantity|
          car = cars[car_id.to_i]
          next unless car

          order.order_items.create!(
            car: car,
            quantity: quantity,
            price_at_purchase: car.price,
          )
        end
      end

      # Limpa o carrinho e redireciona para o perfil do usuário
      session[:cart] = {}
      redirect_to user_profile_path, notice: "Payment successful! Your order has been placed."
    else
      redirect_to checkout_path, alert: "Payment was not completed: #{capture_result[:error]}"
    end
  rescue StandardError => e
    redirect_to checkout_path, alert: "An error occurred: #{e.message}"
  end

  def cancel
    redirect_to checkout_path, alert: "Payment was canceled. Your cart is intact."
  end

  private

  def calculate_total
    session[:cart].sum do |car_id, quantity|
      car = Car.find_by(id: car_id)
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
