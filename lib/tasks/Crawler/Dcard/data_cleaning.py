#coding=utf-8
import pandas as pd
import re
from collections import Counter
from ckip import CkipSegmenter
import time 
import numpy as np
from tqdm import tqdm
# remove set copy warning 
pd.options.mode.chained_assignment = None
segmenter = CkipSegmenter()

forum = pd.read_csv("data/forums.csv",names = ["board_name","alias","board_url"])
post_id = pd.read_csv("data/post_id.csv", names = ["post_id","post_title","board_name","alias"])
post = pd.read_csv("data/post_content.csv", names = ["post_id","post_content","post_title","created_at", "updated_at", "comment_count","like_count","gender"])
comment = pd.read_csv("data/post_comment.csv", names = ["comment_id", "post_id","created_at", "updated_at","floor", "comment_content","like_count", "gender"])

def get_alias_by_id(p_id):
  p_id = p_id
  alias = post_id.loc[post_id.post_id == p_id].alias.values[0]
  return alias

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
with open("data/dict/stopwords.txt", encoding="utf-8") as fin:
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
with open("data/dict/pos.txt", encoding="utf-8") as pos:
  pos_words = pos.read().split("\n")[1:]

with open("data/dict/neg.txt", encoding="utf-8") as neg:
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

tqdm.pandas(desc="post_alias loading... ")
post["alias"] = post.post_id.progress_apply(get_alias_by_id)
tqdm.pandas(desc="comment_alias loading... ")
comment["alias"] = comment.post_id.progress_apply(get_alias_by_id)
post["url"] = post.alias
comment["url"] = comment.post_id

for i in range(len(post)):
  post["url"][i] = "https://www.dcard.tw/f/" + str(post["alias"][i]) + "/p/" + str(post["post_id"][i])
for i in range(len(comment)):
  comment["url"][i] = "https://www.dcard.tw/f/" + str(comment["alias"][i]) + "/p/" + str(comment["post_id"][i])

post["source"] = "dcard"
comment["source"] = "dcard"
post["type"] = "post"
comment["type"] = "comment"

tqdm.pandas(desc="post_clean_txt loading... ")
post["clean_txt"] = post.post_content.progress_apply(cleaning)
tqdm.pandas(desc="comment_clean_txt loading... ")
comment["clean_txt"] = comment.comment_content.progress_apply(cleaning)

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
post_id.to_csv("data/post_id.csv",header=False)
post.to_csv("data/post_content.csv",header=False)
comment.to_csv("data/post_comment.csv",header=False)