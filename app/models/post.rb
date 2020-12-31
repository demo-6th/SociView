class Post < ApplicationRecord
  has_many :comments, class_name: "Comment", foreign_key: "pid", primary_key: "pid"
  belongs_to :board, class_name: "Board", foreign_key: "alias", primary_key: "alias"
  # has_one :post_token, :post_sentiman, :post_keyword, :post_clean
end
