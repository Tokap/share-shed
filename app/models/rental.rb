class Rental < ActiveRecord::Base
  validates :renter, :owner, :status, presence: true

  belongs_to :renter, class_name: "User"
  belongs_to :owner, class_name: "User"
  has_many :line_items
  has_many :tools, through: :line_items

  def total_tool_price
    #figure out date-time logic and add multiplyer
    tool_prices = []
    tools.each do |tool|
      tool_prices << tool.base_price
    end
    tool_prices.reduce(:+)
  end

  def pending?
    status == "pending"
  end

end
