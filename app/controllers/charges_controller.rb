class ChargesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
            
        )
        # current_user.update(customer_id: @customer.id)
        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: 1500,
            description: "Blocipedia Premium Membership - #{current_user.email}",
            currency: 'usd'
        )
        current_user.premium!
        
        flash[:notice] = "Thanks for all the money, #{current_user.email}!"
        
        redirect_to wikis_path
        
        rescue Stripe::CardError => e
            flash[:alert] = e.message
            redirect_to new_charge_path
    end
    
    def new
        @stripe_btn_data = {
            key: "#{ Rails.configuration.stripe[:publishable_key]}",
            description: "Blocipedia Membership - #{current_user.email}",
            amount: 1500
        }
    end
end
