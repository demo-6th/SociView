def get_board
  url = 'https://www.ptt.cc/bbs/hotboards.html'
  doc = Nokogiri::HTML(open( url ))

  boards = doc.xpath( '//*[@id="main-container"]/div[2]/div[1]/a').xpath("//@href")

  url = []
  boards[10..boards.length].each do |x|
    url << ["https://www.ptt.cc/#{x.value}"]
  end
  # p url
  File.write("hot_boards_url.csv", url.map(&:to_csv).join)
end 