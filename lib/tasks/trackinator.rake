namespace :trackinator do
  
  desc "Add a victim"
  task :add, [:name, :url, :selector] => :environment do |task, arguments|
    Victim.create_from_arguments(arguments)
  end
  
  desc "Remove a victim"
  task :remove, [:name] => :environment do |task, arguments|
    Victim.destroy_from_arguments(arguments)
  end

end