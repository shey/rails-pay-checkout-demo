# README

## Pay, Stripe and Rails Subscription Billing Sample App


### Installation and Configuration
1. config/initializers/stripe.rb
1. config/initializers/pay.rb
1. app/models/user.rb

### Pay Tables and The Work You Don't Have To Do
#### bin/rails pay:install:migrations
* pay_customers
* pay_subscriptions
* pay_charges
* pay_webhooks
* pay_merchants
* pay_payment_methods

#### payment_processor
By including pay_customer in the User model, the gem internally associates a User with the pay_customer model via the owner_type and owner_id fields.

### Plans and Prices
1. app/models/plan.rb

### The One (and a half) Controller
app/controllers/checkouts_controller.rb

### Success, Redirects, and Syncing

### The One Webhook
app/services/payment_succeded_handler.rb

### Related Articles

https://github.com/pay-rails/pay/blob/main/docs/1_installation.md

https://github.com/pay-rails/pay/blob/main/docs/1_installation.md

https://github.com/pay-rails/pay/blob/main/docs/stripe/8_stripe_checkout.md#how-to-use-stripe-checkout-with-pay

https://github.com/pay-rails/pay/blob/main/docs/7_webhooks.md

https://github.com/pay-rails/pay/blob/main/docs/stripe/5_webhooks.md
