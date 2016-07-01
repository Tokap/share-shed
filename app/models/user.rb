class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tools, foreign_key: :owner_id
  has_many :rentals, foreign_key: :renter_id
  has_many :owned_rentals, foreign_key: :owner_id
  # has_many :line_items, through: :rentals

  def sum_all_tools
    this.tools.each { |curr, prev| curr.base_price + prev.base_price } 
  end

  def sum_rented_tools
  end

  def sum_inactive_tools
  end
         
end
