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

  def delete
  end

  def tool_params
    params.require(:tool).permit(:model_number, :description, :base_price, :abstract_tool_id)
  end

end
