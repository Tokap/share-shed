class Tool < ActiveRecord::Base
  validates :abstract_tool, :line_item, :owner, presence: true

  belongs_to :abstract_tool
  belongs_to :line_item
  belongs_to :owner, class_name: "User"
end
