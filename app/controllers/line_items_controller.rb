class LineItemsController < ApplicationController


  def create
    @line_item = LineItem.new(line_item_params)
    if current_user.rented_rentals.draft.first.line_items << @line_item
      @tool = @line_item.tool
      flash[:notice]= "<p>This tool has been added to your rental from #{@line_item.rental.owner.username}. Click <a href='/users/#{@line_item.rental.owner.id}'>here</a> to shop for more tools from them. Click <a href='/rentals/#{@line_item.rental.id}'>here</a> to review your finalized request</p></p>"
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
    if @rental.line_items.empty?
      @rental.destroy
      redirect_to dashboard_path(current_user)
    else
      redirect_to rental_path(@rental)
    end
  end

  def line_item_params
    params.require(:line_item).permit(:tool_id)
  end

end
