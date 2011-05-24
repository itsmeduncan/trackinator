namespace :visit do

  desc "Visit all"
  task :all => :environment do
    Victim.all.collect(&:visit!)
  end
  
  desc "Visit visitable"
  task :all => :environment do
    Victim.visitable.collect(&:visit!)
  end

end