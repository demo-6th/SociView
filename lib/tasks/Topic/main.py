# coding=utf-8
from gensim import matutils, models, corpora
import pyLDAvis.gensim
import pandas as pd
import scipy.sparse
import importlib
from sklearn.feature_extraction.text import CountVectorizer

data = pd.read_csv("data/topic_text.csv",names=["id", "token"])
count_vec = CountVectorizer(max_df = 0.85, min_df = 2) 
data["token"].fillna(" ")
data_cv = count_vec.fit_transform(data["token"].values.astype('U')) 
data_dtm = pd.DataFrame(data_cv.toarray(), columns = count_vec.get_feature_names())
tdm = data_dtm.transpose()
sparse_counts = scipy.sparse.csr_matrix(tdm)
corpus = matutils.Sparse2Corpus(sparse_counts)
id2word = dict((v, k) for k, v in count_vec.vocabulary_.items())
word2id = dict((k, v) for k, v in count_vec.vocabulary_.items())
d = corpora.Dictionary()
d.id2token = id2word
d.token2id = word2id
lda = models.LdaModel(corpus = corpus, id2word = id2word, num_topics = 10, passes= 5, minimum_probability=0.01,random_state=123)
lda_vis = pyLDAvis.gensim.prepare(lda, corpus, d)
# pyLDAvis.display(lda_vis)
pyLDAvis.save_html(lda_vis,"app/views/shared/_ldavis.html")