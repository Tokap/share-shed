class User < ActiveRecord::Base

  has_many :tools, foreign_key: :owner_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tools, foreign_key: :owner_id
  has_many :owned_rentals, class_name: :Rental, foreign_key: :owner_id
  has_many :owned_line_items, through: :owned_rentals, source: :line_items

  has_many :rented_rentals, class_name: :Rental, foreign_key: :renter_id
  has_many :rented_line_items, through: :rented_rentals, source: :line_items
  has_many :rented_tools, through: :rented_line_items, source: :tool


# These sums currently work as if the base_price is a flat rate.
# Once logic is implimented to determine the duration of the rental,
# a multiplyer should be added

  def zip_code
    regex = /\d{5}/i
    regex2 = /\s\d{5}/i #looks for leading whitespace followed by 5 digits
    zip = regex2.match(address)
    return zip.to_s.to_i
    # believe it or not, you need to turn
    # the match data to a string before you can
    # turn it into an integer
  end

  def has_draft_rental?
    rented_rentals.draft.any?
  end

  def owner_sum_all_tools
    tool_prices = []
    tools.each do |tool|
      tool_prices << tool.base_price
    end
    tool_prices.reduce(:+)
  end

  def owner_sum_rented_tools
    tool_prices = []
    tools.each do |tool|
      tool_prices << tool.base_price if tool.available == false
    end
    tool_prices.reduce(:+)
  end

  def owner_sum_inactive_tools
    tool_prices = []
    tools.each do |tool|
      tool_prices << tool.base_price if tool.available == true
    end
    tool_prices.reduce(:+)
  end

  def renter_sum_rented_tools
    tool_prices = []
    rented_tools.each do |tool|
      tool_prices << tool.base_price
    end
    tool_prices.reduce(:+)
  end

end
