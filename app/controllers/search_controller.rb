class SearchController < ApplicationController

	def index
		 @top_5_tags = Tag.top5
		if params[:type] == "tag"
			@tag = Tag.find_by(name: params[:name])
			@results = ToolTag.where(tag: @tag)
			# @results.map {|tt| tt if tt.tool.available}
		else
			@results = []
			name = "%#{params[:name]}%"
			@atools = AbstractTool.where("name like ?", name)
			if !@atools.nil?
				@atools.each do |atool|
					atool.tools.each do |tool_object|
						@results << tool_object if tool_object.available
					end
				end
			else
				@results = nil
			end
		end
	end

end
