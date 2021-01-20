def mv_files(table_title)
  clean_title = table_title.gsub("/", "-")
  Dir.mkdir("#{Rails.root}/data/#{clean_title}") unless Dir.exists?("#{Rails.root}/data/#{clean_title}")
  FileUtils.mv("#{Rails.root}/data/dcard_post_id.csv", "#{Rails.root}/data/#{clean_title}/")
  FileUtils.mv("#{Rails.root}/data/dcard_post_content.csv", "#{Rails.root}/data/#{clean_title}/")
  FileUtils.mv("#{Rails.root}/data/dcard_post_comment.csv", "#{Rails.root}/data/#{clean_title}/")
  FileUtils.mv("#{Rails.root}/data/#{clean_title}", "#{Rails.root}/data/#{@folder_name}/")
end

def board_folder()
  @folder_name = DateTime.now.strftime("%F %R").gsub(":", "-")
  Dir.mkdir("#{Rails.root}/data/#{@folder_name}")
end

def update_boards()
  data_boards = CSV.read("#{Rails.root}/data/forums.csv")
  data_boards.each do |arr|
    colums = [:name, :alias, :source_id]
    values = [[arr[0], arr[1], arr[3]]]
    Board.import colums, values, validate: false
  end

  Board.where.not(id: Board.group(:alias).select("min(id)")).destroy_all
end

def csv_to_psql()
  data_posts = CSV.read("#{Rails.root}/data/dcard_post_content.csv")
  data_posts.each do |arr|
    post_colums = [:pid, :content, :title, :created_at, :updated_at, :comment_count, :like_count, :alias, :url, :clean, :token, :pos, :no_stop, :keyword, :sentiment]
    post_values = [[arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[9], arr[10], arr[13], arr[14], arr[15], arr[16], arr[17],arr[18]]]
    Post.import post_colums, post_values, validate: false
  end

  data_comments = CSV.read("#{Rails.root}/data/dcard_post_comment.csv")

  data_comments.each do |arr|
    comment_colums = [:cid, :pid, :created_at, :updated_at, :content, :like_count, :alias, :url, :clean, :token, :pos, :no_stop, :keyword, :sentiment]
    comment_values = [[arr[1], arr[2], arr[3], arr[4], arr[6], arr[7], arr[9], arr[10], arr[13], arr[14], arr[15], arr[16], arr[17],arr[18]]]
    Comment.import comment_colums, comment_values, validate: false
  end

  puts "=====CSV write into PSQL Success====="
end

# 有修改欄位，seed還沒改
# def update_testboards()
#   data_boards = CSV.read("#{Rails.root}/data/testdata/forums.csv")
#   data_boards.each do |arr|
#     colums = [:name, :alias, :source_id]
#     values = [[arr[0], arr[1], arr[3]]]
#     Board.import colums, values, validate: false
#   end

#   Board.where.not(id: Board.group(:alias).select("min(id)")).destroy_all
# end

# def testcsv_to_psql()
#   data_posts = CSV.read("#{Rails.root}/data/testdata/post_content.csv")
#   data_posts.each do |arr|
#     post_colums = [:pid, :content, :title, :created_at, :updated_at, :comment_count, :like_count, :alias, :url, :clean, :token, :no_stop, :keyword, :sentiment]
#     post_values = [[arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[9], arr[10], arr[13], arr[14], arr[15], arr[16], arr[17]]]
#     Post.import post_colums, post_values, validate: false
#   end

#   data_comments = CSV.read("#{Rails.root}/data/testdata/post_comment.csv")
#   data_comments.each do |arr|
#     comment_colums = [:cid, :pid, :created_at, :updated_at, :content, :like_count, :alias, :url, :clean, :token, :no_stop, :keyword, :sentiment]
#     comment_values = [[arr[1], arr[2], arr[3], arr[4], arr[6], arr[7], arr[9], arr[10], arr[13], arr[14], arr[15], arr[16], arr[17]]]
#     Comment.import comment_colums, comment_values, validate: false
#   end
# end
