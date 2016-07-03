class CreateLineItemLogs < ActiveRecord::Migration
  def change
    create_table :line_item_logs do |t|
      t.string :name 
      t.integer :price
      t.integer :rental_id 

      t.timestamps null: false
    end
  end
end
