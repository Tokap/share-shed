class AddPickupTimeAndDropoffTimeToRentals < ActiveRecord::Migration
  def change
    add_column(:rentals, :pickup_time, :time)
    add_column(:rentals, :pickup_end_time, :time)
  end
end
