class Post < ApplicationRecord
  has_many :comments, class_name: "Comment", foreign_key: "pid", primary_key: "pid"
  belongs_to :board, class_name: "Board", foreign_key: "alias", primary_key: "alias"
  has_one :post_token, class_name: "PostToken", foreign_key: "pid", primary_key: "pid"
  has_one :post_sentiment, class_name: "PostSentiment", foreign_key: "pid", primary_key: "pid"
  has_one :post_keyword, class_name: "PostKeyword", foreign_key: "pid", primary_key: "pid"
  has_one :post_clean, class_name: "PostClean", foreign_key: "pid", primary_key: "pid"
end
