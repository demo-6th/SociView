class QueriesController < ApplicationController
  # before_action :authenticate_user!
  layout "homepage"
  require "csv"

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
                 when params[:sentiment] == "正面情緒"  then "positive"
                 when params[:sentiment] == "負面情緒"  then "negative"
                 when params[:sentiment] == "中立情緒"  then "neutral"
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
      @results = @result.order(created_at: @sort).page(params[:page]).per(50)
    else
      @results = @result.order(like_count: @sort).page(params[:page]).per(50)
    end
   @count = @results.total_count
  end

  def volume; end

  def volumepost
    check_search_box()
    gon.start = @start
    gon.end = @end
    #theme1
    post_result1 = checkbox_search_all(@theme[0], @start, @end, @source)[0]
    comment_result1 = checkbox_search_all(@theme[0], @start, @end, @source)[1]
    result1 = type_judgment(post_result1, comment_result1)
    @count1 = result1.count
    gon.result1 = result1
    gon.count1 = @count1
    gon.theme1 = @theme[0]
    #theme2
    @theme[1] = params[:theme3_input] if @theme[1] == "自選主題"
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

private

# search
def radio_search_box
  @theme = params[:theme1] || params[:theme2] || params[:theme3_input]
  @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
  @start = params[:start].to_date
  @end = params[:end].to_date
  @type = [params[:post], params[:comment]].delete_if { |x| x == nil }
end

def check_search_box
  @theme = [params[:theme1], params[:theme2], params[:theme3]].delete_if { |x| x == nil }
  @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
  @start = params[:start].to_date
  @end = params[:end].to_date
  @type = [params[:post], params[:comment]].delete_if { |x| x == nil }
end

# topic keywords array
def theme_keywords(theme)
  result = []
  if theme == "萊豬"
    # result = ["萊豬", "萊克多巴胺", "萊牛", "瘦肉精", "食安", "受體素", "美國國會", "副作用", "美國FDA", "CODEX", "聯合國國際食品法典委員會", "容許量", "食品安全衛生管理法", "萊劑", "AIT", "藥物", "毒豬", "毒牛", "溫體", "冷凍豬肉", "殘留"]
    result = ["萊豬", "萊克多巴胺", "毒豬"]
  elsif theme == "新冠肺炎"
    # result = ["口罩", "武漢", "陳時中", "鋼鐵部長", "誠實中", "疾病管制署", "Covid", "傳染", "疫情", "防疫", "肺炎", "感染", "疫苗", "疫情指揮中心", "張上淳", "陳宗彥", "周志浩", "莊人祥", "1922", "疾管", "本土案例", "境外案例", "病例", "偽出國", "變種病毒", "瘟疫", "疫調", "病毒", "染疫", "自主健康管理", "隔離", "隔離檢疫", "居家隔離", "居家檢疫", "中國武肺", "味覺喪失", "嗅覺喪失", "採檢", "CT值", "超前部署", "新冠疫苗", "無症狀", "境外移入", "確診", "敦陸艦隊"]
    result = ["武漢肺炎", "武肺", "新冠肺炎", "疫情"]
  else
    result = [theme]
  end
  return result
end

# search_post (@start, @end, topic(@theme), source(@source))
def search_post(start_date, end_date, keywords, col1, col2)
  result = Post.ransack(created_at_gt: start_date, created_at_lt: end_date, title_or_content_cont_any: keywords).result.joins(board: :source).where(boards: { sources: { name: @source } })
  return result.select(col1, col2), result.count, result
end

# search_comment
def search_comment(start_date, end_date, keywords, col1, col2)
  comment_search = Comment.joins(post: [board: :source]).where(comments: { posts: { boards: { sources: { name: @source } } } }).ransack(created_at_gt: start_date, created_at_lt: end_date).result

  result = comment_search.ransack(content_cont_any: keywords).result.or(comment_search.where(:pid => search_post(start_date, end_date, keywords, col1, col2)[2].pluck(:pid)))

  return result.select(col1, col2), result.count
end

def search_all(start_date, end_date, keywords, col1, col2)
  result = search_post(start_date, end_date, keywords, col1, col2)[0] | search_comment(start_date, end_date, keywords, col1, col2)[0]
  count = search_post(start_date, end_date, keywords, col1, col2)[1] + search_comment(start_date, end_date, keywords, col1, col2)[1]
  return result, count
end

# search based on doc_type
def doc_type(array, col1, col2)
  if array.length == 2
    search_all(@start.midnight, @end.end_of_day, theme_keywords(@theme), col1, col2)
  elsif array.include?("主文")
    search_post(@start.midnight, @end.end_of_day, theme_keywords(@theme), col1, col2)
  else
    search_comment(@start.midnight, @end.end_of_day, theme_keywords(@theme), col1, col2)
  end
end

def type_judgment(post, comment)
  if params[:post] && params[:comment]
    result = post + comment
  elsif params[:post] && !params[:comment]
    result = post
  else
    result = comment
  end
  return result
end

def checkbox_search_all(theme, d_start, d_end, source)
  post_result = Post.ransack(created_at_gt: d_start, created_at_lt: d_end + 1, title_or_content_cont_any: theme_keywords(theme)).result.joins(board: :source).where(boards: { sources: { name: source } })
  comment_search = Comment.joins(post: [board: :source]).where(comments: { posts: { boards: { sources: { name: source } } } }).ransack(created_at_gt: d_start, created_at_lt: d_end + 1).result
  comment_result = comment_search.ransack(content_cont_any: theme_keywords(theme)).result.or(comment_search.where(:pid => post_result.pluck(:pid)))
  return post_result, comment_result
end
