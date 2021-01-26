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
  print("您所選擇區間資料過少，請重新選擇")
else:
  cloud = WordCloud(width=1400, height=500,background_color='white',random_state=123,colormap='ocean',font_path="app/assets/fonts/TaipeiSansTCBeta-Regular.ttf").generate(txt_str)
  cloud.to_file('app/assets/images/wordcloud.png')

