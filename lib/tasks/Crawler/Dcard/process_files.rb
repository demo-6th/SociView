def mv_files(table_title)
  clean_title = table_title.gsub("/", "-")
  Dir.mkdir("#{Rails.root}/data/#{clean_title}") unless Dir.exists?("#{Rails.root}/data/#{clean_title}")
  FileUtils.mv("#{Rails.root}/data/post_id.csv", "#{Rails.root}/data/#{clean_title}/")
  FileUtils.mv("#{Rails.root}/data/post_content.csv", "#{Rails.root}/data/#{clean_title}/")
  FileUtils.mv("#{Rails.root}/data/post_comment.csv", "#{Rails.root}/data/#{clean_title}/")
  FileUtils.mv("#{Rails.root}/data/#{clean_title}", "#{Rails.root}/data/#{@folder_name}/")
end

def board_folder()
  @folder_name = DateTime.now.strftime("%F %R").gsub(":", "-")
  Dir.mkdir("#{Rails.root}/data/#{@folder_name}")
end

def csv_to_psql()
  data_boards = CSV.read("#{Rails.root}/data/forums.csv")
  data_boards.each do |arr|
    colums = [:name, :alias, :source_id]
    values = [[arr[0], arr[1], arr[3]]]
    Board.import colums, values, validate: false
  end

  data_posts = CSV.read("#{Rails.root}/data/post_content.csv")
  data_posts.each do |arr|
    post_colums = [:id, :content, :title, :created_at, :updated_at, :comment_count, :like_count, :alias, :url]
    post_values = [[arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[9], arr[10]]]
    Post.import post_colums, post_values, validate: false

    post_clean_colums = [:post_id, :content]
    post_clean_values = [[arr[1], arr[13]]]
    PostClean.import post_clean_colums, post_clean_values, validate: false

    post_keyword_colums = [:post_id, :content]
    post_keyword_values = [[arr[1], arr[16]]]
    PostKeyword.import post_keyword_colums, post_keyword_values, validate: false

    post_sentiment_colums = [:post_id, :content]
    post_sentiment_values = [[arr[1], arr[17]]]
    PostSentiment.import post_sentiment_colums, post_sentiment_values, validate: false

    post_token_colums = [:post_id, :content]
    post_token_values = [[arr[1], arr[14]]]
    PostToken.import post_token_colums, post_token_values, validate: false

    post_keep_word_colums = [:post_id, :content]
    post_keep_word_values = [[arr[1], arr[15]]]
    PostKeepWord.import post_keep_word_colums, post_keep_word_values, validate: false
  end

  data_comments = CSV.read("#{Rails.root}/data/post_comment.csv")

  data_comments.each do |arr|
    comment_colums = [:id, :post_id, :created_at, :updated_at, :content, :like_count, :alias, :url]
    comment_values = [[arr[1], arr[2], arr[3], arr[4], arr[6], arr[7], arr[9], arr[10]]]
    Comment.import comment_colums, comment_values, validate: false

    comment_clean_colums = [:comment_id, :content]
    comment_clean_values = [[arr[1], arr[13]]]
    CommentClean.import comment_clean_colums, comment_clean_values, validate: false

    comment_keyword_colums = [:comment_id, :content]
    comment_keyword_values = [[arr[1], arr[16]]]
    CommentKeyword.import comment_keyword_colums, comment_keyword_values, validate: false

    comment_sentiment_colums = [:comment_id, :content]
    comment_sentiment_values = [[arr[1], arr[17]]]
    CommentSentiment.import comment_sentiment_colums, comment_sentiment_values, validate: false

    comment_token_colums = [:comment_id, :content]
    comment_token_values = [[arr[1], arr[14]]]
    CommentToken.import comment_token_colums, comment_token_values, validate: false

    comment_keep_word_colums = [:comment_id, :content]
    comment_keep_word_values = [[arr[1], arr[15]]]
    CommentKeepWord.import comment_keep_word_colums, comment_keep_word_values, validate: false
  end

  puts "=====CSV write into PSQL Success====="
end
