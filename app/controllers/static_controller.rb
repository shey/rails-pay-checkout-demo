class StaticController < ApplicationController
  before_action :set_user, only: %i[home]
  before_action :set_subscription, only: %i[home]

  def home
    if @subscription.present?
      processor_subscription = Stripe::Subscription.retrieve(@subscription.processor_id)
      @price = Stripe::Price.retrieve(processor_subscription.items.data.first.price.id)
    end
  end

  private

  def set_user
    @user = User.first
  end

  def set_subscription
    @subscription = @user.payment_processor.subscriptions.first
  end
end
