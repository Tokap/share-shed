class Rental < ActiveRecord::Base
  validates :renter, :owner, :return_date, :checkout_date, :status, presence: true
  validates_uniqueness_of :renter, conditions: -> { draft }

  enum status: { draft: 0, pending: 1, scheduled: 2, in_progress: 3, returned: 4, closed: 5}

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

  def duration
    ((return_date - checkout_date)/ 86400).ceil
  end

  def pending?
    status == "pending"
  end

  def draft?
    status == 'draft'
  end

  #add boolean producing verifications for rest of status possibilities if group approves
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
