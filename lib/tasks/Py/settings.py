#coding=utf-8
import sys
import subprocess

subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'importlib'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'cloudpickle'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'requests'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pandas'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'Counter'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'ckip-segmenter'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'tqdm'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'requests'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'wordcloud'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'matplotlib'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'gensim'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pyLDAvis'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'scipy'])
subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'sklearn'])
