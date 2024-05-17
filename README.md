# rails-pay-checkout-demo

## Stripe Checkout
**Stripe Checkout,** Stripe Checkout is a checkout flow where Stripe hosts the payments page that collects the credit card details.

### The sequence of events for Stripe Checkout are:
1. A checkout session is created.
1. The user is redirected to Stripe's payment page.
1. The user completed a payment on Stripe's page.
1. The user is redirected back to the app.
1. The app receives a "payment success" webhook from Stripe.

### Products and Prices
[Products](https://dashboard.stripe.com/products) and prices are used manage subscription billing. In this app, each plan is its own product, and each product has a single [price](app/controllers/checkouts_controller.rb).

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
[user.rb](app/models/user.rb)

#### Pay Tables
`bin/rails pay:install:migrations`

#### payment_processor
By including `pay_customer` in the User model, the Pay gem creates an internal association between the User and the pay_customer model. This is done using the `owner_type` and `owner_id` fields-- `payment_processor` serves as the entry point for all billing information.


### Redirect controller
#### Checkout Url Generator
```ruby
def checkout
  user.payment_processor.checkout(
    mode: "subscription",
    line_items: stripe_price_id,
    success_url: success_url,
    billing_address_collection: "auto",
    allow_promotion_codes: false,
  )
end
```
Stripe redirects back to 'success_url' with 'session_id' query param after the transaction is completed.

### Webhook

#### Payment Succeed
Using the "stripe.invoice.payment_succeeded" [event](https://github.com/pay-rails/pay/tree/main/test/pay/stripe/webhooks) handler to update a user's attributes.

```ruby
class PaymentSucceededHandler
  def call(event)
    pay_charge = Pay::Stripe::Charge.sync(
      event.data.object.charge,
      stripe_account: event.try(:account)
    )
    return if pay_charge.nil?

    adjust_user(pay_charge)
  end

  def adjust_user(pay_charge)
    user = pay_charge.customer.owner
    user.update!(updated_at: Time.zone.now)
  end
end
```

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
