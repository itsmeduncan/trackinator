class NumericVictim < Victim
  def visit!
    curl  = Curl::Easy.perform(url)
    html  = Nokogiri::HTML(curl.body_str)
    value = from_selector(html, selector)

    status = value.blank? ? 404 : curl.response_code

    Visit.create :victim_id => id, :value => value.to_f, :status => status
  ensure
    update_attribute(:last_visit, Time.now)
  end
end