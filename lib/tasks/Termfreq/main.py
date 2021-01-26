# coding=utf-8
import pandas as pd
import ast
from matplotlib import pyplot as plt
import os
from collections import Counter
import csv
import sys 

rails_root = sys.argv[1]

pd.options.mode.chained_assignment = None

data = pd.read_csv(f"{rails_root}data/tf_data.csv",names=["token", "pos"])

data = data.dropna()
data.reset_index(inplace=True)
data = data.drop(['index'], axis=1)

if os.path.exists(f"{rails_root}/data/tf_V.csv"):
  os.remove(f"{rails_root}/data/tf_V.csv")
if os.path.exists(f"{rails_root}/data/tf_N.csv"):
  os.remove(f"{rails_root}/data/tf_N.csv")
if os.path.exists(f"{rails_root}/data/tf_A.csv"):
  os.remove(f"{rails_root}/data/tf_A.csv")


for i in range(len(data)):
  try:
    data["token"][i] = ast.literal_eval(data["token"][i])
    data["pos"][i] = ast.literal_eval(data["pos"][i])
  except:
    continue

with open(f"{rails_root}/data/dict/stopwords.txt", encoding="utf-8") as fin:
    stopwords = fin.read().split("\n")[1:]

# V, N, A
def pos_counter(data, pos_type):
  result = []

  for i in range(len(data)):
    for n in range(len(data.pos[i])):
      if data.pos[i][n].startswith(pos_type) and data.token[i][n] not in stopwords:
        result.append(data.token[i][n])
    count = Counter(result).most_common(15)

  with open(f'{rails_root}/data/tf_'+pos_type+'.csv','w') as csvfile:
    writer=csv.writer(csvfile)
    writer.writerows(count)
  # transpose csv
  pd.read_csv(f'{rails_root}/data/tf_'+pos_type+'.csv', header=None).T.to_csv(f'{rails_root}/data/tf_'+pos_type+'.csv', header=False, index=False)

if len(data) < 20:
  print("您所選擇區間資料過少，請重新選擇")
else:
  pos_counter(data, "V")
  pos_counter(data, "N")
  pos_counter(data, "A")