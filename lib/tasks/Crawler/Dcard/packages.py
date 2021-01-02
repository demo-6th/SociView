#coding=utf-8
import sys
import subprocess

print("=====[你正在使用的python是"+str(sys.executable)+"]=====")
# implement pip as a subprocess:
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pandas'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'Counter'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'ckip-segmenter'])
subprocess.check_call([sys.executable, '-m', 'pip3', 'install', 'tqdm'])

print("=====[successfully installed python packages.]=====")