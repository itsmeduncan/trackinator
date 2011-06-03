module VictimsHelper
  
  def data_array victim
    victim.successful_visits.collect do |visit|
      [visit.created_at.to_i * 1000, visit.value]
    end
  end

end
