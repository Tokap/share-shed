class DashboardController < ApplicationController

  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
    if @user == current_user
      @owned_tools = @user.tools
      @owned_rentals = @user.owned_rentals
      @rented_rentals = @user.rented_rentals
      # select only open rental requests
      @open_owned_rentals = @owned_rentals.reject { |rental| rental.closed? || rental.draft? }
      @open_rented_rentals = @rented_rentals.reject { |rental| rental.closed? }
      # select only closed rental requests
      @all_closed_rentals = []
      @owned_rentals.each do |rental|
        @all_closed_rentals << rental if rental.closed?
      end
      @rented_rentals.each do |rental|
        @all_closed_rentals << rental if rental.closed?
      end
      @received_reviews = @user.received_reviews
      @users_shared_with = User.all.select {|user| @user.has_rental_history_with?(user)}
    else
    	redirect_to root_path
    end
  end

  def index
  end

end
