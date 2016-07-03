class RentalsController < ApplicationController

  def create
    @tool = Tool.find(params[:rental][:tool_id])
    @rental = Rental.new(rental_params)
    @rental.owner = @tool.owner
    @rental.renter = current_user
    if @rental.valid?
      line_item = LineItem.new(tool: @tool)
      @rental.line_items << line_item
      @rental.save
      flash[:notice]= "This tool has been added to your rental request with #{@rental.owner.username}"
      redirect_to tool_path(@tool)
    else
      render "tools/show"
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.status == "draft"
      @rental.status = "pending"
      flash[:notice] = "Your request has been submitted for approval"
    elsif @rental.status == "pending"
      @rental.update(rental_params)
      @rental.status = "scheduled"
    elsif @rental.status == "scheduled"
      if current_user == @rental.owner
        @rental.update(owner_pick_up_confirmation: true)
      elsif current_user == @rental.renter
        @rental.update(renter_pick_up_confirmation: true)
      end
      @rental.status = "in_progress" if @rental.owner_pick_up_confirmation && @rental.renter_pick_up_confirmation
    end
    @rental.save
    redirect_to dashboard_path(current_user)
  end



  private

  def rental_params
    params.require(:rental).permit(:checkout_date, :return_date, :pickup_time, :pickup_end_time)
  end

end
