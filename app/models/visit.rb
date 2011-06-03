class Visit < ActiveRecord::Base
  validates_presence_of :value, :status
  
  belongs_to :victim
  
  default_scope order('created_at DESC')
  
  scope :successful, where(:status => 200)

end