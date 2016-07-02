class ToolsController < ApplicationController

  # def index
  #   @abstract_tool = AbstractTool.find(params[:abstract_tool_id])
  #   @tools = @abstract_tool.tools
  # end

  def show
    @tool = Tool.find(params[:id])
    @rental = Rental.new
  end

end
