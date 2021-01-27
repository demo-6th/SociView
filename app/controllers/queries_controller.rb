class QueriesController < ApplicationController
  # before_action :authenticate_user!
  layout "homepage"
  require "csv"
  load "app/services/user_search.rb"

  def index; end

  def list; end

  def listpost
    @theme = params[:theme]
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:start].to_date
    @end = params[:end].to_date
    @type = case true
            when params[:type] == '回文' then "回文"
            else
              "文章"
            end
    @sentiment = case true
                 when params[:sentiment] == "不分情緒"  then ""
                 when params[:sentiment] == "正面"  then "positive"
                 when params[:sentiment] == "負面"  then "negative"
                 when params[:sentiment] == "中立"  then "neutral"
                 end
    @sort = case true
                 when params[:sort] == '由新到舊'  then :desc
                 when params[:sort] == '由舊到新'  then :asc
                 when params[:sort] == '按讚數多'  then :desc
                 when params[:sort] == '按讚數少'  then :asc
                 end
      
    if @type == "回文"
      post_result = Post.ransack(created_at_gt: @start, created_at_lt: @end + 1, title_or_content_cont_any: @theme,sentiment_cont_any: @sentiment).result.joins(board: :source).where(boards: { sources: { name: @source } })

      comment_search = Comment.joins(post: [board: :source]).where(comments: { posts: { boards: { sources: { name: @source } } } }).ransack(created_at_gt: @start, created_at_lt: @end + 1,sentiment_cont_any: @sentiment).result

      @result = comment_search.ransack(content_cont_any: @theme,sentiment_cont_any: @sentiment).result.or(comment_search.where(pid: post_result))
    else
      @result = Post.ransack(created_at_gt: @start, created_at_lt: @end + 1, title_or_content_cont_any: @theme,sentiment_cont_any: @sentiment).result.joins(board: :source).where(boards: { sources: { name: @source } })
    end

    if params[:sort] == '由新到舊' || params[:sort] == '由舊到新'
      @results = @result.order(created_at: @sort).page(params[:page]).per(20)
    else
      @results = @result.order(like_count: @sort).page(params[:page]).per(20)
    end
   @count = @results.total_count
  end

  def volume; end

  def volumepost
    # pass value down to api action
    @theme = [params[:theme1], params[:theme2], params[:theme3]].delete_if { |x| x == nil }
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:start].to_date
    @end = params[:end].to_date
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }
    puts "===================="
    puts @count1
    puts @count2
    puts "===================="

    #theme1
    @post_result1 = Post.where("created_at >= ? and created_at <= ?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme[0]}%", "%#{@theme[0]}%")
    @comment_result1 = Comment.where("created_at >= ? and created_at <= ?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme[0]}%", "%#{@theme[0]}%").pluck(:pid)).or(Comment.where("content like ?", "%#{@theme[0]}%"))

    #theme2
    @post_result2 = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme[1]}%", "%#{@theme[1]}%")
    @comment_result2 = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme[1]}%", "%#{@theme[1]}%").pluck(:pid)).or(Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme[1]}%"))

    #theme3
    if @theme[2].nil?
      @count3 = 0
    else
      gon.theme3 = @theme[2]

      @post_result3 = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme[2]}%", "%#{@theme[2]}%")
      @comment_result3 = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme[2]}%", "%#{@theme[2]}%").pluck(:pid)).or(Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme[2]}%"))

      post_count3 = @post_result3.count
      comment_count3 = @comment_result3.count

      #待改進
      if params[:post] && params[:comment]
        @count3 = post_count3 + comment_count3
        gon.result3 = @post_result3 + @comment_result3
      elsif params[:post] && !params[:comment]
        @count3 = post_count3
        gon.result3 = @post_result3
      else
        @count3 = comment_count3
        gon.result3 = @comment_result3
      end
      gon.count3 = @count3
    end

    # 計算符合搜尋條件的資料筆數
    gon.start = @start
    gon.end = @end
    gon.theme1 = @theme[0]
    gon.theme2 = @theme[1]

    post_count1 = @post_result1.count
    comment_count1 = @comment_result1.count
    post_count2 = @post_result2.count
    comment_count2 = @comment_result2.count

    #待改進
    if params[:post] && params[:comment]
      @count1 = post_count1 + comment_count1
      gon.result1 = @post_result1 + @comment_result1
    elsif params[:post] && !params[:comment]
      @count1 = post_count1
      gon.result1 = @post_result1
    else
      @count1 = comment_count1
      gon.result1 = @comment_result1
    end
    gon.count1 = @count1

    #待改進
    if params[:post] && params[:comment]
      @count2 = post_count2 + comment_count2
      gon.result2 = @post_result2 + @comment_result2
    elsif params[:post] && !params[:comment]
      @count2 = post_count2
      gon.result2 = @post_result2
    else
      @count2 = comment_count2
      gon.result2 = @comment_result2
    end
    gon.count2 = @count2
    gon.count1 = @count1

    # render json: { count1: @count1, count2: @count2, count3: @count3, theme: @theme, start: @start, end: @end, source: @source, type: @type, gon: { start: gon.start, end: gon.end, theme1: gon.theme1, theme2: gon.theme2, theme3: gon.theme3, result1: gon.result1, count1: gon.count1, count2:  gon.count2  } }
  end

  def sentiment; end

  def sentpost
    search_box()
    search_result = doc_type(@type, :sentiment, :created_at)
    result = search_result[0]
    @count = search_result[1]

    gon.start = @start
    gon.end = @end
    gon.result = result

    # render json: { count: @count, theme: @theme, source: @source, type: @type, end: @end, start: @start, gon: { start: gon.start, end: gon.end, result: gon.result, count: @count, theme: gon.theme } }
  end

  def topic; end

  def topicpost
    search_box()
    search_result = doc_type(@type, :token, :id)
    result = search_result[0]
    @count = search_result[1]

    CSV.open("#{Rails.root}/data/topic_text.csv", "wb") do |csv|
      result.find_all do |res|
        csv << res.attributes.values
      end
    end
    @topic = `python3 #{Rails.root}/lib/tasks/Topic/main.py #{Rails.root}`
  end

  def wordcloud; end

  def cloudpost
    search_box()
    search_result = doc_type(@type, :no_stop, :id)
    result = search_result[0]
    @count = search_result[1]

    CSV.open("#{Rails.root}/data/cloud_text.csv", "wb") do |csv|
      result.find_all do |res|
        csv << res.attributes.values
      end
      @cloud = `python3 #{Rails.root}/lib/tasks/Wordcloud/main.py #{Rails.root}/`
    end
  end

  def termfreq; end

  def termfreqpost
    search_box()
    search_result = doc_type(@type, :token, :pos)
    result = search_result[0]
    @count = search_result[1]

    CSV.open("#{Rails.root}/data/tf_data.csv", "wb") do |csv|
      result.find_all do |res|
        csv << res.attributes.values
      end
      @termfreq = `python3 #{Rails.root}/lib/tasks/Termfreq/main.py #{Rails.root}/`
    end

    def tf_check(pos)
      if File.exist?("#{Rails.root}/data/tf_#{pos}.csv")
        table = CSV.read("#{Rails.root}/data/tf_#{pos}.csv")
        gon.term = table[0]
        gon.freq = table[1]
      end
      return gon.term, gon.freq
    end

    v = tf_check("V")
    n = tf_check("N")
    a = tf_check("A")
    gon.vterm, gon.vfreq = v
    gon.nterm, gon.nfreq = n
    gon.adjterm, gon.adjfreq = a
  end
end
