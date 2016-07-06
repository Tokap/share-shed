class AddPaidBoolean < ActiveRecord::Migration
  def change
  	add_column(:rentals, :paid, :boolean, default: false)
  end
end
