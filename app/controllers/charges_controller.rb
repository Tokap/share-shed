class ChargesController < ApplicationController

	def new
	end

	def create
	  # Amount in cents

	  # Get the current_user's in-progress rentals, get the one that was sent in hidden field of form
	  # Check the rental amount against the amount sent in to charge
	  @rental = Rental.find(params[:rental_id])	
	  calculated_total = (@rental.sum_logs * @rental.duration)
	  sent_total = params[:amount]

		if @rental.renter == current_user && calculated_total.to_i == sent_total.to_i

		  @amount = (params[:amount].to_i * 100) #custom amount converted to cents

		  if send_stripe_charge
		  	redirect_to(:back)
		  else
		  	redirect_to root_path
		  end
		else
			#render 'you changed the DOM' page
		end
	
	end

	private
	def send_stripe_charge
	  begin
		  customer = Stripe::Customer.create(
		    :email => params[:stripeEmail],
		    :source  => params[:stripeToken]
		  )

		  charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => @amount,
		    :description => 'Share Shed Transaction',
		    :currency    => 'usd'
		  )

			return true

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to new_charge_path
		end
	end

end