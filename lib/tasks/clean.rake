namespace :db do
  desc "Truncate all tables"
  task :clean => :environment do
    `rake db:drop`
    `rake db:create`
    `rake db:migrate:status`
    `rake db:migrate`
    `rake db:migrate:status`
    `rake db:seed`
  end
end
