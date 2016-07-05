class CreateToolTags < ActiveRecord::Migration
  def change
    create_table :tool_tags do |t|
    	t.integer :tool_id
    	t.integer :tag_id

      t.timestamps null: false
    end
  end
end
