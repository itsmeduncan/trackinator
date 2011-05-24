Factory.define :visit do |v|
  v.status 200
  v.value 100_000
  v.association :victim, :factory => :victim
end