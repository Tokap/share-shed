class SearchController < ApplicationController

	def index
		@tag = Tag.find_by(name: params[:name])
		@tool_tags = ToolTag.where(tag: @tag) 
	end

end