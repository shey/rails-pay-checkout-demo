class User < ApplicationRecord
  ################################
  ## Stripe/Payments
  ################################
  pay_customer default_payment_processor: :stripe
end
