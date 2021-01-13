class QueriesController < ApplicationController
  before_action :authenticate_user!
  layout "homepage"

  def index
    @wordcloud = wordcloud_queries_path
    @sentiment = sentiment_queries_path
    @volume = volume_queries_path
    @list = list_queries_path
    @topic = topic_queries_path
  end

  def list
  end

  def sentiment; end

  def sentpost
    # pass value down to api action
    @theme = params[:theme].nil? ? "主題必填" : params[:theme] #魚蟬說先這樣
    @source = params[:dcard].nil? && params[:ptt].nil? ? "來源必填" : [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_date.nil? ? "起始時間必填" : params[:user][:start].to_date
    @end = params[:user][:end].to_date.nil? ? "結束時間必填" : params[:user][:end].to_date
    @type = params[:post].nil? && params[:comment].nil? ? "文本必填" : [params[:post], params[:comment]].delete_if { |x| x == nil }

    if @theme.include?("必填") || @type.include?("必填") || @start.to_s.include?("必填") || @end.to_s.include?("必填")
      @count = 0
    else
      #theme1
      @post_result = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme}%").or(Post.where("title like ?", "%#{@theme}%"))
      @comment_result = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ?", "%#{@theme}%").or(Post.where("title like ?", "%#{@theme}%")).pluck(:pid)).or(Comment.where("content like ?", "%#{@theme}%"))

      # 計算符合搜尋條件的資料筆數
      post_count = @post_result.count
      comment_count = @comment_result.count

      gon.start = @start
      gon.end = @end

      if params[:post] && params[:comment]
        @count = post_count + comment_count
        gon.result = @post_result + @comment_result
      elsif params[:post] && !params[:comment]
        @count = post_count
        gon.result = @post_result
      else
        @count = comment_count
        gon.result = @comment_result
      end
    end
  end

  def volume; end

  def volumepost
    # pass value down to api action
    @theme = params[:theme].nil? ? "主題必填" : params[:theme] #魚蟬說先這樣
    @source = params[:dcard].nil? && params[:ptt].nil? ? "來源必填" : [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_date.nil? ? "起始時間必填" : params[:user][:start].to_date
    @end = params[:user][:end].to_date.nil? ? "結束時間必填" : params[:user][:end].to_date
    @type = params[:post].nil? && params[:comment].nil? ? "文本必填" : [params[:post], params[:comment]].delete_if { |x| x == nil }

    if @theme.include?("必填") || @type.include?("必填") || @start.to_s.include?("必填") || @end.to_s.include?("必填")
      @count = 0
    else
      #theme1
      @post_result = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme[0]}%").or(Post.where("title like ?", "%#{@theme[0]}%"))
      @comment_result = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ?", "%#{@theme[0]}%").or(Post.where("title like ?", "%#{@theme[0]}%")).pluck(:pid)).or(Comment.where("content like ?", "%#{@theme[0]}%"))

      #theme2
      @post1_result = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme[1]}%").or(Post.where("title like ?", "%#{@theme[1]}%"))
      @comment1_result = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ?", "%#{@theme[1]}%").or(Post.where("title like ?", "%#{@theme[1]}%")).pluck(:pid)).or(Comment.where("content like ?", "%#{@theme[1]}%"))

      # 計算符合搜尋條件的資料筆數
      gon.start = @start
      gon.end = @end
      gon.theme = @theme[0]
      gon.theme1 = @theme[1]
      post_count = @post_result.count
      comment_count = @comment_result.count
      post1_count = @post1_result.count
      comment1_count = @comment1_result.count

      if params[:post] && params[:comment]
        @count = post_count + comment_count
        gon.result = @post_result + @comment_result
      elsif params[:post] && !params[:comment]
        @count = post_count
        gon.result = @post_result
      else
        @count = comment_count
        gon.result = @comment_result
      end
      gon.count = @count
      #待改進
      if params[:post] && params[:comment]
        @count1 = post1_count + comment1_count
        gon.result1 = @post1_result + @comment1_result
      elsif params[:post] && !params[:comment]
        @count1 = post1_count
        gon.result1 = @post1_result
      else
        @count1 = comment1_count
        gon.result1 = @comment1_result
      end
      gon.count1 = @count1
    end
  end

  def topic; end

  def topicpost
    # pass value down to api action
    @theme = params[:theme].nil? ? "主題必填" : params[:theme] #魚蟬說先這樣
    @source = params[:dcard].nil? && params[:ptt].nil? ? "來源必填" : [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_date.nil? ? "起始時間必填" : params[:user][:start].to_date
    @end = params[:user][:end].to_date.nil? ? "結束時間必填" : params[:user][:end].to_date
    @type = params[:post].nil? && params[:comment].nil? ? "文本必填" : [params[:post], params[:comment]].delete_if { |x| x == nil }

    if @theme.include?("必填") || @type.include?("必填") || @start.to_s.include?("必填") || @end.to_s.include?("必填")
      @count = 0
    else
    #theme1
    post_result = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme}%").or(Post.where("title like ?", "%#{@theme}%"))
    comment_result = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ?", "%#{@theme}%").or(Post.where("title like ?", "%#{@theme}%")).pluck(:pid)).or(Comment.where("content like ?", "%#{@theme}%"))

    post_count = post_result.count
    comment_count = comment_result.count

    if params[:post] && params[:comment]
      @count = post_count + comment_count
      result = post_result.select(:token, :id) | comment_result.select(:token, :id)
    elsif params[:post] && !params[:comment]
      @count = post_count
      result = post_result.select(:token, :id)
    else
      @count = comment_count
      result = comment_result.select(:token, :id)
    end

      CSV.open("data/topic_text.csv", "wb") do |csv|
        result.find_all do |res|
          csv << res.attributes.values
        end
        `python3 lib/tasks/Topic/main.py`
      end
    end
  end

  def wordcloud; end

  def cloudpost
    # pass value down to api action
    @theme = params[:theme].nil? ? "主題必填" : params[:theme] #魚蟬說先這樣
    @source = params[:dcard].nil? && params[:ptt].nil? ? "來源必填" : [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_date.nil? ? "起始時間必填" : params[:user][:start].to_date
    @end = params[:user][:end].to_date.nil? ? "結束時間必填" : params[:user][:end].to_date
    @type = params[:post].nil? && params[:comment].nil? ? "文本必填" : [params[:post], params[:comment]].delete_if { |x| x == nil }

    if @theme.include?("必填") || @type.include?("必填") || @start.to_s.include?("必填") || @end.to_s.include?("必填")
      @count = 0
    else
      #theme1
      post_result = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme}%").or(Post.where("title like ?", "%#{@theme}%"))
      comment_result = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ?", "%#{@theme}%").or(Post.where("title like ?", "%#{@theme}%")).pluck(:pid)).or(Comment.where("content like ?", "%#{@theme}%"))

      post_count = post_result.count
      comment_count = comment_result.count 

      if params[:post] && params[:comment]
        @count = post_count + comment_count
        result = post_result.select(:token, :id) | comment_result.select(:token, :id)
      elsif params[:post] && !params[:comment]
        @count = post_count
        result = post_result.select(:token, :id)
      else
        @count = comment_count
        result = comment_result.select(:token, :id)
      end

      CSV.open("data/cloud_text.csv", "wb") do |csv|
        result.find_all do |res|
          csv << res.attributes.values
        end
        `python3 lib/tasks/Wordcloud/main.py`
      end
    end
  end

  def diffusion
  end
end
