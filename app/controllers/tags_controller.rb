class TagsController < ApplicationController

	def new
	end

	def create
		# check to see if tag exists first...
		# creates tag new tag if it doesn't exist
		@tool = Tool.find(params[:tool])
		tag_names = params[:tag][:name].split(/\s*,\s*/)
	 tag_names.each do |tag_name|
	 	 tag = Tag.find_by(name: tag_name.downcase)
	 	 if tag.nil?
		   tag = Tag.create(name: tag_name.downcase)
		   ToolTag.create(tag: tag, tool: @tool)
		 else
		   ToolTag.create(tag: tag, tool: @tool)
		 end
	 end
	 redirect_to(@tool) 
	end

	def index

	end

end