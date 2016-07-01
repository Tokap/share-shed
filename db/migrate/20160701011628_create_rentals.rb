class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.integer   :renter_id, null: false
      t.integer   :owner_id, null: false
      t.string    :status, null: false
      t.datetime  :checkout_date
      t.datetime  :return_date
      t.integer   :rental_price

      t.timestamps(null: false)
    end
  end
end
