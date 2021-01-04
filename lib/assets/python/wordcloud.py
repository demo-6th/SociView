# coding=utf-8
from wordcloud import WordCloud
import pandas as pd
import ast
from matplotlib import pyplot as plt
# 在rails裡面要寫成相對於rails專案的路徑
txt = pd.read_csv("./lib/assets/python/clean-txt-tokenized.csv")
print("start wordcloud")
# 製作成空格分開的大字串
txt_str = ""
for i in range(len(txt)):
  txt["token_text"][i] = ast.literal_eval(txt["token_text"][i])
  txt_str += ' '.join(txt["token_text"][i])

# print(txt_str)
cloud = WordCloud(font_path="./lib/assets/python/TaipeiSansTCBeta-Regular.ttf").generate(txt_str)
print("wordcloud finished")
cloud.to_file('app/assets/images/wordcloud.png')


# print(cloud)