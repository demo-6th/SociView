# coding=utf-8
from wordcloud import WordCloud
import pandas as pd
import ast
from matplotlib import pyplot as plt
pd.options.mode.chained_assignment = None

txt = pd.read_csv("data/cloud_text.csv",names=["id", "token"])

txt_str = ""
for i in range(len(txt)):
  try:
    txt["token"][i] = ast.literal_eval(txt["token"][i])
    txt_str += ' '.join(txt["token"][i])
  except:
    continue

cloud = WordCloud(background_color='white',font_path="app/assets/fonts/TaipeiSansTCBeta-Regular.ttf").generate(txt_str)
cloud.to_file('app/javascript/images/wordcloud.png')
