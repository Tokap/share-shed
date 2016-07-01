class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.integer   :base_price, null: false
      t.boolean   :available, null: false, default: true
      t.integer   :owner_id, null: false

      t.timestamps null: false
    end
  end
end
