def mv_files(table_title)
  clean_title = table_title.gsub("/", "-")
  Dir.mkdir("./lib/tasks/Crawler/Dcard/#{clean_title}") unless Dir.exists?("./lib/tasks/Crawler/Dcard/#{clean_title}")
  FileUtils.mv("./lib/tasks/Crawler/Dcard/post_id.csv", "./lib/tasks/Crawler/Dcard/#{clean_title}/")
  FileUtils.mv("./lib/tasks/Crawler/Dcard/post_content.csv", "./lib/tasks/Crawler/Dcard/#{clean_title}/")
  FileUtils.mv("./lib/tasks/Crawler/Dcard/post_comment.csv", "./lib/tasks/Crawler/Dcard/#{clean_title}/")
  FileUtils.mv("./lib/tasks/Crawler/Dcard/#{clean_title}", "./lib/tasks/Crawler/Dcard/#{@folder_name}/")
end

def beta_folder_name()
  @folder_name = DateTime.now.strftime("%F %R").gsub(":", "-")
  Dir.mkdir("./lib/tasks/Crawler/Dcard/#{@folder_name}")
end

def finish_time()
  finishtime = DateTime.now.strftime("%F %R").gsub(":", "-")
  File.open("finish_at_#{finishtime}.txt", "w")
  FileUtils.mv("finish_at_#{finishtime}.txt", "./lib/tasks/Crawler/Dcard/#{@folder_name}/")
end
