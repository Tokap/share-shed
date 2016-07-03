class LineItemLog < ActiveRecord::Base
  belongs_to :rental

  def abstract_tool.name
    return name
  end
end
