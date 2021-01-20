def get_content
  table = CSV.parse(File.read("#{Rails.root}/lib/tasks/Crawler/PTT/ptt_post_url.csv"), headers: false)

  all_post = []
  all_comment = []
  
  table.each do |x|
    sleep(rand(0.2..0.5))
    url = x[2]

    # p url
    begin 
      doc = Nokogiri::HTML(open(url,'Cookie' => 'over18=1'))
      # board 
      board = doc.xpath('//*[@id="topbar"]/a[2]').text
      
      # post_url
      post_url = url
      p post_url
      # post author 
      post_author = doc.xpath('//*[@id="main-content"]/div[1]/span[2]').text

      # post title 
      post_title = doc.xpath('//*[@id="main-content"]/div[3]/span[2]').text
  
      # post time
      created_at = doc.xpath('//*[@id="main-content"]/div[4]/span[2]').text

      # post content
      post_content = doc.xpath('//*[@id="main-content"]/text()').text

      # comment count 
      comment_count = 0
      comment_count = doc.css("#main-container .bbs-content .push").count if not doc.css("#main-container .bbs-content .push").nil?

      all_post <<  [board, post_url,post_author, post_title, created_at, comment_count, post_content]
      

      if doc.css("#main-container .bbs-content .push").nil?
        comment_count = 0
      else
        comment_count = doc.css("#main-container .bbs-content .push").count

        # all post comment
        doc.css("#main-container .bbs-content .push").each do |comment|
          # ignore comments that has less than 3 words
          next if comment.css(".push-content").text.length < 5
          # board
          board = doc.xpath('//*[@id="topbar"]/a[2]').text
          # post_url
          post_url = url
          # post comment author 
          comment_author = comment.css(".push-userid").text
          p comment_author
          # post comment time
          comment_created_at = comment.css(".push-ipdatetime").text
          # comment content 
          comment_content = comment.css(".push-content").text

          all_comment << [board, post_url, comment_author, comment_created_at, comment_content]
          
        end 
      end
    rescue 
      next
    end
  end 

  File.write("#{Rails.root}/lib/tasks/Crawler/PTT/ptt_post_content.csv", all_post.map(&:to_csv).join)
  File.write("#{Rails.root}/lib/tasks/Crawler/PTT/ptt_comment_content.csv", all_comment.map(&:to_csv).join)
end 

