module ApplicationHelper

  def pretty_time datetime
    datetime.strftime("%D %R")
  rescue Exception
    ""
  end

end
