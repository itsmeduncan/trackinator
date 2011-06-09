class Victim < ActiveRecord::Base
  VALID_TYPES = [ 'NumericVictim', 'ListVictim' ]
  VISIBLE_VISITS = 10

  validates_presence_of :name, :url, :selector, :interval, :last_visit
  validates_uniqueness_of :name
  validates_inclusion_of :victim_type, :in => VALID_TYPES

  has_many :visits, :dependent => :destroy

  has_many :successful_visits, :class_name => "Visit", :dependent => :destroy, :conditions => ['status = 200']
  has_many :unsuccessful_visits, :class_name => "Visit", :dependent => :destroy, :conditions => ['status != 200']

  belongs_to :user

  before_update :destroy_visits_if_selector_changed

  class << self
    def visitable 
      all.select { |victim| Time.now > (victim.last_visit + victim.interval) }
    end
    
    def create_from_arguments arguments
      valid_arguments = [:name, :url, :selector, :victim_type]
      victim = Victim.new( arguments.slice(*valid_arguments) )
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
      victim = Victim.where(:name => arguments[:name]).first
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

  def victim_type=(value)
    self[:type] = value
  end

  def victim_type
    self[:type]
  end

  def visited?
    visits.present?
  end
  
  def downloadable?
    false
  end
  
  def displayable?
    visits.present? && successful_visits.present?
  end

  def visit!
    raise NotImplementedError
  end

  def chart_data
    successful_visits.collect do |visit|
      [visit.created_at.to_i * 1000, chart_data_value(visit)]
    end
  end
  
  def editable_by user
    user.nil? ? false : (user_id == user.id)
  end

  private

    def stalk! &block
      curl  = Curl::Easy.perform(url)
      html  = Nokogiri::HTML(curl.body_str)
      value = from_selector(html, selector)

      status = value.blank? ? 404 : curl.response_code

      yield(status, value)
    ensure
      update_attribute(:last_visit, Time.now)
    end

    def chart_data_value(visit)
      raise NotImplementedError
    end

    def from_selector html, selector
      html.css(selector).map { |obj| obj.inner_text }
    end

    def destroy_visits_if_selector_changed
      visits.destroy_all if selector_changed?
    end

end
