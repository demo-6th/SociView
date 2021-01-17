def get_board
  url = 'https://www.ptt.cc/bbs/hotboards.html'
  doc = Nokogiri::HTML(open( url ))

  boards = doc.xpath( '//*[@id="main-container"]/div[2]/div[1]/a').xpath("//@href")

  url = []
  # 10以後才真的是版名，勿改
  boards[10..boards.length].each do |x|
    url << ["https://www.ptt.cc/#{x.value}"]
  end

  File.write("#{Rails.root}/lib/tasks/Crawler/PTT/boards_url.csv", url.map(&:to_csv).join)
end 

