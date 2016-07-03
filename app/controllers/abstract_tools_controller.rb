class AbstractToolsController < ApplicationController

  def index
    all_abstract_tools_in_db = AbstractTool.all
    @available_abstract_tools = all_abstract_tools_in_db.select { |category| category.tools.length > 0 }
    @available_abstract_tools.reject! {|tool| tool.tools.all? {|tool_instance| !tool_instance.available}}
  end


  def show
    @abstract_tool = AbstractTool.find(params[:id])
    @tools = @abstract_tool.tools
  end

end
