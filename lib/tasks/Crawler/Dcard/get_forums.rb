# 一、抓下所有看板名稱，並拼出可以抓到屬於該看板的post_id的url

def get_forums 
  begin
    forum_url = 'https://www.dcard.tw/_api/forums'
    forum_uri = URI(forum_url)
    forum_data = Net::HTTP.get(forum_uri)
    forum_items = JSON.parse(forum_data)
    forums = []
    forum_items.each do |forum_item|
      forums << [forum_item["name"],
      forum_item["alias"],
      "https://www.dcard.tw/_api/forums/#{forum_item["alias"]}/posts?popular=false"]
    end
  rescue => e
    puts "error type=#{e.class}, message=#{e.message}" 
  end 
  File.write("./lib/tasks/Crawler/Dcard/forums.csv", forums.map(&:to_csv).join)

  
end 
