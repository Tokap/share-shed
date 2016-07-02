class AbstractToolsController < ApplicationController

  def index
    @abstract_tools = AbstractTool.all
  end


  def show
    @abstract_tool = AbstractTool.find(params[:id])
    @tools = @abstract_tool.tools
  end

end
