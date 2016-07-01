class AddAddressAndUsernameToUsers < ActiveRecord::Migration
  def change
    add_column(:users, :address, :string, null: false)
    add_column(:users, :username, :string, null: false)
  end
end
