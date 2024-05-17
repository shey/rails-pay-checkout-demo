# rails-pay-checkout-demo

## Stripe Checkout
**Stripe Checkout,** Stripe Checkout is a checkout flow where Stripe hosts the payments page that collects the credit card details.

### The sequence of events for Stripe Checkout are:
1. Create a checkout session.
1. Redirect the user to Stripe's payment page.
1. Handle the redirect back to the app.
1. Manage the payment event webhook.

### Products and Prices
Stripe has introduced [products](https://dashboard.stripe.com/products) and prices as a way to manage subscription billing. In this demo, each plan is its own product, and each product has a price and only [one price](app/controllers/checkouts_controller.rb).

![Stripe Product Catalogue Page](docs/product-catalogue.png)

## The Pay Integration
There are four primary integration points between Pay and Rails:

1. Initializers.
1. User model.
1. Redirect controller.
1. Webhook Handler.

### Initializers
1. [stripe.rb](config/initializers/stripe.rb)
1. [pay.rb](config/initializers/pay.rb)

#### Stripe Credentials
Use Pay's configuration [instructions](https://github.com/pay-rails/pay/blob/main/docs/2_configuration.md#configuring-pay).

### User Model
1.`bin/rails pay:install:migrations`
1. [user.rb](app/models/user.rb)

#### payment_processor
By including pay_customer in the User model, the gem internally associates a User with the pay_customer model via the owner_type and owner_id fields.


### Redirect controller
Stripe redirects back to 'success_url' with 'session_id' query param from stripe.


### Webhook

#### Payment Succeed
Using the "stripe.invoice.payment_succeeded" to update user, etc.


#### stripe-cli
The [stripe-cli](https://docs.stripe.com/stripe-cli) is used to trigger events and test the webhook integration (locally). Download, install, and setup stripe-cli to work with your account.

#### Running the CLI
Run `stripe listen --forward-to localhost:3000/pay/webhooks/stripe`

![stripe events](docs/events.png)

### Files Modified for the Integration
1. [landing page](app/views/static/home.html.erb)
1. [checkouts controller](app/controllers/checkouts_controller.rb)
1. [url options](config/environments/development.rb)
1. [stripe checkouk url generator](app/services/stripe_checkout.rb)
1. [payment event handler](app/services/payment_succeded_handler.rb)
1. [pay.rb](config/initializers/pay.rb)
1. [stripe.rb](config/initializers/stripe.rb)

## Related Articles
1. [stripe-checkout](https://github.com/pay-rails/pay/blob/3f860ad490ce91b1b1d0ed3d11147d163b9fda80/docs/stripe/8_stripe_checkout.md)
1. [Routes and Webhooks](https://github.com/pay-rails/pay/blob/main/docs/7_webhooks.md)
1. [Stripe Webhooks](https://github.com/pay-rails/pay/blob/main/docs/stripe/5_webhooks.md)
