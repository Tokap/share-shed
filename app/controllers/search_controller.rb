class SearchController < ApplicationController

	def index
		p params
		@tag = Tag.find_by(name: params[:name])
		@tag.tool.each 

	end
end