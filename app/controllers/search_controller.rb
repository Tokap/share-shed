class SearchController < ApplicationController

	def index
		 @top_5_tags = Tag.top5
		 p params
		if params[:type] == "tag"
			@tag = Tag.find_by(name: params[:name])
			@results = ToolTag.where(tag: @tag)
		elsif params[:type] == "tool"
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
		elsif params[:type] == "user"
			name = "%#{params[:name]}%"
			@results = true #gets past initial filter check.
			@user_results = User.where("username ilike ?", "#{name}")
		end
	end

end
