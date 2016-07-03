class LineItem < ActiveRecord::Base
  validates :tool, :rental, presence: true

  belongs_to :tool
  belongs_to :rental

  def checkout_date
    rental.checkout_date
  end

  def return_date
    rental.return_date
  end

end
