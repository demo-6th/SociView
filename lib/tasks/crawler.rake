require('./lib/tasks/Crawler/Dcard/main.rb')


namespace :Crawler do
  desc "Crawler for Dcard"
  task :run_dcard do
    ruby main.rb
   end
end