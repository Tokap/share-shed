class AddPaperclipToTool < ActiveRecord::Migration
  def change
    add_attachment :tools, :image
  end
end
