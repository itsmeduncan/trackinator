Factory.define :victim do |v|
  v.sequence(:name) { |n| "I Will Stalk You #{n}" }
  v.url "http://www.sketch.com/"
  v.selector '.hero h1 strong:eq(1)'
end