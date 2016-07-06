class ChargesController < ApplicationController

	def new
	end

	def create
	  # Amount in cents
	  @amount = (params[:amount].to_i * 100) #custom amount converted to cents

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

	  if charge
	  	rental = Rental.find(params[:rental])
	  	rental.status = 'closed'
	  	rental.save
	  	redirect_to(:back)
	  end

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end

end
