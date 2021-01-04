class Comment < ApplicationRecord
  belongs_to :post, class_name: "Post", foreign_key: "pid", primary_key: "pid"
  has_one :comment_token, class_name: "CommentToken", foreign_key: "cid", primary_key: "cid"
  has_one :comment_sentiment, class_name: "CommentSentiment", foreign_key: "cid", primary_key: "cid"
  has_one :comment_keyword, class_name: "CommentKeyword", foreign_key: "cid", primary_key: "cid"
  has_one :comment_clean, class_name: "CommentClean", foreign_key: "cid", primary_key: "cid"
end
