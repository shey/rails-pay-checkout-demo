class CheckoutsController < ApplicationController
  before_action :set_price_id, only: %i[show]

  def show
    redirect_to stripe_checkout_url, allow_other_host: true, status: :see_other
  end

  private

  def stripe_checkout_url
    StripeCheckout.new(user, @stripe_price_id).url
  end

  def user
    User.first
  end

  def set_price_id
    plan_name = params[:plan]
    @stripe_price_id = plan_id_mapping[plan_name]
  end

  def plan_id_mapping
    {
      hobby: "price_1Ow66SAWnWpxHPD5qEZoUi4O",
      professional: "price_1Ow66SAWnWpxHPD5K270wTji",
      enterprise: "price_1Ow66RAWnWpxHPD5xV9xUCyD"
    }
  end
end
