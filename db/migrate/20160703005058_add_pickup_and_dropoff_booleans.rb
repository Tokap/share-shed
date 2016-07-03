class AddPickupAndDropoffBooleans < ActiveRecord::Migration
  def change
    add_column(:rentals, :owner_pick_up_confirmation, :boolean, default: false)
    add_column(:rentals, :renter_pick_up_confirmation, :boolean, default: false)
    add_column(:rentals, :owner_return_confirmation, :boolean, default: false)
    add_column(:rentals, :renter_return_confirmation, :boolean, default: false)
  end
end
