require 'nokogiri'
require 'open-uri'
require 'csv'

require("./get_board_url.rb")
require("./get_post_url.rb")
require("./get_post_content.rb")

get_board()
get_post_url(["1/14"]) # 設定日期，要抓的日期都要寫出來
get_post_content()