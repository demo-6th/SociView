# coding=utf-8
from wordcloud import WordCloud
import pandas as pd
import ast
from matplotlib import pyplot as plt
import os
pd.options.mode.chained_assignment = None
import sys 
from pathlib import Path

rails_root = sys.argv[1]

for p in Path(f"{rails_root}/public/images").glob("wordcloud.png"):
    p.unlink()

txt = pd.read_csv(f"{rails_root}/data/cloud_text.csv",names=["id", "no_stop"])
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
  cloud = WordCloud(width=960, height=400,background_color='white',font_path=f"{rails_root}/app/assets/fonts/TaipeiSansTCBeta-Regular.ttf").generate(txt_str)
  cloud.to_file(f'{rails_root}/public/images/wordcloud.png')


