class AbstractTool < ActiveRecord::Base
  validates :name, presence: true

  has_many :tools
end
