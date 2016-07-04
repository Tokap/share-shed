class TagsController < ApplicationController

	def new
	end

	def create
		@tool = Tool.find(params[:tool])
		tag_names = params[:tag][:name].split(/\s*,\s*/)
	 tag_names.each do |tag_name|
	   Tag.create(name: tag_name, tool: @tool)
	 end
	 redirect_to(@tool) 
	end

end