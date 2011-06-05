class NumericVictim < Victim
  def visit!
    stalk! do |status, value|
      Visit.create :victim_id => id, :value => value.to_f, :status => status
    end
  end
  
  def downloadable?
    true
  end
  
  private

    def chart_data_value(visit)
      visit.value
    end

    # Override the basic selector
    def from_selector html, selector
      super.first.try(:gsub, /[^0-9]/, '')
    end
end