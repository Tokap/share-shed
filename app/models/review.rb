class Review < ActiveRecord::Base
  validates :rating, :content, :reviewer, :reviewee, presence: true
  validates_length_of :content, maximum: 160

  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewee, class_name: "User"

end
