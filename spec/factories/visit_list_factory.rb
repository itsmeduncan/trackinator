Factory.define :visit_list do |v|
  v.list ['a', 'b', 'c']
  v.association :victim, :factory => :victim
end