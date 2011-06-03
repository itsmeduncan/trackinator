class Victim < ActiveRecord::Base
  validates_presence_of :name, :url, :selector, :interval, :last_visit, :slug
  validates_uniqueness_of :name
  
  has_many :visits, :dependent => :destroy
  
  has_many :successful_visits, :class_name => "Visit", :dependent => :destroy, :conditions => ['status = 200']
  has_many :unsuccessful_visits, :class_name => "Visit", :dependent => :destroy, :conditions => ['status != 200']
  
  default_scope order("name ASC")
  
  VISIBLE_VISITS = 10
  
  before_validation :slugify
  
  class << self
    def visitable 
      all.select { |victim| Time.now > (victim.last_visit + victim.interval) }
    end
    
    def create_from_arguments arguments
      victim = Victim.new(:name => arguments[:name], :url => arguments[:url], :selector => arguments[:selector])
      if victim.save
        Rails.logger.info "Saved #{victim.name}!"
      else
        Rails.logger.error "Failed to save #{victim.name}"
        victim.errors.full_messages.each do |error_message|
          Rails.logger.error error_message
        end
      end
    end
    
    def destroy_from_arguments arguments
      victim = Victim.where(:name => arguments[:name]).limit(1).first
      if victim 
        if victim.destroy
        Rails.logger.info "Destroyed #{victim.name}"
        else
          Rails.logger.error "Failed to destroy #{victim.inspect}"
        end
      else
        Rails.logger.info "No such victim for #{arguments.inspect}"
      end
    end
  end
  
  def visited?
    visits.present?
  end
  
  def displayable?
    visits.present? && successful_visits.present?
  end
  
  def visit!
    curl  = Curl::Easy.perform(url)
    html  = Nokogiri::HTML(curl.body_str)
    value = from_selector(html, selector)
    
    status = value.blank? ? 404 : curl.response_code
    
    Visit.create :victim_id => id, :value => value.to_f, :status => status
  ensure
    update_attribute(:last_visit, Time.now)
  end
  
  def to_param
    slug
  end
  
  private
  
    def slugify
      self.slug = self.name.to_s.downcase.gsub(/[^A-Z0-9]/i, '-')
    end
  
    def from_selector html, selector
      html.css(selector).inner_text.gsub(/[^0-9]/,'')
    end

end
