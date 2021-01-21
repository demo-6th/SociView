def get_post_url(date_array)
  table = CSV.parse(File.read("#{Rails.root}/lib/tasks/Crawler/PTT/ptt_boards_url.csv"), headers: false)
  pre_url = "https://www.ptt.cc"
  post_url_all = []

  table.each do |t|
    sleep(rand(0.1..0.4))
    next_url = t[0]
    p next_url
    post_url = []
    # 每個版的index頁面因為有置底文所以另外判斷
    doc = Nokogiri::HTML(open(next_url,'Cookie' => 'over18=1'))
    num = doc.search("#main-container .r-list-container .r-ent").size 

    (num-1).downto(0).each { |i|
      next unless doc.css("#main-container .r-list-container .r-ent .meta .date")[i]
      next unless doc.css("#main-container .r-list-container .r-ent .meta .author")[i]
      next unless doc.css("#main-container .r-list-container .r-ent .title a")[i]
      next unless date_array.include?(doc.css("#main-container .r-list-container .r-ent .meta .date")[i].text.strip)
      next if doc.css("#main-container .r-list-container .r-ent .title a").nil?

      post_url << [doc.css("#main-container .r-list-container .r-ent .meta .date")[i].text.strip,doc.css("#main-container .r-list-container .r-ent .meta .author")[i].text,pre_url + doc.css("#main-container .r-list-container .r-ent .title a")[i]["href"]]
    }
    
    next_url = pre_url + doc.css("#main-container .btn-group .wide:nth-child(2)")[0]["href"]
    p next_url
    while true 
      doc = Nokogiri::HTML(open(next_url,'Cookie' => 'over18=1'))
      num = doc.search("#main-container .r-list-container .r-ent").size 
      
      break unless date_array.include?(doc.css("#main-container .r-list-container .r-ent .meta .date")[num-1].text.strip)

      (num-1).downto(0).each { |i| 
        next unless doc.css("#main-container .r-list-container .r-ent .meta .date")[i]
        next unless doc.css("#main-container .r-list-container .r-ent .meta .author")[i]
        next unless doc.css("#main-container .r-list-container .r-ent .title a")[i]
  
        next unless date_array.include?(doc.css("#main-container .r-list-container .r-ent .meta .date")[i].text.strip)
        post_url << [doc.css("#main-container .r-list-container .r-ent .meta .date")[i].text.strip, doc.css("#main-container .r-list-container .r-ent .meta .author")[i].text,pre_url + doc.css("#main-container .r-list-container .r-ent .title a")[i]["href"]]
      }
      next_url = pre_url + doc.css("#main-container .btn-group .wide:nth-child(2)")[0]["href"]
      p "next page   #{next_url}"
    end 
    post_url_all << post_url
  end 

  File.write("#{Rails.root}/lib/tasks/Crawler/PTT/ptt_post_url.csv", post_url_all.flatten(1).map(&:to_csv).join)
end


