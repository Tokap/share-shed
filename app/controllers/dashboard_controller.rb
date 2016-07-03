class DashboardController < ApplicationController

  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	if @user == current_user
    	@renter_rentals = Rental.where(user: @user)
    else
    	redirect_to root_path
    end
  end

  def index

  end

end
