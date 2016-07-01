class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer   :tool_id, null: false
      t.integer   :rental_id, null: false

      t.timestamps(null: false)
    end
  end
end
