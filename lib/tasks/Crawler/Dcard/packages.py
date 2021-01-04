#coding=utf-8
import sys
import subprocess

# implement pip as a subprocess:
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'requests'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pandas'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'Counter'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'ckip-segmenter'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'tqdm'])