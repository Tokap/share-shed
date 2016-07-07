class Review < ActiveRecord::Base
  validates :rating, :content, :reviewer, :reviewee, presence: true
  validates_length_of :content, maximum: 320

  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewee, class_name: "User"

  def stars
    stars = ""
    rating.times do
      stars << "\u2605".encode
    end
    stars
  end

end
