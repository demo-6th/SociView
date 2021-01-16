require("#{Rails.root}/lib/tasks/Crawler/PTT/main.rb")

namespace :Crawler do
  desc "Crawler for ptt"
  task :ptt => :environment do
    get_board()
    get_post_url(["1/17"]) # 設定日期，區間內的日期要全部列出
    get_post_content()
    `python3 lib/tasks/Crawler/PTT/data_cleaning.py`
  end
end
