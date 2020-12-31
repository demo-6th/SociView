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
  end

  data_comments = CSV.read("#{Rails.root}/lib/tasks/Crawler/Dcard/post_comment.csv")

  data_comments.each do |arr|
    comment_colums = [:cid, :pid, :created_at, :updated_at, :comment_content, :like_count, :alias, :url]
    comment_values = [[arr[1], arr[2], arr[3], arr[4], arr[6], arr[7], arr[9], arr[10]]]
    Comment.import comment_colums, comment_values, validate: false
  end
end
