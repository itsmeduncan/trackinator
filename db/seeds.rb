# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user = User.create(:email => 'admin@trackinator.com', :password => 'password', :password_confirmation => 'password', :admin => true)
user.confirm!

NumericVictim.create(:name => 'Github People', :url => 'https://github.com', :selector => '.hero h1 strong:eq(1)', :user_id => user.id)
ListVictim.create(:name => 'True Blood Episodes', :url => 'http://www.tv.com/true-blood/show/74645/episode.html?tag=page_nav;episode', :selector => '#episode_guide_list ul li h3 a', :user_id => user.id)