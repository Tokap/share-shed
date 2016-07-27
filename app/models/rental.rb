class Rental < ActiveRecord::Base
  validates :renter, :owner, :return_date, :checkout_date, :status, presence: true
  validates_uniqueness_of :renter, conditions: -> { draft }
  validate :return_date_follows_checkout_date
  validate :pickup_end_time_follows_pickup_time
  validate :checkout_date_is_not_in_past, on: :create

  enum status: { draft: 0, pending: 1, scheduled: 2, in_progress: 3, returned: 4, closed: 5}

  belongs_to :renter, class_name: "User"
  belongs_to :owner, class_name: "User"
  has_many :line_items, dependent: :destroy
  has_many :tools, through: :line_items

  has_many :line_item_logs

  def log_line_items
    line_items.each do |li|
      LineItemLog.create(name: li.tool.abstract_tool.name, price: (li.tool.base_price * li.rental.duration), rental: li.rental)
    end
  end

  def sum_logs
    if line_item_logs.empty?
      return 0
    elsif line_item_logs.length == 1
      return line_item_logs.first.price
    else
      line_item_logs.sum(:price)
    end
  end

  def sum_line_items
    total_prices = line_items.map do |li|
      li.tool.base_price * duration
    end
    total_prices.inject(:+)
  end

  def total_tool_price
    tool_prices = []
    tools.each do |tool|
      tool_prices << tool.base_price
    end
    tool_prices << 0
    tool_prices.reduce(:+)
  end

  def set_tools_availability(availability)
    line_items.each do |line_item|
      line_item.tool.available = availability
      line_item.tool.save
    end
  end

  def duration
    (return_date - checkout_date).to_i
  end

  def other_party(user)
    if owner == user
      renter
    elsif renter == user
      owner
    else
      nil
    end
  end

  def return_date_follows_checkout_date
    if checkout_date && return_date
      if checkout_date >= return_date
        self.errors.add(:checkout_date, "must follow return date")
      end
    end
  end

  def pickup_end_time_follows_pickup_time
    if pickup_time && pickup_end_time
      if pickup_end_time <= pickup_time
        self.errors.add(:pickup_end_time, "must follow pickup time")
      end
    end
  end

  def checkout_date_is_not_in_past
    if checkout_date && checkout_date < Date.today
      self.errors.add(:checkout_date, "cannot be in the past")
    end
  end

  def pending?
    status == "pending"
  end

  def draft?
    status == 'draft'
  end

  def scheduled?
    status == "scheduled"
  end

  def in_progress?
    status == "in_progress"
  end

  def returned?
    status == "returned"
  end

  def closed?
    status == "closed"
  end

  def paid?
    paid == true
  end

end
