class Post < ApplicationRecord
  has_many :comments
  belongs_to :board
  has_one :post_token, :post_sentiman, :post_keyword, :post_clean
end
