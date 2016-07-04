class Tag < ActiveRecord::Base
	validates :name, uniqueness: true
	has_many :tool_tags
	has_many :tools, through: :tool_tags
end
