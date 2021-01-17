# coding=utf-8
from wordcloud import WordCloud
import pandas as pd
import ast
from matplotlib import pyplot as plt
import os
pd.options.mode.chained_assignment = None

if os.path.exists("app/assets/images/wordcloud.png"):
  os.remove("app/assets/images/wordcloud.png")

txt = pd.read_csv("data/cloud_text.csv",names=["id", "no_stop"])
txt_str = ""

for i in range(len(txt)):
  try:
    txt["no_stop"][i] = ast.literal_eval(txt["no_stop"][i])
    txt_str += ' '.join(txt["no_stop"][i])
  except:
    continue

if len(txt_str) < 50:
  print("資料不足")
else:
  cloud = WordCloud(width=960, height=400,background_color='white',font_path="app/assets/fonts/TaipeiSansTCBeta-Regular.ttf").generate(txt_str)
  cloud.to_file('app/assets/images/wordcloud.png')

