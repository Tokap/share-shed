class AddPickupTimeAndDropoffTimeToRentals < ActiveRecord::Migration
  def change
    add_column(:rentals, :pickup_time, :datetime)
    add_column(:rentals, :dropoff_time, :datetime)
  end
end
