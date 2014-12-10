class ChargesController < ApplicationController
def create

  # Creates a Stripe Customer object, for associating
  # with the charge
  customer = Stripe::Customer.create(
    email:  current_user.email,
    card: params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: Rails.configuration.stripe[:amount],
    description: "Blocipedia Premium Membership, - #{current_user.email}",
    currency: 'usd'
  )

  flash[:success] = "Thank you for upgrading your Membership, #{current_user.email}"
  redirect_to wikis_path

  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This 'rescue block' catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

   def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia Premium Membership, - #{current_user.email}",
     amount: Rails.configuration.stripe[:amount]
   }
 end
end