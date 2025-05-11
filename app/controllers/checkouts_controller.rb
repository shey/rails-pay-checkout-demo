class CheckoutsController < ApplicationController
  before_action :set_price_id, only: %i[show]

  def show
    redirect_to checkout_url, allow_other_host: true, status: :see_other
  end

  private

  def checkout_url
    StripeCheckout.new(user, @stripe_price_id).url
  end

  def user
    User.first
  end

  def set_price_id
    @stripe_price_id = price_id_map[plan_name]
  end

  def plan_name
    params[:plan].to_sym
  end

  def price_id_map
    {
      enterprise: "price_1Ow66SAWnWpxHPD5qEZoUi4O",
      professional: "price_1Ow66SAWnWpxHPD5K270wTji",
      hobby: "price_1Ow66RAWnWpxHPD5xV9xUCyD"
    }
  end
end
