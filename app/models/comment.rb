class Comment < ApplicationRecord
  belongs_to :post
  has_one :comment_token
  has_one :comment_sentiment
  has_one :comment_keyword
  has_one :comment_clean
  has_one :post_keep_word
end
