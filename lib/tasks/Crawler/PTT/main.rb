require 'nokogiri'
require 'open-uri'
require 'csv'

require("#{Rails.root}/lib/tasks/Crawler/PTT/get_board_url.rb")
require("#{Rails.root}/lib/tasks/Crawler/PTT/get_post_url.rb")
require("#{Rails.root}/lib/tasks/Crawler/PTT/get_post_content.rb")

# get_board()
# get_post_url(["1/16"]) # 設定日期，要抓的日期都要寫出來
# get_post_content()
