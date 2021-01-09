class QueriesController < ApplicationController
  layout "homepage"
  def index
    
  end

  def list
  end

  def sentiment
    # pass value down to api action
    @theme = params[:theme]
    @source = [params[:dcard],params[:ptt]]
    @start = params[:user][:start].to_date 
    @end = params[:user][:end].to_date
    @type = [params[:post],params[:comment]]

    # 主題查詢條件（現在是隨便寫）
    @query = ""
    if @theme == "1"
      @query = "%期末%"
    elsif @theme == "2"
      @query = "%筆電%"
    else 
      @query = "%貓%"
    end 
    
    @post_result = Post.where('created_at >= ? and created_at <=?', @start.midnight, @end.end_of_day).where("content like ?",@query).or(Post.where("title like ?",@query))

    @comment_result = Comment.where('created_at >= ? and created_at <=?', @start.midnight, @end.end_of_day).where(:pid => Post.where("content like ?",@query).or(Post.where("title like ?", @query)).pluck(:pid)).or(Comment.where("content like ?", @query))
    
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

  def volume
  end

  def topic
  end

  def wordcloud
  end

  def diffusion
  end

end
     