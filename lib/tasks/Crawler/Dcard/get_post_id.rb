def get_post_id(board, sleep_every, sleep_time, prev_day)
  table = CSV.parse(File.read("./lib/tasks/Crawler/Dcard/forums.csv"), headers: false)

  current_table = table["#{board}".to_i.."#{board}".to_i]

  all_post_id = []
  current_table.each do |line|
    puts "=============#{board + 1}.#{line[0]}============" # print board name
    url = line[2]
    uri = URI(url)
    data = Net::HTTP.get(uri)
    items = JSON.parse(data)
    search_end_date = DateTime.now.prev_day(prev_day).strftime("%Y-%m-%d")
    post_id_created_at = []
    forum_post_id = []
    count = 0
    last_id = 0
    total_cut = 0
    e = 0

    items.each do |item|
      begin
        sleep(rand(0.5..1.2))
        post_id_created_at = item["createdAt"].slice(0, 10)
        break if post_id_created_at < search_end_date
        count += 1
        total_cut += 1
        forum_post_id << [item["id"], item["title"], item["forumName"], item["forumAlias"]]
        puts total_cut, "----------#{item["title"]}" # print how much board and board name
        if count == 30
          last_id = item["id"]
          count = 0
        end
      rescue => e
        puts "==========================================="
        puts "error type=#{e.class}, message=#{e.message}"
        puts "==========================================="
      end
    end
    while true
      break puts "本版已無符合條件資料" if post_id_created_at == [] || post_id_created_at < search_end_date || last_id == 0
      url = "#{line[2]}&before=#{last_id}"
      uri = URI(url)
      data = Net::HTTP.get(uri)
      items = JSON.parse(data)

      if items.size < 30
        items.each do |item|
          begin
            post_id_created_at = item["createdAt"].slice(0, 10)
            break puts "本版已無符合條件資料" if post_id_created_at == [] || post_id_created_at < search_end_date
            total_cut += 1
            sleep(rand(0.5..1.2))
            puts total_cut, "-----------#{item["title"]}"
            forum_post_id << [item["id"], item["title"], item["forumName"], item["forumAlias"]]
          rescue => e
            puts "==========================================="
            puts "error type=#{e.class}, message=#{e.message}"
            puts "==========================================="
          end
        end
      else
        count = 0
        items.each do |item|
          begin
            if total_cut.modulo(sleep_every) == 0
              sleep(sleep_time)
            else
              sleep(rand(0.5..1.2))
            end
            post_id_created_at = item["createdAt"].slice(0, 10)
            break if post_id_created_at == [] || post_id_created_at < search_end_date
            count += 1
            total_cut += 1
            forum_post_id << [item["id"], item["title"], item["forumName"], item["forumAlias"]]
            puts total_cut, "-----------#{item["title"]}"
            if count == 30
              last_id = item["id"]
              count = 0
            end
          rescue => e
            puts "==========================================="
            puts "error type=#{e.class}, message=#{e.message}"
            puts "==========================================="
          end
        end
      end
    end
    all_post_id += forum_post_id
  end

  File.write("./lib/tasks/Crawler/Dcard/post_id.csv", all_post_id.map(&:to_csv).join)
end
