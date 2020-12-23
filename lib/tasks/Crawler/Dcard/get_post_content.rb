def get_post_content(sleep_every, sleep_time)
  table = CSV.parse(File.read("./lib/tasks/Crawler/Dcard/post_id.csv"), headers: false)
  post_content = []
  total_cut = 0
  table.each do |line|
    begin
      if total_cut.modulo(sleep_every) == 0
        sleep(sleep_time)
      else
        sleep(rand(0.5..1.2))
      end
      total_cut += 1
      puts "-------No.#{total_cut}--------"
      puts "#{line[0]}"
      puts ""
      url = "https://www.dcard.tw/_api/posts/#{line[0]}"
      uri = URI(url)
      data = Net::HTTP.get(uri)
      items = JSON.parse(data)
      post_content << [items["id"], items["content"], items["title"], items["createdAt"], items["updatedAt"], items["commentCount"], items["likeCount"], items["gender"]]
    rescue => e
      puts "==========================================="
      puts "error type=#{e.class}, message=#{e.message}"
      puts "==========================================="
    end
  end

  File.write("./lib/tasks/Crawler/Dcard/post_content.csv", post_content.map(&:to_csv).join)
end
