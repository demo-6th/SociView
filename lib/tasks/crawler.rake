require("#{Rails.root}/lib/tasks/Crawler/Dcard/main.rb")

namespace :Crawler do
  desc "Crawler for Dcard"
  task :dcard => :environment do
    `python3 lib/tasks/Crawler/Dcard/packages.py params`
    get_forums()
    board_folder()
    loop_crawler()
  end
end
