class Victim < ActiveRecord::Base
  validates_presence_of :name, :url, :selector, :interval, :last_visit
  validates_uniqueness_of :name
  
  has_many :visits, :dependent => :destroy
  
  default_scope order("name ASC")

  class << self
    def visitable 
      all.select { |victim| Time.now > (victim.last_visit + victim.interval) }
    end
  end
  
  def visit!
    curl  = Curl::Easy.perform(url)
    html  = Nokogiri::HTML(curl.body_str)
    value = from_selector(html, selector)
    
    Visit.create :victim_id => id, :value => value, :status => curl.response_code
  ensure
    update_attribute(:last_visit, Time.now)
  end
  
  private
  
    def from_selector html, selector
      html.css(selector).inner_text.gsub(/[^0-9]/,'').to_f
    end

end
