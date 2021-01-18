class QueriesController < ApplicationController
  before_action :authenticate_user!
  layout "homepage"

  def index; end

  def list; end

  def listpost
    @theme = params[:theme]
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_s
    @end = params[:user][:end].to_s
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }
    query = @theme.presence
    if params[:post] && params[:comment]
      search_post_only(query) 
      search_comment_only(query) 
      @comment_all = []
      @posts.each do |post| 
        post.comments.each do |comment| 
          @comment_all << comment
        end
      end
      @comment_all = @comment_all.select { |post_comment| post_comment.created_at >= @start and post_comment.created_at <= @end}
      @comment_all += @comments
      @comment_tatal = @comment_all.uniq.sort_by{|x| x[:created_at]}
      post_count = @posts.count
      comment_count = @comment_tatal.count
      @count = post_count + comment_count
    elsif params[:post] && !params[:comment]
      search_post_only(query)
      post_count = @posts.count
      @count = post_count
    else
      search_comment_only(query)
      comment_count = @comments.count
      @comment_tatal = @comments.uniq.sort_by{|x| x[:created_at]}
      @count = comment_count
    end
    p "============================================"
  end

  def sentiment; end

  def sentpost
    # pass value down to api action
    @theme = params[:theme]
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_date
    @end = params[:user][:end].to_date
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }

    #theme1
    @post_result = Post.where("created_at >= ? and created_at <= ?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme}%", "%#{@theme}%")
    @comment_result = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme}%", "%#{@theme}%").pluck(:pid)).or(Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme}%"))

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

  def volume; end

  def volumepost
    # pass value down to api action
    @theme = [params[:theme1], params[:theme2], params[:theme3]].delete_if { |x| x == nil }
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_date
    @end = params[:user][:end].to_date
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }

    #theme1
    @post_result1 = Post.where("created_at >= ? and created_at <= ?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme[0]}%", "%#{@theme[0]}%")
    @comment_result1 = Comment.where("created_at >= ? and created_at <= ?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme[0]}%", "%#{@theme[0]}%").pluck(:pid)).or(Comment.where("content like ?", "%#{@theme[0]}%"))

    #theme2
    @post_result2 = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme[1]}%", "%#{@theme[1]}%")
    @comment_result2 = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme[1]}%", "%#{@theme[1]}%").pluck(:pid)).or(Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme[1]}%"))

    #theme3
    @post_result3 = Post.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme[2]}%", "%#{@theme[2]}%")
    @comment_result3 = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme[2]}%", "%#{@theme[2]}%").pluck(:pid)).or(Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme[2]}%"))

    # 計算符合搜尋條件的資料筆數
    gon.start = @start
    gon.end = @end
    gon.theme1 = @theme[0]
    gon.theme2 = @theme[1]
    gon.theme3 = @theme[2]
    post_count1 = @post_result1.count
    comment_count1 = @comment_result1.count
    post_count2 = @post_result2.count
    comment_count2 = @comment_result2.count
    post_count3 = @post_result3.count
    comment_count3 = @comment_result3.count

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

  def topic; end

  def topicpost
    # pass value down to api action
    @theme = params[:theme]
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_date
    @end = params[:user][:end].to_date
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }

    #theme1
    post_result = Post.where("created_at >= ? and created_at <= ?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme}%", "%#{@theme}%")
    comment_result = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme}%", "%#{@theme}%").pluck(:pid)).or(Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme}%"))

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
    end
    @topic = `python3 lib/tasks/Topic/main.py params`
  end

  def wordcloud; end

  def cloudpost
    # pass value down to api action
    @theme = params[:theme]
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:user][:start].to_date
    @end = params[:user][:end].to_date
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }

    post_result = Post.where("created_at >= ? and created_at <= ?", @start.midnight, @end.end_of_day).where("content like ? or title like ?", "%#{@theme}%", "%#{@theme}%")
    comment_result = Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ? or title like ?", "%#{@theme}%", "%#{@theme}%").pluck(:pid)).or(Comment.where("created_at >= ? and created_at <=?", @start.midnight, @end.end_of_day).where("content like ?", "%#{@theme}%"))

    post_count = post_result.count
    comment_count = comment_result.count

    if params[:post] && params[:comment]
      @count = post_count + comment_count
      result = post_result.select(:no_stop, :id) | comment_result.select(:no_stop, :id)
    elsif params[:post] && !params[:comment]
      @count = post_count
      result = post_result.select(:no_stop, :id)
    else
      @count = comment_count
      result = comment_result.select(:no_stop, :id)
    end

    CSV.open("data/cloud_text.csv", "wb") do |csv|
      result.find_all do |res|
        csv << res.attributes.values
      end
      @cloud = `python3 lib/tasks/Wordcloud/main.py params`
    end
  end

  def diffusion; end

  private
  def search_post_only(query)
    @posts = Post.search query,fields: [:title, :content], misspellings: false,where: {created_at: {gte: @start, lte: @end}},order: {created_at: {order: "asc"}}
  end
  def search_comment_only(query)
    @comments = Comment.search query,fields: [:content], misspellings: false,where: {created_at: {gte: @start, lte: @end}}
  end
end
