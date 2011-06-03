module VictimsHelper
  
  def data_array victim
    victim.visits.collect do |visit|
      [visit.created_at.to_i * 1000, visit.value]
    end
  end
  
  def pretty_time datetime
    datetime.strftime("%D %R")
  end
  
end
