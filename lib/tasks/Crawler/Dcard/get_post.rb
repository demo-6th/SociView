def get_forums
  begin
    forum_url = "https://www.dcard.tw/_api/forums"
    forum_uri = URI(forum_url)
    forum_data = Net::HTTP.get(forum_uri)
    forum_items = JSON.parse(forum_data)
    forums = []
    forum_items.each do |forum_item|
      forums << [forum_item["name"],
                 forum_item["alias"],
                 "https://www.dcard.tw/_api/forums/#{forum_item["alias"]}/posts?popular=false", 1]
    end
  rescue => e
    puts "error type=#{e.class}, message=#{e.message}"
  end
  File.write("#{Rails.root}/data/forums.csv", forums.map(&:to_csv).join)
end

def get_post_id(board, sleep_every, sleep_time, prev_day)
  table = CSV.parse(File.read("#{Rails.root}/data/forums.csv"), headers: false)

  current_table = table["#{board}".to_i.."#{board}".to_i]

  all_post_id = []
  current_table.each do |line|
    puts "=============#{board + 1}.#{line[0]}=============" # print board name
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
        puts item
        puts search_end_date
        puts post_id_created_at
        break if post_id_created_at < search_end_date
        count += 1
        total_cut += 1
        forum_post_id << [item["id"], item["title"], item["forumName"], item["forumAlias"]]
        puts total_cut, "----------#{item["title"]}"
        if count == 30
          last_id = item["id"]
          count = 0
        end
      rescue => e
        puts "=============[error type=#{e.class}, message=#{e.message}]============="
      end
    end
    while true
      break puts "========本版已無符合條件資料========" if post_id_created_at == [] || post_id_created_at < search_end_date || last_id == 0
      url = "#{line[2]}&before=#{last_id}"
      uri = URI(url)
      data = Net::HTTP.get(uri)
      items = JSON.parse(data)

      if items.size < 30
        items.each do |item|
          begin
            post_id_created_at = item["createdAt"].slice(0, 10)
            break puts "========本版已無符合條件資料========" if post_id_created_at == [] || post_id_created_at < search_end_date
            total_cut += 1
            sleep(rand(0.5..1.2))
            puts total_cut, "-----------#{item["title"]}"
            forum_post_id << [item["id"], item["title"], item["forumName"], item["forumAlias"]]
          rescue => e
            puts "=============[error type=#{e.class}, message=#{e.message}]============="
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
            puts "=============[error type=#{e.class}, message=#{e.message}]============="
          end
        end
      end
    end
    all_post_id += forum_post_id
  end

  File.write("#{Rails.root}/data/post_id.csv", all_post_id.map(&:to_csv).join)
end

def get_post(sleep_every, sleep_time)
  table = CSV.parse(File.read("#{Rails.root}/data/post_id.csv"), headers: false)
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
      puts "=============[error type=#{e.class}, message=#{e.message}]============="
    end
  end

  File.write("#{Rails.root}/data/post_content.csv", post_content.map(&:to_csv).join)
end

def get_comment(sleep_every, sleep_time)
  table = CSV.parse(File.read("#{Rails.root}/data/post_id.csv"), headers: false)

  post_comments = []
  table.each do |line|
    begin
      count = 0
      last_floor = 0
      total_cut = 0
      puts "=============#{line[2]}/#{line[0]}=============" #顯示"版名/文章ID" 回文過多方便確認
      while true
        sleep(rand(0.5..1.2))
        url = "https://www.dcard.tw/_api/posts/#{line[0]}/comments?after=#{last_floor}"
        uri = URI(url)
        data = Net::HTTP.get(uri)
        items = JSON.parse(data)

        if items.size < 30
          sleep(rand(0.5..1.2))
          items.each do |item|
            post_comments << [item["id"], item["postId"], item["createdAt"], item["updatedAt"], item["floor"], item["content"], item["likeCount"], item["gender"]]
            count += 1
            total_cut += 1
            puts "#{total_cut}----#{item["content"]}"
          end
          break
        else
          if total_cut.modulo(sleep_every) == 0
            sleep(sleep_time)
          else
            sleep(rand(0.5..1.2))
          end
          items.each do |item|
            post_comments << [item["id"], item["postId"], item["createdAt"], item["updatedAt"], item["floor"], item["content"], item["likeCount"], item["gender"]]
            count += 1
            total_cut += 1

            puts "#{total_cut}----#{item["content"]}"
            if count == 30
              last_floor = item["floor"]
              count = 0
            end
          end
        end
      end
    rescue => e
      puts "=============[error type=#{e.class}, message=#{e.message}]============="
    end
  end

  File.write("#{Rails.root}/data/post_comment.csv", post_comments.map(&:to_csv).join)
end
