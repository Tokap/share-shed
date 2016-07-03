class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.integer   :renter_id, null: false
      t.integer   :owner_id, null: false
      t.string    :status, null: false
      t.date      :checkout_date
      t.date      :return_date
      t.integer   :rental_price

      t.timestamps(null: false)
    end
  end
end
