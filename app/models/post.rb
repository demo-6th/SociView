class Post < ApplicationRecord
  has_many :comments
  belongs_to :board, foreign_key: "alias", primary_key: "alias"
  has_one :post_token
  has_one :post_sentiment
  has_one :post_keyword
  has_one :post_clean
  has_one :post_keep_word
end
