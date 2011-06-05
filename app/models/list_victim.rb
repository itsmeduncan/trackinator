class ListVictim < Victim
  has_one :visit_list, :foreign_key => 'victim_id'

  def visit!
    curl  = Curl::Easy.perform(url)
    html  = Nokogiri::HTML(curl.body_str)
    items = from_selector(html, selector)

    status = items.blank? ? 404 : curl.response_code

    create_visit_list(:list => []) unless visit_list
    previous_items = visit_list.list
    delta = items - previous_items

    Visit.create :victim_id => id, :value => delta, :status => status
    visit_list.update_attributes(:list => items)
  ensure
    update_attribute(:last_visit, Time.now)
  end

  private

    def from_selector html, selector
      html.css(selector).map { |obj| obj.inner_text }
    end
end