class DashboardController < ApplicationController

  def show
  	@user = User.find(params[:id])

  end

  def index

  end

end
