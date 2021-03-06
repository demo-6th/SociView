class QueriesController < ApplicationController
  # before_action :authenticate_user!
  layout "homepage"
  require "csv"

  def index; end

  def volumepost
    check_search_box()
    gon.start = @start
    gon.end = @end

    #theme1
    theme1_search_result = checkbox_doc_type(@type, @theme[0], :id, :created_at)
    result1 = theme1_search_result[0]
    @theme1_count = theme1_search_result[1]
    gon.result1 = result1
    gon.count1 = @theme1_count
    gon.theme1 = @theme[0]

    #theme2
    @theme[1] = params[:theme3_input] if @theme[1] == "自選主題"
    theme2_search_result = checkbox_doc_type(@type, @theme[1], :id, :created_at)
    result2 = theme2_search_result[0]
    @theme2_count = theme2_search_result[1]
    gon.result2 = result2
    gon.count2 = @theme2_count
    gon.theme2 = @theme[1]

    #theme3
    if @theme[2].nil?
      @theme3_count = 0
    else
      @theme[2] = params[:theme3_input]
      theme3_search_result = checkbox_doc_type(@type, @theme[2], :id, :created_at)
      result3 = theme3_search_result[0]
      @theme3_count = theme3_search_result[1]
      gon.result3 = result3
      gon.count3 = @theme3_count
      gon.theme3 = @theme[2]
    end
  end

  def sentpost
    radio_search_box()
    search_result = doc_type(@type, :sentiment, :created_at)
    result = search_result[0]
    @count = search_result[1]
    gon.start = @start
    gon.end = @end
    gon.result = result
  end

  def listpost
    radio_search_box()
    sentiment = case true
      when params[:sentiment] == "不分情緒" then ""
      when params[:sentiment] == "正面情緒" then "positive"
      when params[:sentiment] == "負面情緒" then "negative"
      when params[:sentiment] == "中立情緒" then "neutral"
      end
    sort = case true
      when params[:sort] == "由新到舊" then :desc
      when params[:sort] == "由舊到新" then :asc
      when params[:sort] == "按讚數多" then :desc
      when params[:sort] == "按讚數少" then :asc
      end

    search_result = doc_type(@type, "", "")
    result = search_result[0].ransack(sentiment_cont: sentiment).result
    @count = search_result[1]

    if params[:sort] == "由新到舊" || params[:sort] == "由舊到新"
      @results = result.order(created_at: sort).page(params[:page]).per(50)
    else
      @results = result.order(like_count: sort).page(params[:page]).per(50)
    end
  end

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
    radio_search_box()
    #theme1
    search_result = doc_type(@type, :alias, :created_at)
    result = search_result[0]
    @count = search_result[1]
    gon.result = result

    ###ptt_source
    @source = params[:ptt]
    ptt_search_result = doc_type(@type, :alias, :created_at)
    ptt_result = ptt_search_result[0]
    gon.ptt_result = ptt_result

    ###dcard_source
    @source = params[:dcard]
    dcard_search_result = doc_type(@type, :alias, :created_at)
    dcard_result = dcard_search_result[0]
    gon.dcard_result = dcard_result

    radio_search_box()
    gon.start = @start
    gon.end = @end
    gon.board = Board.all
  end

  def topicpost
    radio_search_box()
    search_result = doc_type(@type, :token, :id)
    if search_result[1] >= 1000
      result = search_result[0].sample(1000)
    else
      result = search_result[0]
    end

    @count = search_result[1]

    CSV.open("#{Rails.root}/data/topic_text.csv", "wb") do |csv|
      result.find_all do |res|
        csv << res.attributes.values
      end
    end
    @topic = `python3 #{Rails.root}/lib/tasks/Topic/main.py #{Rails.root}`
  end
end

private

# search
def radio_search_box
  @theme = params[:theme1] || params[:theme2] || params[:theme3_input]
  @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
  # @start = params[:start].to_date
  # @end = params[:end].to_date
  @start = "2021-01-17".to_date
  @end = "2021-01-21".to_date
  @type = [params[:post], params[:comment]].delete_if { |x| x == nil }
end

def check_search_box
  @theme = [params[:theme1], params[:theme2], params[:theme3]].delete_if { |x| x == nil }
  @source = [params[:dcard], params[:ptt]].delete_if { |x| x == nil }
  # @start = params[:start].to_date
  # @end = params[:end].to_date
  @start = "2021-01-17".to_date
  @end = "2021-01-21".to_date
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
    result = ["肺炎", "疫情"]
  else
    result = [theme]
  end
  return result
end

# search_post (@start, @end, topic(@theme), source(@source))
def search_post(start_date, end_date, keywords, col1, col2)
  result = Post.ransack(created_at_gt: start_date, created_at_lt: end_date, title_or_content_cont_any: keywords).result.joins(board: :source).where(boards: { sources: { name: @source } })
  return result.select(col1, col2), result.size, result
end

# search_comment
def search_comment(start_date, end_date, keywords, col1, col2)
  comment_search = Comment.joins(post: [board: :source]).where(comments: { posts: { boards: { sources: { name: @source } } } }).ransack(created_at_gt: start_date, created_at_lt: end_date).result

  result = comment_search.ransack(content_cont_any: keywords).result.or(comment_search.where(:pid => search_post(start_date, end_date, keywords, col1, col2)[2].pluck(:pid)))

  return result.select(col1, col2), result.size
end

def search_all(start_date, end_date, keywords, col1, col2)
  result = search_post(start_date, end_date, keywords, col1, col2)[0] | search_comment(start_date, end_date, keywords, col1, col2)[0]
  count = search_post(start_date, end_date, keywords, col1, col2)[1] + search_comment(start_date, end_date, keywords, col1, col2)[1]
  return result, count
end

# search based on doc_type
def doc_type(array, col1, col2)
  if array.length == 2
    search_all(@start, @end + 1, theme_keywords(@theme), col1, col2)
  elsif array.include?("主文")
    search_post(@start, @end + 1, theme_keywords(@theme), col1, col2)
  else
    search_comment(@start, @end + 1, theme_keywords(@theme), col1, col2)
  end
end

def checkbox_doc_type(array, theme, col1, col2)
  if array.length == 2
    search_all(@start, @end + 1, theme_keywords(theme), col1, col2)
  elsif array.include?("主文")
    search_post(@start, @end + 1, theme_keywords(theme), col1, col2)
  else
    search_comment(@start, @end + 1, theme_keywords(theme), col1, col2)
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

def checkbox_search_all(theme, d_start, d_end, source, sentiment)
  post_result = Post.ransack(created_at_gt: d_start, created_at_lt: d_end + 1, title_or_content_cont_any: theme_keywords(theme), sentiment_cont: sentiment).result.joins(board: :source).where(boards: { sources: { name: source } })

  comment_search = Comment.joins(post: [board: :source]).where(comments: { posts: { boards: { sources: { name: source } } } }).ransack(created_at_gt: d_start, created_at_lt: d_end + 1).result

  comment_result = comment_search.ransack(content_cont_any: theme_keywords(theme), sentiment_cont: sentiment).result.or(comment_search.where(:pid => post_result.pluck(:pid)))
  return post_result, comment_result
end
