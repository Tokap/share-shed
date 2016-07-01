class AddAbstractToolIdToTools < ActiveRecord::Migration
  def change
    add_column :tools, :abstract_tool_id, :integer, null: false
  end
end
