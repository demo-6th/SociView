require "net/http"
require "json"
require "csv"
require "fileutils"
#
require("#{Rails.root}/lib/tasks/Crawler/Dcard/get_forums.rb")
require("#{Rails.root}/lib/tasks/Crawler/Dcard/get_post_id.rb")
require("#{Rails.root}/lib/tasks/Crawler/Dcard/get_post_content.rb")
require("#{Rails.root}/lib/tasks/Crawler/Dcard/get_post_comment.rb")
require("#{Rails.root}/lib/tasks/Crawler/Dcard/process_files.rb")

def loop_crawler
  all_boards = CSV.parse(File.read("#{Rails.root}/lib/tasks/Crawler/Dcard/forums.csv"), headers: false)

  # 0.upto = 從第一個版開始
  0.upto(all_boards.count - 1) do |board|
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
    # data cleaning process
    cleaned_data = `python lib/tasks/Crawler/Dcard/data_cleaning.py params`
    puts(cleaned_data)
    csv_to_psql()
    mv_files(table_title)
  end
end

def dcard
  # python packages
  pkg = `python lib/tasks/Crawler/Dcard/packages.py params`
  puts(pkg)
  get_forums()
  folder_name()
  loop_crawler()
end
