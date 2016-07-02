class DashboardController < ApplicationController

  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
    @rental = Rental.where(user: @user)
  end

  def index

  end

end
