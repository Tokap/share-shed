class LineItem < ActiveRecord::Base
  validates :tool, :rental, presence: true

  belongs_to :tool
  belongs_to :rental

end
