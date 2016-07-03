class ToolsController < ApplicationController

  def new
    @tool = Tool.new
    @abstract_tools_options = AbstractTool.all.map { |ab_tool| [ab_tool.name, ab_tool.id]}
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.owner_id = current_user.id
    @tool.abstract_tool_id = params[:abstract_tool_id]
    if @tool.save
      redirect_to(@tool)
    else
      @abstract_tools_options = AbstractTool.all.map { |ab_tool| [ab_tool.name, ab_tool.id]}
      render 'new'
    end
  end

  def show
    @tool = Tool.find(params[:id])
    @rental = Rental.new
    @line_item = LineItem.new
    @distance = GoogleDirections.new('3966 Cleveland Ave, San Diego', '707 Broadway, San Diego')

  end

  def edit
    @tool = Tool.find(params[:id])
    @abstract_tools_options = AbstractTool.all.map { |ab_tool| [ab_tool.name, ab_tool.id]}
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update(tool_params)
      redirect_to(@tool)
    else
      @abstract_tools_options = AbstractTool.all.map { |ab_tool| [ab_tool.name, ab_tool.id]}
      render 'edit'
    end
  end

  def destroy
    target_tool = Tool.find(params[:id])
    related_line_items = LineItem.where(tool: target_tool)
    # @rentals_where_tool_is_only_item = []
    
    related_line_items.each do |li|
      li.rental.destroy if li.rental.status != "closed" && li.rental.line_items.length == 1
    end
    # @rentals_where_tool_is_only_item.each do |rental|
    #   rental.destroy
    # end
    target_tool.destroy
    redirect_to "/dashboard/#{current_user.id}"
  end

  def tool_params
    params.require(:tool).permit(:model_number, :description, :base_price, :abstract_tool_id, :image)
  end

end
