class ToolsController < ApplicationController

  def show
    @tool = Tool.find(params[:id])
  end

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

  def tool_params
    params.require(:tool).permit(:model_number, :description, :base_price, :abstract_tool_id)
  end

end
