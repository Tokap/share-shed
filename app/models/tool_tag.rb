class ToolTag < ActiveRecord::Base
  validates :tool, :tag, presence: true

	belongs_to :tool
	belongs_to :tag
end
