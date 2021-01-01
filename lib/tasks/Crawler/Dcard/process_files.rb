def mv_files(table_title)
  clean_title = table_title.gsub("/", "-")
  Dir.mkdir("./lib/tasks/Crawler/Dcard/#{clean_title}") unless Dir.exists?("./lib/tasks/Crawler/Dcard/#{clean_title}")
  FileUtils.mv("./lib/tasks/Crawler/Dcard/post_id.csv", "./lib/tasks/Crawler/Dcard/#{clean_title}/")
  FileUtils.mv("./lib/tasks/Crawler/Dcard/post_content.csv", "./lib/tasks/Crawler/Dcard/#{clean_title}/")
  FileUtils.mv("./lib/tasks/Crawler/Dcard/post_comment.csv", "./lib/tasks/Crawler/Dcard/#{clean_title}/")
  FileUtils.mv("./lib/tasks/Crawler/Dcard/#{clean_title}", "./lib/tasks/Crawler/Dcard/#{@folder_name}/")
end

def folder_name()
  @folder_name = DateTime.now.strftime("%F %R").gsub(":", "-")
  Dir.mkdir("./lib/tasks/Crawler/Dcard/#{@folder_name}")
end

def finish_time()
  finishtime = DateTime.now.strftime("%F %R").gsub(":", "-")
  File.open("finish_at_#{finishtime}.txt", "w")
  FileUtils.mv("finish_at_#{finishtime}.txt", "./lib/tasks/Crawler/Dcard/#{@folder_name}/")
end

def csv_to_psql()
  # Board.delete_all
  data_boards = CSV.read("#{Rails.root}/lib/tasks/Crawler/Dcard/forums.csv")
  data_boards.each do |arr|
    colums = [:name, :alias, :source_id]
    values = [[arr[0], arr[1], arr[3]]]
    Board.import colums, values, validate: false
  end

  data_posts = CSV.read("#{Rails.root}/lib/tasks/Crawler/Dcard/post_content.csv")
  data_posts.each do |arr|
    post_colums = [:pid, :post_content, :title, :created_at, :updated_at, :comment_count, :like_count, :alias, :url]
    post_values = [[arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[9], arr[10]]]
    Post.import post_colums, post_values, validate: false

    post_clean_colums = [:pid, :clean_text]
    post_clean_values = [[arr[1], arr[13]]]
    PostClean.import post_clean_colums, post_clean_values, validate: false

    post_keyword_colums = [:pid, :keyword]
    post_keyword_values = [[arr[1], arr[16]]]
    PostKeyword.import post_keyword_colums, post_keyword_values, validate: false

    post_sentiment_colums = [:pid, :sentiment]
    post_sentiment_values = [[arr[1], arr[17]]]
    PostSentiment.import post_sentiment_colums, post_sentiment_values, validate: false

    post_token_colums = [:pid, :token, :no_stop_words]
    post_token_values = [[arr[1], arr[14], arr[15]]]
    PostToken.import post_token_colums, post_token_values, validate: false
  end

  data_comments = CSV.read("#{Rails.root}/lib/tasks/Crawler/Dcard/post_comment.csv")

  data_comments.each do |arr|
    comment_colums = [:cid, :pid, :created_at, :updated_at, :comment_content, :like_count, :alias, :url]
    comment_values = [[arr[1], arr[2], arr[3], arr[4], arr[6], arr[7], arr[9], arr[10]]]
    Comment.import comment_colums, comment_values, validate: false

    comment_clean_colums = [:cid, :clean_text]
    comment_clean_values = [[arr[1], arr[13]]]
    CommentClean.import comment_clean_colums, comment_clean_values, validate: false

    comment_keyword_colums = [:cid, :keyword]
    comment_keyword_values = [[arr[1], arr[16]]]
    CommentKeyword.import comment_keyword_colums, comment_keyword_values, validate: false

    comment_sentiment_colums = [:cid, :sentiment]
    comment_sentiment_values = [[arr[1], arr[17]]]
    CommentSentiment.import comment_sentiment_colums, comment_sentiment_values, validate: false

    comment_token_colums = [:cid, :token, :no_stop_words]
    comment_token_values = [[arr[1], arr[14], arr[15]]]
    CommentToken.import comment_token_colums, comment_token_values, validate: false
  end
end
