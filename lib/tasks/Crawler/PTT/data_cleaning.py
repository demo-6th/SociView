#coding=utf-8
import pandas as pd
import re
from collections import Counter
from ckip import CkipSegmenter
import time 
import numpy as np
from tqdm import tqdm
from datetime import datetime
import ast

# remove set copy warning 
pd.options.mode.chained_assignment = None
segmenter = CkipSegmenter()

board = pd.read_csv("lib/tasks/Crawler/PTT/boards_url.csv", names = ["url"])
post = pd.read_csv("lib/tasks/Crawler/PTT/post_content.csv", names = ["alias","url","author","title", "created_at", "comment_count","content"])
comment = pd.read_csv("lib/tasks/Crawler/PTT/comment_content.csv", names = ["alias", "url", "author", "created_at","content"])

# drop 欄位對不上的資料
post = post.dropna()
comment = comment.dropna()

# board: url name alias 
board["name"] = board["url"].str.replace("https://www.ptt.cc//bbs/", "")
board["name"] = board["name"].str.replace("/index.html","")
board["alias"] = 'ptt_' + board["name"].str[:]
board["name"] = board["alias"]
board["source"] = 2

# post:  alias pid 
post["alias"] = post["alias"].str.replace("看板 ","ptt_")
post["pid"] = post["url"].str.extract(r'M\.(.*?)\.A')

def post_time(string):
  try:
    return datetime.strptime(string,"%a %b %d %H:%M:%S %Y")
  except:
    return ""

def comment_time(string):
  try:
    return datetime.strptime(string,"%m/%d %H:%M")
  except:
    return ""

post["created_at"] = post.created_at.apply(post_time)

#comment 
comment["alias"] = comment["alias"].str.replace("看板 ","ptt_")
comment["pid"] = comment["url"].str.extract(r'M\.(.*?)\.A')
comment["created_at"] = comment["created_at"].str.strip(" ")
comment["created_at"]  = comment["created_at"].str.replace("\n","")
comment["created_at"] = comment.created_at.apply(comment_time)

# 把comment的年份換成他主文的發文日期年份
for i in range(len(comment)):
  try:
    comment["created_at"][i] = comment.created_at[i].replace(year = post.loc[post.pid == comment.pid[i]].created_at.values[0].astype('datetime64[Y]').astype(int) + 1970)
  except:
    # print(comment["created_at"][i])
    comment["created_at"][i] = ""
    
# clean symbols and spaces 
def cleaning(string):
  if type(string) == str:
    clean_txt = "".join(re.findall(r"[\u4E00-\u9FFF]",string))
  else:
    clean_txt = ""
  return clean_txt

# ckip_seg 
def ckip_seg(post):
  try:
    if len(post) > 1:
      result = segmenter.seg(post)
      result_list = [result.tok, result.pos]
      return result_list
    else:
      return post
  except:
      return ""

# ast 
def ast_lit(string):
  result = ast.literal_eval(string)
  return result

# split columns
def token(seg_list):
  try:
    seg_list = seg_list
    return seg_list[0]
  except:
    return ""

def pos_tagging(seg_list):
  try:
    seg_list = seg_list
    return seg_list[1]
  except:
    return ""

# stopwords 
with open("lib/tasks/Crawler/PTT/dict/stopwords.txt", encoding="utf-8") as fin:
  stopwords = fin.read().split("\n")[1:]

def no_stop(item):
  no_stop = [x for x in item if x not in stopwords]
  return no_stop

# keywords (for docs more than 100 words)
def keyword(doc):
  keywords = []
  if len(doc) > 100:
    word_count = Counter(doc)
    for w, c in word_count.most_common(3):
      keywords.append(w)
  return keywords

# sentiment 
with open("lib/tasks/Crawler/PTT/dict/pos.txt", encoding="utf-8") as pos:
  pos_words = pos.read().split("\n")[1:]

with open("lib/tasks/Crawler/PTT/dict/neg.txt", encoding="utf-8") as neg:
  neg_words = neg.read().split("\n")[1:]

def sentiment(token):
  pos = 0
  neg = 0
  for i in token:
    if i in pos_words:
      pos += 1
    elif  i in neg_words:
      neg += 1
  if pos == 0 and neg == 0:
    return "neutral"
  elif pos > neg:
    return "positive"
  else:
    return "negative"

tqdm.pandas(desc="post_clean_txt loading... ")
post["clean_txt"] = post.content.progress_apply(cleaning)
tqdm.pandas(desc="comment_clean_txt loading... ")
comment["clean_txt"] = comment.content.progress_apply(cleaning)

tqdm.pandas(desc="post_ckip_seg loading... ")
post["seg"] = post.clean_txt.progress_apply(ckip_seg)
tqdm.pandas(desc="comment_ckip_seg loading... ")
comment["seg"] = comment.clean_txt.progress_apply(ckip_seg)

tqdm.pandas(desc="post_token loading... ")
post["token"] = post.seg.progress_apply(token)
tqdm.pandas(desc="comment_token loading... ")
comment["token"] = comment.seg.progress_apply(token)

tqdm.pandas(desc="post_token loading... ")
post["pos"] = post.seg.progress_apply(pos_tagging)
tqdm.pandas(desc="comment_token loading... ")
comment["pos"] = comment.seg.progress_apply(pos_tagging)

tqdm.pandas(desc="post_no_stop loading... ")
post["no_stop"] = post.token.progress_apply(no_stop)
tqdm.pandas(desc="comment_no_stop loading... ")
comment["no_stop"] = comment.token.progress_apply(no_stop)

tqdm.pandas(desc="post_keywords loading... ")
post["keywords"] = post.no_stop.progress_apply(keyword)
tqdm.pandas(desc="comment_keywords loading... ")
comment["keywords"] = comment.no_stop.progress_apply(keyword)

tqdm.pandas(desc="post_sentiment loading... ")
post["sentiment"] = post.token.progress_apply(sentiment)
tqdm.pandas(desc="comment_sentiment loading... ")
comment["sentiment"] = comment.token.progress_apply(sentiment)

# dataframe cleanup 
post = post.drop(['seg'], axis=1)
comment = comment.drop(['seg'], axis=1)

# save as csv
board.to_csv("lib/tasks/Crawler/PTT/boards_url.csv",header=False)
post.to_csv("lib/tasks/Crawler/PTT/post_content.csv",header=False)
comment.to_csv("lib/tasks/Crawler/PTT/comment_content.csv",header=False)

