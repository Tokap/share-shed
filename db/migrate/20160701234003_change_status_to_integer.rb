class ChangeStatusToInteger < ActiveRecord::Migration
  def change
    remove_column(:rentals, :status)
    add_column(:rentals, :status, :integer, null: false, default: 0
      )
  end
end
