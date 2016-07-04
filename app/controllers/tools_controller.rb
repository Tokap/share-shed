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

    @tags = Tag.where(tool: @tool)
    p @tags
    @tag = Tag.new
  end

  def update
    p params
    tag_names = params[:tags].split(/\s*,\s*/)

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
    
    related_line_items.each do |li|
      li.rental.destroy if (li.rental.pending? || li.rental.draft?) && li.rental.line_items.length == 1
      # Destroy the Rental as well if the Tool being destroyed is part of a Rental with a pending or draft 
      # status and the Tool being destroyed is the last Line Item on that Rental.

      #li.destroy #should we be killing the LI as well?
    end
 
    target_tool.destroy
    redirect_to "/dashboard/#{current_user.id}"
  end

  def tool_params
    params.require(:tool).permit(:model_number, :description, :base_price, :abstract_tool_id, :image)
  end

end
