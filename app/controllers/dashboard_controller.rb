class DashboardController < ApplicationController

  def show
  	@user = User.find(params[:id])
    @owned_rentals = @user.owned_rentals
    @rented_rentals = @user.rented_rentals
  end

  def index

  end

end
