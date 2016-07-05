class ToolTag < ActiveRecord::Base
	belongs_to :tool
	belongs_to :tag
end
