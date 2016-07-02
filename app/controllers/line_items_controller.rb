class LineItemsController < ApplicationController


  def create
    @line_item = LineItem.new(line_item_params)
    if current_user.rented_rentals.draft.first.line_items << @line_item
      @tool = @line_item.tool
      flash[:notice]= "This tool has been added to your rental request."
      redirect_to tool_path(@tool)
    else
      @rental = Rental.new
      @tool = @line_item.tool
      render "tools/show"
    end
  end


  def destroy
    @line_item = LineItem.find(params[:id])
    @rental = @line_item.rental
    @line_item.destroy
    redirect_to rental_path(@rental)
  end

  def line_item_params
    params.require(:line_item).permit(:tool_id)
  end

end
