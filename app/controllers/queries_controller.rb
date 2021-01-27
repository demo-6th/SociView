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
    @start = params[:start].to_s
    @end = params[:end].to_s
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }

    if params[:dcard] && params[:ptt] #同時搜尋Dcard & PTT
      if params[:post] && params[:comment] #同時找Post & Comment
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time).result.sort_by { |x| x[:created_at] }
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by { |x| x[:created_at] }
        @count = @posts.count + @comment_total.count
      elsif params[:post] && !params[:comment] #只找Post
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time).result.sort_by { |x| x[:created_at] }
        @count = @posts.count
      else #只找Comment
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by { |x| x[:created_at] }
        @count = @comment_total.count
      end
    elsif params[:dcard] && !params[:ptt] #只找Dcard
      @source_id = 1
      if params[:post] && params[:comment] #同時找Post & Comment
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, board_source_id_eq: @source_id).result.sort_by { |x| x[:created_at] }
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, post_board_source_id_eq: @source_id).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, post_board_source_id_eq: @source_id).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by { |x| x[:created_at] }
        @count = @posts.count + @comment_total.count
      elsif params[:post] && !params[:comment] #只找Post
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, board_source_id_eq: @source_id).result.sort_by { |x| x[:created_at] }
        @count = @posts.count
      else #只找Comment
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, post_board_source_id_eq: @source_id).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, post_board_source_id_eq: @source_id).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by { |x| x[:created_at] }
        @count = @comment_total.count
      end
    else #只找PTT
      @source_id = 2
      if params[:post] && params[:comment] #同時找Post & Comment
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, board_source_id_eq: @source_id).result.sort_by { |x| x[:created_at] }
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, post_board_source_id_eq: @source_id).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, post_board_source_id_eq: @source_id).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by { |x| x[:created_at] }
        @count = @posts.count + @comment_total.count
      elsif params[:post] && !params[:comment] #只找Post
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, board_source_id_eq: @source_id).result.sort_by { |x| x[:created_at] }
        @count = @posts.count
      else #只找Comment
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, post_board_source_id_eq: @source_id).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time, post_board_source_id_eq: @source_id).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by { |x| x[:created_at] }
        @count = @comment_total.count
      end
    end
  end

  def volume; end

  def volumepost
    gon.start = @start
    gon.end = @end
    check_search_box()
    #theme1
    post_result1 = checkbox_search_all(@theme[0], @start, @end, @source)[0]
    comment_result1 = checkbox_search_all(@theme[0], @start, @end, @source)[1]
    result1 = type_judgment(post_result1, comment_result1)
    @count1 = result1.count
    gon.result1 = result1
    gon.count1 = @count1
    gon.theme1 = @theme[0]
    #theme2
    post_result2 = checkbox_search_all(@theme[1], @start, @end, @source)[0]
    comment_result2 = checkbox_search_all(@theme[1], @start, @end, @source)[1]
    result2 = type_judgment(post_result2, comment_result2)
    @count2 = result2.count
    gon.result2 = result2
    gon.count2 = @count2
    gon.theme2 = @theme[1]

    #theme3
    if @theme[2].nil? || @theme[2].empty?
      @count3 = 0
    else
      @theme[2] = params[:theme3_input]
      post_result3 = checkbox_search_all(@theme[2], @start, @end, @source)[0]
      comment_result3 = checkbox_search_all(@theme[2], @start, @end, @source)[1]
      result3 = type_judgment(post_result3, comment_result3)
      @count3 = result3.count
      gon.result3 = result3
      gon.count3 = @count3
      gon.theme3 = @theme[2]
    end
  end

  def sentiment; end

  def sentpost
    radio_search_box()
    search_result = doc_type(@type, :sentiment, :created_at)
    result = search_result[0]
    @count = search_result[1]
    gon.start = @start
    gon.end = @end
    gon.result = result
  end

  def topic; end

  def topicpost
    radio_search_box()
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
    radio_search_box()
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
    radio_search_box()
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

  def sourcepost
    # pass value down to api action
    @theme = params[:theme1] || params[:theme2] || params[:theme3_input]
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:start].to_date
    @end = params[:end].to_date
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }

    #theme1
    post_result = Post.ransack(created_at_gt: @start, created_at_lt: @end + 1, title_or_content_cont_any: @theme).result.joins(board: :source).where(boards: { sources: { name: @source } })

    comment_search = Comment.joins(post: [board: :source]).where(comments: { posts: { boards: { sources: { name: @source } } } }).ransack(created_at_gt: @start, created_at_lt: @end + 1).result

    comment_result = comment_search.ransack(content_cont_any: @theme).result.or(comment_search.where(:pid => post_result.pluck(:pid)))

    ###ptt_source
    ptt_post = Post.ransack(created_at_gt: @start, created_at_lt: @end + 1, title_or_content_cont_any: @theme).result.joins(board: :source).where(boards: { sources: { name: "PTT" } })

    comment_ptt_search = Comment.joins(post: [board: :source]).where(comments: { posts: { boards: { sources: { name: "PTT" } } } }).ransack(created_at_gt: @start, created_at_lt: @end + 1).result

    ptt_comment = comment_ptt_search.ransack(content_cont_any: @theme).result.or(comment_ptt_search.where(:pid => ptt_post.pluck(:pid)))

    ###dcard_source
    dcard_post = Post.ransack(created_at_gt: @start, created_at_lt: @end + 1, title_or_content_cont_any: @theme).result.joins(board: :source).where(boards: { sources: { name: "Dcard" } })

    comment_dcard_search = Comment.joins(post: [board: :source]).where(comments: { posts: { boards: { sources: { name: "Dcard" } } } }).ransack(created_at_gt: @start, created_at_lt: @end + 1).result

    dcard_comment = comment_dcard_search.ransack(content_cont_any: @theme).result.or(comment_dcard_search.where(:pid => dcard_post.pluck(:pid)))

    # 計算符合搜尋條件的資料筆數
    if params[:post] && params[:comment]
      @count = post_result.count + comment_result.count
      gon.result = post_result + comment_result
      gon.ptt_result = ptt_post + ptt_comment
      gon.dcard_result = dcard_post + dcard_comment
    elsif params[:post] && !params[:comment]
      @count = post_result.count
      gon.result = post_result
      gon.ptt_result = ptt_post
      gon.dcard_result = dcard_post
    else
      @count = comment_result.count
      gon.result = comment_result
      gon.ptt_result = ptt_comment
      gon.dcard_result = dcard_comment
    end

    gon.start = @start
    gon.end = @end
    gon.board = Board.all
  end
end
