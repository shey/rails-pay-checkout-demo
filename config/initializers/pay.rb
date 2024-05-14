Pay.setup do |config|
  config.support_email = "happy@acme.test"
  config.application_name = "demo"
  config.business_name = "demo"
end

ActiveSupport.on_load(:pay) do
  Pay::Webhooks.delegator.subscribe "stripe.invoice.payment_succeeded", PaymentSucceededHandler.new
end
