namespace :trackinator do
  
  desc "Add a victim"
  task :add, [:name, :url, :selector] => :environment do |task, arguments|
    
    arguments.merge!({:name => ENV["NAME"]}) if ENV["NAME"]
    arguments.merge!({:url => ENV["URL"]}) if ENV["URL"]
    arguments.merge!({:selector => ENV["SELECTOR"]}) if ENV["SELECTOR"]
    
    Victim.create_from_arguments(arguments)
  end
  
  desc "Remove a victim"
  task :remove, [:name] => :environment do |task, arguments|
    Victim.destroy_from_arguments(arguments)
  end

end