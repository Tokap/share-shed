class DashboardController < ApplicationController

  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	if @user == current_user
    	@rented_rentals = Rental.where(renter: @user).order('status DESC')
    	#rentals ordered by status
    else
    	redirect_to root_path
    end
  end

  def index

  end

end
