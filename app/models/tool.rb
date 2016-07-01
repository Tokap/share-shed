class Tool < ActiveRecord::Base
  validates :abstract_tool, :owner, presence: true

  belongs_to :abstract_tool
  has_many :line_items
  belongs_to :owner, class_name: :User
end
