module ApplicationHelper

  def pretty_time datetime
    datetime.strftime("%D %R")
  end
  
  # TODO: How to manage this?
  def editable?
    ["development", "test"].include?(Rails.env)
  end
  
end
