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

  has_many :received_reviews, foreign_key: :reviewee_id, class_name: "Review"
  has_many :given_reviews, foreign_key: :reviewer_id, class_name: "Review"


  def zip_code
    regex = /\d{5}/i
    regex2 = /\s\d{5}/i #looks for leading whitespace followed by 5 digits
    zip = regex2.match(address)
    return zip.to_s.to_i
    # need to turn match data to a string before into an integer
  end

  def reviewed_user?(user)
    given_reviews.any? {|review| review.reviewee == user}
  end

  def has_rental_history_with?(user)
    rented_from = rented_rentals.any? do |rental|
      (["scheduled", "in_progress", "returned", "closed"].include?(rental.status)) && rental.owner == user
    end
    rented_to = owned_rentals.any? do |rental|
      (["scheduled", "in_progress", "returned", "closed"].include?(rental.status)) && rental.renter == user
    end
    rented_from || rented_to
  end

  def has_draft_rental?
    rented_rentals.draft.any?
  end

  def average_rating
    total = received_reviews.average(:rating)
    if total == nil
      return "N/A"
    else
      return total.round(2)
    end
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

  def rentals_requiring_attention
    total_rentals = rented_rentals + owned_rentals
    total_rentals.select! do |rental|
      (rental.renter == self && rental.status == "draft") ||
      (rental.owner == self && rental.status == "pending") ||
      (rental.owner == self && rental.status == "scheduled" && rental.checkout_date == Date.today && !rental.owner_pick_up_confirmation) ||
      (rental.renter == self && rental.status == "scheduled" && rental.checkout_date == Date.today && !rental.renter_pick_up_confirmation) ||
      (rental.owner == self && rental.status == "in_progress" && rental.return_date == Date.today && !rental.owner_return_confirmation) ||
      (rental.renter == self && rental.status == "in_progress" && rental.return_date == Date.today && !rental.renter_return_confirmation) ||
      (rental.renter == self && rental.status == "returned")
    end
    total_rentals
  end

end
