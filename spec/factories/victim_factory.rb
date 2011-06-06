Factory.define :victim do |v|
  v.sequence(:name) { |n| "I Will Stalk You #{n}" }
  v.url "http://www.sketch.com/"
  v.selector '.hero h1 strong:eq(1)'
  v.victim_type Victim::VALID_TYPES.first
  v.association :user, :factory => :user
end

Factory.define :numeric_victim, :class => NumericVictim, :parent => :victim do |v|
end

Factory.define :list_victim, :class => ListVictim, :parent => :victim do |v|
end