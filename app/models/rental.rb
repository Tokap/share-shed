class Rental < ActiveRecord::Base
  validates :renter, :owner, :return_date, :checkout_date, :status, presence: true
  validates_uniqueness_of :renter, conditions: -> { draft }

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

  def total_tool_price
    #figure out date-time logic and add multiplyer
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

end
