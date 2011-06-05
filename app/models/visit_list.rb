class VisitList < ActiveRecord::Base
  belongs_to :victim

  serialize :list
end
