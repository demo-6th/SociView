namespace :db do
  desc "Truncate all tables"
  task :clean => :environment do
    `rake db:rollback STEP=20`
    `rake db:migrate`
    `rake db:seed`
  end
end
