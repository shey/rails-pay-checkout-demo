Rails.configuration.stripe = {
  public_key: ENV['STRIPE_PUBLIC_KEY'],
  private_key: ENV['STRIPE_PRIVATE_KEY'],
  signing_secret: ENV['STRIPE_SIGNING_SECRET']
}

Stripe.api_version            = '2023-10-16'
Stripe.api_key                = Rails.configuration.stripe[:private_key]
Stripe.log_level              = Stripe::LEVEL_INFO
Stripe.max_network_retries    = 1
Stripe.enable_telemetry       = false
