desc "Cron"
task :cron => :environment do
 Victim.visitable.collect(&:visit!)
end

namespace :visit do
  desc "Visit all"
  task :all => :environment do
    Victim.all.collect(&:visit!)
  end
  
  desc "Visit visitable"
  task :visitable => :environment do
    Victim.visitable.collect(&:visit!)
  end
end