module VictimsHelper

  def victim_types
    Victim::VALID_TYPES.map { |type| [type.titleize, type]}
  end

end
