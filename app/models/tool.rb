class Tool < ActiveRecord::Base
  validates :abstract_tool, :owner, :base_price, presence: true
  validates :base_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # just numericality: true

  belongs_to :abstract_tool

  has_many :line_items, dependent: :destroy
  belongs_to :owner, class_name: "User"

  has_many :tool_tags, dependent: :destroy
  has_many :tags, through: :tool_tags

  has_attached_file :image,
                    styles: { small: "64x64", med: "100x100", large: "200x200" }
                    # ,
                    # storage: :s3,
                    # bucket: "please-freaking-work-this-time",
                    # s3_credentials: {access_key_id: ENV['AWS_KEY'],
                    # secret_access_key: ENV['AWS_SECRET']}

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def name
  	abstract_tool.name
  end

  def distance_from_address(address)
    GoogleDirections.new(address, owner.address).distance_in_miles
  end

end
