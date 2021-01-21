require("#{Rails.root}/lib/tasks/Crawler/PTT/main.rb")
require("#{Rails.root}/lib/tasks/Crawler/PTT/ptt_process_files.rb")

namespace :Crawler do
  desc "Crawler for ptt"
  task :ptt => :environment do
    get_board()
    get_post_url(["1/20"]) # 設定日期，區間內的日期要全部列出
    get_content()
    `python3 lib/tasks/Crawler/PTT/data_cleaning.py`
    ptt_update_boards()
    ptt_csv_to_psql()
  end
end
