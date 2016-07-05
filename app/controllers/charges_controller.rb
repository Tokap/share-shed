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

	  # if we update the status before redirecting,
	  # the page will update with options. This would
	  # have to make sense with the flow of the status changes,
	  # so this should certainly be discussed.
	  redirect_to(:back)

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end

end