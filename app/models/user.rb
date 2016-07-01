class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tools, foreign_key: :owner_id
  has_many :rentals, foreign_key: :renter_id
  has_many :owned_rentals, foreign_key: :owner_id
  # has_many :line_items, through: :rentals

 

# These sums currently work as if the base_price is a flat rate.
# Once logic is implimented to determine the duration of the rental,
# a multiplyer should be added

  def sum_all_tools
    tool_prices = []
    tools.each do |tool|
      tool_prices << tool.base_price
    end
    tool_prices.reduce(:+)
  end

  def sum_rented_tools
    tool_prices = []
    tools.each do |tool|
      tool_prices << tool.base_price if tool.available == false
    end
    tool_prices.reduce(:+)
  end

  def sum_inactive_tools
    tool_prices = []
    tools.each do |tool|
      tool_prices << tool.base_price if tool.available == true
    end
    tool_prices.reduce(:+)
  end
         
end
