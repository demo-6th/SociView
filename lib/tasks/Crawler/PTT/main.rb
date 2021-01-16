require 'nokogiri'
require 'open-uri'
require 'csv'

require("#{Rails.root}/lib/tasks/Crawler/PTT/get_board_url.rb")
require("#{Rails.root}/lib/tasks/Crawler/PTT/get_post_url.rb")
require("#{Rails.root}/lib/tasks/Crawler/PTT/get_post_content.rb")

