require "net/http"
require "json"
require "csv"
require "fileutils"
#
require("#{Rails.root}/lib/tasks/Crawler/Dcard/get_post.rb")
require("#{Rails.root}/lib/tasks/Crawler/Dcard/process_files.rb")

def loop_crawler
  all_boards = CSV.parse(File.read("#{Rails.root}/data/forums.csv"), headers: false)

  # 0.upto = 從第一個版開始
  # 7.upto(all_boards.count - 1) do |board|
  7.upto(9) do |board|
    #first.first待改
    table_title = all_boards["#{board}".to_i.."#{board}".to_i].first.first

    # n 天前的資料
    prev_day = 1

    # 每 n 筆資料暫停 / 隨機請參考rand(n..m)
    sleep_every = 50

    # 暫停時休息秒數 / 隨機請參考rand(n..m)
    sleep_time = 3

    get_post_id(board, sleep_every, sleep_time, prev_day)
    get_post_content(sleep_every, sleep_time)
    get_post_comment(sleep_every, sleep_time)
    `python3 lib/tasks/Crawler/Dcard/data_cleaning.py params`
    csv_to_psql()
    mv_files(table_title)
  end
  update_boards()
end
