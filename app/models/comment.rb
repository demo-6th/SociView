class Comment < ApplicationRecord
  belongs_to :post, class_name: "Post", foreign_key: "pid", primary_key: "pid"
  # has_one :comment_token, :comment_sentiment, :comment_keyword, :comment_clean
end
