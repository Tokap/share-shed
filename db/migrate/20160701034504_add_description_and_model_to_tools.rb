class AddDescriptionAndModelToTools < ActiveRecord::Migration
  def change
    add_column(:tools, :description, :text)
    add_column(:tools, :model_number, :string)
  end
end
