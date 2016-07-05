class AbstractToolsController < ApplicationController

  def index
    all_abstract_tools_in_db = AbstractTool.all
    @available_abstract_tools = all_abstract_tools_in_db.select { |category| category.tools.length > 0 }
    @available_abstract_tools.reject! {|tool| tool.tools.all? {|tool_instance| !tool_instance.available}}
    @top_5_tags = Tag.top5
  end


  def show
    @abstract_tool = AbstractTool.find(params[:id])
    @all_tools = @abstract_tool.tools
    @tools = []
    @all_tools.each do |tool|
    	@tools << tool if tool.owner != current_user
    end
  end

end
