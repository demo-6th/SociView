class QueriesController < ApplicationController
  before_action :authenticate_user!
  layout "homepage"
  require 'csv'

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
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time ).result.sort_by{|x| x[:created_at]}
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time ).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by{|x| x[:created_at]}
        @count = @posts.count + @comment_total.count
      elsif params[:post] && !params[:comment]  #只找Post
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time ).result.sort_by{|x| x[:created_at]}
        @count = @posts.count
      else #只找Comment
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time ).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by{|x| x[:created_at]}
        @count = @comment_total.count
      end
    elsif params[:dcard] && !params[:ptt] #只找Dcard
      @source_id = 1
      if params[:post] && params[:comment] #同時找Post & Comment
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time ,board_source_id_eq: @source_id ).result.sort_by{|x| x[:created_at]}
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time,post_board_source_id_eq: @source_id).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time,post_board_source_id_eq: @source_id).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by{|x| x[:created_at]}
        @count = @posts.count + @comment_total.count
      elsif params[:post] && !params[:comment]  #只找Post
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time ,board_source_id_eq: @source_id ).result.sort_by{|x| x[:created_at]}
        @count = @posts.count
      else  #只找Comment
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time,post_board_source_id_eq: @source_id).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time,post_board_source_id_eq: @source_id).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by{|x| x[:created_at]}
        @count = @comment_total.count
      end
    else #只找PTT
      @source_id = 2
      if params[:post] && params[:comment] #同時找Post & Comment
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time ,board_source_id_eq: @source_id ).result.sort_by{|x| x[:created_at]}
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time,post_board_source_id_eq: @source_id).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time,post_board_source_id_eq: @source_id).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by{|x| x[:created_at]}
        @count = @posts.count + @comment_total.count
      elsif params[:post] && !params[:comment]  #只找Post
        @posts = Post.ransack(title_or_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time ,board_source_id_eq: @source_id ).result.sort_by{|x| x[:created_at]}
        @count = @posts.count
      else  #只找Comment
        @post_comment = Comment.ransack(post_title_or_post_content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time,post_board_source_id_eq: @source_id).result
        @comments = Comment.ransack(content_cont_any: @theme, created_at_gteq_any: @start_time, created_at_lteq_any: @end_time,post_board_source_id_eq: @source_id).result
        @comment_total = @post_comment + @comments
        @comment_total = @comment_total.uniq.sort_by{|x| x[:created_at]}
        @count = @comment_total.count
      end
    end
  end

  def sentiment; end

  def sentpost
    search_box()
    search_result = doc_type(@type,:sentiment,:created_at)
    result = search_result[0]
    @count = search_result[1]

    gon.start = @start
    gon.end = @end
    gon.result = result

    render json: { count: @count, theme: @theme, source: @source, type: @type, end: @end, start: @start, gon: { start: gon.start, end: gon.end, result: gon.result, count: @count, theme: gon.theme } }
  end

  def volume; end

  def volumepost
    # pass value down to api action
    @theme = [params[:theme1], params[:theme2], params[:theme3]].delete_if { |x| x == nil }
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:start].to_date
    @end = params[:end].to_date
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }

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


    render json: { count1: @count1, count2: @count2, count3: @count3, theme: @theme, start: @start, end: @end, source: @source, type: @type, gon: { start: gon.start, end: gon.end, theme1: gon.theme1, theme2: gon.theme2, theme3: gon.theme3, result1: gon.result1, count1: gon.count1, count2:  gon.count2  } }
  end

  def topic; end

  def topicpost
    search_box()
    search_result = doc_type(@type,:token,:id)
    result = search_result[0]
    @count = search_result[1]

    CSV.open("data/topic_text.csv", "wb") do |csv|
      result.find_all do |res|
        csv << res.attributes.values
      end
    end
    @topic = `python3 lib/tasks/Topic/main.py params`
  end

  def wordcloud; end

  def cloudpost
    search_box()
    search_result = doc_type(@type,:no_stop,:id)
    result = search_result[0]
    @count = search_result[1]

    CSV.open("data/cloud_text.csv", "wb") do |csv|
      result.find_all do |res|
        csv << res.attributes.values
      end
      @cloud = `python3 lib/tasks/Wordcloud/main.py params`
    end
  end

  def termfreq; end

  def termfreqpost
    search_box()
    search_result = doc_type(@type,:token,:pos)
    result = search_result[0]
    @count = search_result[1]

    CSV.open("data/tf_data.csv", "wb") do |csv|
      result.find_all do |res|
        csv << res.attributes.values
      end 
      @termfreq = `python3 lib/tasks/Termfreq/main.py params`
    end

    def tf_check(pos)
      if File.exist?("data/tf_#{pos}.csv")
        table = CSV.read("data/tf_#{pos}.csv") 
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


  private
  # search box 
  def search_box 
    @theme = params[:theme]
    @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
    @start = params[:start].to_date
    @end = params[:end].to_date
    @type = [params[:post], params[:comment]].delete_if { |x| x == nil }
  end 

  # topic keywords array
  def topic(theme)
    result = []
    if theme == "萊豬"
      result = ["萊豬","萊克多巴胺","萊牛","瘦肉精","食安","受體素","美國國會","副作用","美國FDA","CODEX","聯合國國際食品法典委員會","容許量","食品安全衛生管理法","萊劑","AIT","藥物","毒豬","毒牛","溫體","冷凍豬肉","殘留"]
    elsif theme == "新冠肺炎"
      result = ["口罩","武漢","陳時中","鋼鐵部長","誠實中","疾病管制署","Covid","傳染","疫情","防疫","肺炎","感染","疫苗","疫情指揮中心","張上淳","陳宗彥","周志浩","莊人祥","1922","疾管","本土案例","境外案例","病例","偽出國","變種病毒","瘟疫","疫調","病毒","染疫","自主健康管理","隔離","隔離檢疫","居家隔離","居家檢疫","中國武肺","味覺喪失","嗅覺喪失","採檢","CT值","超前部署","新冠疫苗","無症狀","境外移入","確診","敦陸艦隊"]
    end 
    return result 
  end 

  # source array 
  def source(array)
    if array.length == 2
      return [1,2]
    elsif array.include?("Dcard")
      return [1]
    else 
      return [2]
    end 
  end 

  # search based on doc_type 
  def doc_type(array, col1, col2)
    if array.length == 2
      search_all(@start.midnight, @end.end_of_day, topic(@theme),source(@source), col1, col2)
    elsif array.include?("主文") 
      search_post(@start.midnight, @end.end_of_day, topic(@theme),source(@source), col1, col2)
    else 
      search_comment(@start.midnight, @end.end_of_day, topic(@theme),source(@source), col1, col2)
    end 
  end 

  # search_post (@start, @end, topic(@theme), source(@source))
  def search_post(start_date,end_date,keywords,source,col1, col2)
    result = Post.ransack(created_at_gt: start_date,created_at_lt: end_date, alias_in: Board.ransack(source_id_in:source).result.pluck(:alias), title_or_content_cont_any:keywords).result
    return result.select(col1,col2), result.count
  end 

  # search_comment
  def search_comment(start_date,end_date,keywords,source, col1, col2)
    # comment content itself contains the keyword + comments under posts that matches the topic & drop repeated comments
    result = Comment.ransack(pid_in:Post.ransack(created_at_gt: start_date,created_at_lt: end_date, alias_in: Board.ransack(source_id_in:source).result.pluck(:alias), title_or_content_cont_any:keywords).result.pluck(:pid)).result.or(Comment.ransack(created_at_gt: start_date,created_at_lt: end_date, alias_in: Board.ransack(source_id_in:source).result.pluck(:alias), content_cont_any:keywords).result)
    return result.select(col1,col2), result.count
  end 

  def search_all(start_date,end_date,keywords,source, col1, col2)
    count = search_post(@start.midnight, @end.end_of_day, topic(@theme),source(@source), col1, col2)[1]+search_comment(@start.midnight, @end.end_of_day, topic(@theme),source(@source), col1, col2)[1]
    result = search_post(@start.midnight, @end.end_of_day, topic(@theme),source(@source), col1, col2)[0]|search_comment(@start.midnight, @end.end_of_day, topic(@theme),source(@source), col1, col2)[0]
    return result, count 
  end 
end

