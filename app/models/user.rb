class User < ActiveRecord::Base

  has_many :tools, foreign_key: :owner_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tools, foreign_key: :owner_id
  has_many :owned_rentals, class_name: :Rental, foreign_key: :owner_id
  has_many :owned_line_items, through: :owned_rentals

  has_many :rented_rentals, class_name: :Rental, foreign_key: :renter_id
  has_many :rented_line_items, through: :rented_rentals
  has_many :rented_tools, through: :rented_line_items

 

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
