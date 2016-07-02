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
      flash[:notice]= "Your rental request has been successfully submitted."
      redirect_to tool_path(@tool)
    else
      render "tools/show"
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end



  private

  def rental_params
    params.require(:rental).permit(:checkout_date, :return_date)
  end

end
