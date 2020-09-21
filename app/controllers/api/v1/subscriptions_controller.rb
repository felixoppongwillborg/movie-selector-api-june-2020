class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  def create
    payment_status = perform_stripe_payment
    if payment_status[:paid] == true
      current_user.update_attribute(:subscriber, true)
      render json: { paid: true, message: "Successful payment, you are now a subscriber." }
    else
      render json: { paid: false, message: "Payment did not go through"}, status: 400
    end
  end

private

  def perform_stripe_payment
      customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken],
      description: 'Movie Selector'
    )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 2900,
      currency: 'sek'
    )
    charge 
  end
end
