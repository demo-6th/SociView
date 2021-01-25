
# topic keywords array
def theme_keywords(theme)
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
    search_all(@start.midnight, @end.end_of_day, theme_keywords(@theme),source(@source), col1, col2)
  elsif array.include?("主文") 
    search_post(@start.midnight, @end.end_of_day, theme_keywords(@theme),source(@source), col1, col2)
  else 
    search_comment(@start.midnight, @end.end_of_day, theme_keywords(@theme),source(@source), col1, col2)
  end 
end 

# search_post (@start, @end, topic(@theme), source(@source))
def search_post(start_date,end_date,keywords,source,col1, col2)
  result = Post.ransack(created_at_gt: start_date,created_at_lt: end_date, alias_in: Board.ransack(source_id_in:source).result.pluck(:alias), title_or_content_cont_any:keywords).result
  return result.select(col1,col2), result.count
end 

# search_comment
def search_comment(start_date,end_date,keywords,source,col1, col2)
  # comment content itself contains the keyword + comments under posts that matches the topic & drop repeated comments
  
  return result.select(col1,col2), result.count
end 

def search_all(start_date,end_date,keywords,source, col1, col2)
  count = search_post(start_date, end_date, keywords,source, col1, col2)[1]+search_comment(start_date, end_date, keywords,source, col1, col2)[1]
  result = search_post(start_date, end_date, keywords,source, col1, col2)[0]|search_comment(start_date, end_date, keywords,source, col1, col2)[0]
  return result, count 
end 

# comment content itself contains the keyword + comments under posts that matches the topic & drop repeated comments
# Comment.ransack(pid_in:Post.ransack(created_at_gt: start_date,created_at_lt: end_date, alias_in: Board.ransack(source_id_in:source).result.pluck(:alias), title_or_content_cont_any:keywords).result.pluck(:pid)).result

# Comment.ransack(created_at_gt: start_date,created_at_lt: end_date, alias_in: Board.ransack(source_id_in:source).result.pluck(:alias), content_cont_any:keywords).result


