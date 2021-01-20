require "net/http"
require "json"
require "csv"
require "fileutils"
#
require("#{Rails.root}/lib/tasks/Crawler/Dcard/get_post.rb")
require("#{Rails.root}/lib/tasks/Crawler/Dcard/dcard_process_files.rb")

def loop_crawler
  update_boards()
  all_boards = CSV.parse(File.read("#{Rails.root}/data/forums.csv"), headers: false)

  # 0.upto = 從第一個版開始
  0.upto(all_boards.count - 1) do |board|
    # #first.first待改
    table_title = all_boards["#{board}".to_i.."#{board}".to_i].first.first

    # n 天前的資料
    prev_day = 1

    # 每 n 筆資料暫停 / 隨機請參考rand(n..m)
    sleep_every = 50

    # 暫停時休息秒數 / 隨機請參考rand(n..m)
    sleep_time = 3

    dcard_get_post_id(board, sleep_every, sleep_time, prev_day)
    dcard_get_post_content(sleep_every, sleep_time)
    dcard_get_comment(sleep_every, sleep_time)
    `python3 lib/tasks/Crawler/Dcard/data_cleaning.py`
    dcard_csv_to_psql()
    dcard_mv_files(table_title)
  end
  dcard_update_boards()
end
