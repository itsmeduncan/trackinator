# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


Victim.create(:name => 'Github People', :url => "https://github.com", :selector => '.hero h1 strong:eq(1)')
Victim.create(:name => 'Github Repos', :url => "https://github.com", :selector => '.hero h1 strong:eq(2)')