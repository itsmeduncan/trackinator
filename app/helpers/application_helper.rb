module ApplicationHelper

  def pretty_time datetime
    datetime.strftime("%D %R")
  end
  
  def editable?
    ["development", "test"].include?(Rails.env)
  end
  
end
