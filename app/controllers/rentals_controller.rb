class RentalsController < ApplicationController

  def create
    @tool = Tool.find(params[:rental][:tool_id])
    @rental = Rental.new(rental_params)
    @rental.owner = @tool.owner
    @rental.renter = current_user
    if @rental.valid? && @rental.renter != @tool.owner
    # second condition added to keep tool owner from renting from himself.
      line_item = LineItem.new(tool: @tool)
      @rental.line_items << line_item
      @rental.save
      flash[:notice]= "<p>You have created a new rental request with #{@rental.owner.username}.
       Click <a href='/users/#{@rental.owner.id}'>here</a> to shop for more tools from them. Click <a href='/rentals/#{@rental.id}'>here</a> to review your finalized request</p>"
      redirect_to tool_path(@tool)
    else
      flash[:errors]="Please select a valid date range to rent this tool"
      render "tools/show"
    end
  end

  def show
    @rental = Rental.find(params[:id])
    redirect_to root_path unless (@rental.owner == current_user && @rental.status != "draft") || @rental.renter == current_user

    # if @rental.owner == current_user || @rental.renter == current_user
    #   #will populate normally with nothing here
    # else
    #   redirect_to root_path #if you're not involved in the rental, go to root
    # end
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.status == "draft"
      @rental.status = "pending"
      flash[:notice] = "Your request has been submitted for approval"
      email = UserMailer.alert_owner_of_new_request(@rental)
      email.deliver
    elsif @rental.status == "pending"
      @rental.update(rental_params)
      if @rental.valid?
        @rental.status = "scheduled"
        @rental.log_line_items #added to save line item data when info has become permanent
        @rental.set_tools_availability(false)
        email = UserMailer.schedule_tool_pickup(@rental)
        email.deliver
      end
    elsif @rental.status == "scheduled"
      if current_user == @rental.owner
        @rental.update(owner_pick_up_confirmation: true)
        flash[:notice]="You have confirmed the renter picked up the tool(s)"
      elsif current_user == @rental.renter
        @rental.update(renter_pick_up_confirmation: true)
        flash[:notice]="You have confirmed your pickup of the tool(s)"
      end
      @rental.status = "in_progress" if @rental.owner_pick_up_confirmation && @rental.renter_pick_up_confirmation
    elsif @rental.status == "in_progress"
      if current_user == @rental.owner
        @rental.update(owner_return_confirmation: true)
        flash[:notice]="You have confirmed the tool(s) has been returned to you."
      elsif current_user == @rental.renter
        @rental.update(renter_return_confirmation: true)
        flash[:notice]="You have confirmed your return of the tool(s)"
      end
      if @rental.owner_return_confirmation && @rental.renter_return_confirmation
        @rental.status = "returned"
        @rental.status = "closed" if @rental.paid == true
        @rental.set_tools_availability(true)
      end
    end
    if @rental.save
      redirect_to rental_path(@rental)
    else
      render "show"
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.tools.each do |tool|
      tool.available = true
      tool.save
    end
    @rental.destroy
    redirect_to dashboard_path(current_user)
  end

  private

  def rental_params
    params.require(:rental).permit(:checkout_date, :return_date, :pickup_time, :pickup_end_time)
  end

  def user_owns?
    owner == current_user
  end

end
