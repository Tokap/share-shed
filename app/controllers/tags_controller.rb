class TagsController < ApplicationController

	def new
	end

	def create
		# check to see if tag exists first...
		# creates tag new tag if it doesn't exist
		@tool = Tool.find(params[:tool])
		tag_names = params[:tag][:name].split(/\s*,\s*/) #split on commas and ignore whitespace
	 	tag_names.each do |tag_name|
	 	 tag = Tag.find_or_create_by(name: tag_name.downcase)
		 ToolTag.find_or_create_by(tag: tag, tool: @tool)
		end

	 redirect_to(@tool)
	end

	def index

	end

end