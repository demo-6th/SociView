class Comment < ApplicationRecord
  belongs_to :post
  has_one :comment_token, :comment_sentiment, :comment_keyword, :comment_clean
end
