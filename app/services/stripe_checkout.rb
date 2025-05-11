class StripeCheckout
  include Rails.application.routes.url_helpers

  attr_reader :user, :stripe_price_id

  def initialize(user, stripe_price_id)
    @user = user
    @stripe_price_id = stripe_price_id
  end

  def url
    checkout.url
  end

  private

  def success_url
    root_url
  end

  def checkout
    user.payment_processor.checkout(
      mode: "subscription",
      line_items: stripe_price_id,
      success_url: success_url,
      billing_address_collection: "auto",
      allow_promotion_codes: false
    )
  end
end
