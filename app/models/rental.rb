class Rental < ActiveRecord::Base
  validates :renter, :owner, :status, presence: true

  belongs_to :renter, class_name: "User"
  belongs_to :owner, class_name: "User"
  has_many :line_items

end
