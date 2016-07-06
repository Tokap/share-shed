class AbstractToolsController < ApplicationController

  def index
    all_abstract_tools_in_db = AbstractTool.order(:name)
    @available_abstract_tools = all_abstract_tools_in_db.select { |category| category.tools.length > 0 }
    @available_abstract_tools.reject! {|tool| tool.tools.all? {|tool_instance| !tool_instance.available}}
    @top_5_tags = Tag.top5
  end


  def show
    @abstract_tool = AbstractTool.find(params[:id])
    @all_tools = @abstract_tool.tools.order(:base_price)
    @tools = []
    @all_tools.each do |tool|
    	@tools << tool if tool.owner != current_user
    end
    if current_user
      @tools_ordered_by_distance = @tools.sort do |tool1, tool2|
        tool1.distance_from_address(current_user.address) <=> tool2.distance_from_address(current_user.address)
      end
    end
  end

end
