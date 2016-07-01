class CreateAbstractTools < ActiveRecord::Migration
  def change
    create_table :abstract_tools do |t|
      t.string    :name, null: false

      t.timestamps   null: false
    end
  end
end
