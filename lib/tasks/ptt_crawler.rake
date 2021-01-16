require("#{Rails.root}/lib/tasks/Crawler/PTT/main.rb")

namespace :Crawler do
  desc "Crawler for ptt"
  task :ptt => :environment do
    get_board()
    get_post_url(["1/16"]) 
    get_post_content()
  end
end
