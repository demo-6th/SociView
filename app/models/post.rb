class Post < ApplicationRecord
  has_many :comments, class_name: "Comment", foreign_key: "pid", primary_key: "pid"
  belongs_to :board, class_name: "Board", foreign_key: "alias", primary_key: "alias"
  has_one :post_token, class_name: "Post_token", foreign_key: "pid", primary_key: "pid"
  has_one :post_sentiment, class_name: "Post_sentiment", foreign_key: "pid", primary_key: "pid"
  has_one :post_keyword, class_name: "Post_keyword", foreign_key: "pid", primary_key: "pid"
  has_one :post_clean, class_name: "Post_clean", foreign_key: "pid", primary_key: "pid"
end
