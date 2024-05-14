# rails-pay-checkout-demo

## Using Pay with Stripe
**Stripe Checkout,** stripe hosts the payments page.

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

#### Credentials
Easiest to configure via the [instructions](https://github.com/pay-rails/pay/blob/main/docs/2_configuration.md#configuring-pay) described in the docs. Once you've saved the credentials, you can verify the setup by running `User.first.payment_processor.customer` in rails console.

### Plans
Plans is a deprecated concept. They've introduced products and prices. The "price_id"
is the relevant field.

### The One (and a half) Controller
app/controllers/checkouts_controller.rb

### Success, Redirects, and Syncing

### The One Webhook
app/services/payment_succeded_handler.rb

### Related Articles
1. https://github.com/pay-rails/pay/blob/main/docs/1_installation.md
1. https://github.com/pay-rails/pay/blob/main/docs/1_installation.md
1. https://github.com/pay-rails/pay/blob/main/docs/stripe/8_stripe_checkout.md#how-to-use-stripe-checkout-with-pay
1. https://github.com/pay-rails/pay/blob/main/docs/7_webhooks.md
1. https://github.com/pay-rails/pay/blob/main/docs/stripe/5_webhooks.md
