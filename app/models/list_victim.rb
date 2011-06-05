class ListVictim < Victim
  has_one :visit_list, :foreign_key => 'victim_id'

  def visit!
    stalk! do |status, items|
      create_visit_list(:list => []) unless visit_list

      previous_items = visit_list.list
      delta = items - previous_items

      Visit.create :victim_id => id, :value => delta, :status => status
      visit_list.update_attributes(:list => items)
    end
  end

  private

    def chart_data_value(visit)
      visit.value.count
    end

end