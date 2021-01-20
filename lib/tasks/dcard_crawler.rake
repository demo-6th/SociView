require("#{Rails.root}/lib/tasks/Crawler/Dcard/main.rb")

namespace :Crawler do
  desc "Crawler for Dcard"
  task :dcard => :environment do
    # get_forums()
    board_folder()
    loop_crawler()
  end
end
