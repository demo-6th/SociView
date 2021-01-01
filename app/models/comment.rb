class Comment < ApplicationRecord
  belongs_to :post, class_name: "Post", foreign_key: "pid", primary_key: "pid"
  has_one :comment_token, class_name: "Comment_token", foreign_key: "cid", primary_key: "cid"
  has_one :comment_sentiment, class_name: "Comment_sentiment", foreign_key: "cid", primary_key: "cid"
  has_one :comment_keyword, class_name: "Comment_keyword", foreign_key: "cid", primary_key: "cid"
  has_one :comment_clean, class_name: "Comment_clean", foreign_key: "cid", primary_key: "cid"
end
