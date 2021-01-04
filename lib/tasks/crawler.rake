require("./lib/tasks/Crawler/Dcard/main.rb")

namespace :Crawler do
  desc "Crawler for Dcard"
  task :run_dcard => :environment do
    `python3 lib/tasks/Crawler/Dcard/packages.py params`
    get_forums()
    board_folder()
    loop_crawler()
  end
end
