class PayPalClient
  def create_payment(total, user)
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest.new
    request.prefer("return=representation")
    request.request_body({
      intent: "CAPTURE",
      purchase_units: [
        {
          amount: {
            currency_code: "CAD", # Para o Canadá
            value: total.to_s,
          },
          description: "Payment by #{user.email}",
        },
      ],
      application_context: {
        return_url: Rails.application.routes.url_helpers.success_payment_url,
        cancel_url: Rails.application.routes.url_helpers.cancel_payment_url,
      },
    })

    response = client.execute(request)
    {
      status: response.result.status,
      approval_url: response.result.links.find { |link| link.rel == "approve" }.href,
    }
  rescue PayPalHttp::HttpError => e
    { status: "FAILED", error: e.result }
  end

  def capture_payment(payment_id)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(payment_id)
    response = client.execute(request)
    { status: response.result.status }
  rescue PayPalHttp::HttpError => e
    { status: "FAILED", error: e.result }
  end

  private

  def client
    environment = PayPal::SandboxEnvironment.new(
      Rails.application.credentials.dig(:paypal, :client_id),
      Rails.application.credentials.dig(:paypal, :client_secret)
    )
    @client ||= PayPal::PayPalHttpClient.new(environment)
  end
end
