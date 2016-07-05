class Tag < ActiveRecord::Base
	validates :name, uniqueness: true
	has_many :tool_tags
	has_many :tools, through: :tool_tags

  def self.top5
    tags = Tag.all
    top5 = tags.sort { |tag1, tag2| tag2.tools.length <=> tag1.tools.length }.shift(5)
  end
end
