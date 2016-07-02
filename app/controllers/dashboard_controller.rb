class DashboardController < ApplicationController

  def show
  	@user = User.find(params[:id])
    @rental = Rental.where(user: @user)
  end

  def index

  end

end
